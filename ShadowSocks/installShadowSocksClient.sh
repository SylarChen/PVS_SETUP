#install pip
curl https://bootstrap.pypa.io/get-pip.py | python

# install cliebt
pip install shadowsocks

sslocal -s ****** -p 2223 -b 127.0.0.1 -l 1080 -k ****** -t 600 -m aes-256-cfb

sslocal -c config.json -v

