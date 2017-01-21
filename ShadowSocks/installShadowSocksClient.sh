#install pip
curl https://bootstrap.pypa.io/get-pip.py | python

# install cliebt
pip install shadowsocks

sslocal -s 104.194.69.242 -p 2223 -b 127.0.0.1 -l 1080 -k sylarchen -t 600 -m aes-256-cfb

sslocal -c config.json -v

