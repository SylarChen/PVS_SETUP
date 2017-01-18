yum install net-tools

#Ask shadowsocks configuration
echo "=========================================================================="
default_ip=$(/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:")
echo "> Please input your VPS ip (default $default_ip):"
read -e -i "$default_ip" vps_ip

default_shadow_socks_port=2223
echo "> Please input the ShadowSocks port you want to expose on your VPS (best greater than 1024, default $default_shadow_socks_port):"
read -e -i "$default_shadow_socks_port" shadow_socks_port

default_shadow_socks_password=Admin111
echo "> Please input the password connect to your ShadowSocks service (default $default_shadow_socks_password):"
read -e -i "$default_shadow_socks_password" shadow_socks_password

shadow_socks_config="{
  \"server\":\"$vps_ip\",
  \"server_port\":$shadow_socks_port,
  \"local_port\":1080,
  \"password\":\"$shadow_socks_password\",
  \"timeout\":120,
  \"method\":\"aes-256-cfb\"
}"

echo "############ ShadowSocks configuration ###########"
echo $shadow_socks_config

echo ""
echo -n "> Please confirm the ShadowSocks configuration above [y/n]:"
read input
ret=`echo $input | tr '[a-z]' '[A-Z]' | cut -c1`

echo ""
if [ $ret = "Y" ]; then
        echo "Start to install ShadowSocks..."
else
        echo "Exit..."
        exit 0
fi

echo $shadow_socks_config > ./config.json


#install pip
curl https://bootstrap.pypa.io/get-pip.py | python

#install shadowsocks
pip install shadowsocks

#stop anyway
ssserver -d stop

ssserver -c ./config.json -d start