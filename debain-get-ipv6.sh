#!/bin/bash

echo "Author:PIANCLOWN"
nmcli c del br0 wifi wlan0 usb0 usb USB bridge usb-share 
nmcli c add type bridge ifname br0 con-name br0 ipv4.method manual ipv4.addresses 192.168.68.1/24 ipv4.dns '223.5.5.5'
nmcli c add type ethernet ifname usb0 con-name usb
nmcli c add type  wifi  ifname wlan0 con-name wlan0   ssid @sudo_LTE mode ap master br0
nmcli c add type bridge-slave ifname usb0 con-name usb0 master br0
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.forwarding=1" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.proxy_ndp=1" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.accept_ra=2" >> /etc/sysctl.conf
sysctl -p
nmcli connection up br0
systemctl enable dnsmasq.service
systemctl start dnsmasq.service
nmcli connection show
nmcli connection up usb0
nmcli connection up wlan0
systemctl enable dnsmasq.service
systemctl start dnsmasq.service
nmcli c modify br0 ipv6.method ignore
nmcli c modify wlan0 wifi-sec.key-mgmt wpa-psk
nmcli c modify wlan0 wifi-sec.psk "741852abc"
echo "sleep 5"
sleep 5
echo "go on"
cat >/etc/apt/sources.list<<EOF
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free
deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free
deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free
deb-src http://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free

# deb http://security.debian.org/debian-security bullseye-security main contrib non-free
# deb-src http://security.debian.org/debian-security bullseye-security main contrib non-free
EOF
apt-get  -y  update
apt-get -y install ndppd radvd wide-dhcpv6-server iproute2
cat>/etc/NetworkManager/dispatcher.d/ipv6-conf.sh<<EOF
#!/usr/bin/env bash
interface=\$1
event=\$2
echo "\$interface" >> /tmp/ipv6-conf.log
if [ "\$interface" == "wwan0" ]; then
        prefix=\$(ip -6 addr show dev wwan0| sed -e's/^.*inet6 \([^ ]*\)\/.*$/\1/;t;d'|head -n 1|cut -f'1-4' -d':')
        # just assume prefix length /64 here
        echo "get prefix \$prefix::/64"|systemd-cat -t ipv6_conf
        cp /etc/ndppd.conf.bak /etc/ndppd.conf
        sed -i "s/REPLACE_PREFIX_HERE/\$prefix:2333::\/80/g" /etc/ndppd.conf
        cp /etc/radvd.conf.bak /etc/radvd.conf
        sed -i "s/REPLACE_PREFIX_HERE/\$prefix:2333::\/64/g" /etc/radvd.conf
        cp /etc/wide-dhcpv6/dhcp6s.conf.bak /etc/wide-dhcpv6/dhcp6s.conf
        sed -i "s/PREFIX_MIN/\$prefix:2333::2000/g" /etc/wide-dhcpv6/dhcp6s.conf
        sed -i "s/PREFIX_MAX/\$prefix:2333::3000/g" /etc/wide-dhcpv6/dhcp6s.conf
        systemctl restart radvd
        systemctl restart ndppd
        systemctl stop wide-dhcpv6-server
        systemctl start wide-dhcpv6-server
        echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
        sleep 30
        echo "setting route" |systemd-cat -t ipv6_conf
        ip -6 addr add \$prefix:2333::1/80 dev br0
        ip -6 route add \$prefix::/65 dev br0
        ip -6 route add \$prefix:8000::/65 dev br0
        ip -6 route |systemd-cat -t ipv6_conf
        echo "ok" >> /tmp/ipv6-conf.log
fi
EOF
chmod 755 /etc/NetworkManager/dispatcher.d/ipv6-conf.sh
cat >/etc/ndppd.conf.bak<<EOF
proxy wwan0 {
    router yes
    timeout 500
    ttl 30000
    rule REPLACE_PREFIX_HERE {
auto
}
}
EOF
cat >/etc/radvd.conf.bak<<EOF
interface br0 {
        AdvSendAdvert on;
        AdvOtherConfigFlag on;
        AdvManagedFlag on;
        MinRtrAdvInterval 3;
        MaxRtrAdvInterval 10;
        prefix REPLACE_PREFIX_HERE {
                AdvOnLink on;
                AdvAutonomous on;
                AdvRouterAddr off;
        };
};
EOF
cat >/etc/wide-dhcpv6/dhcp6s.conf.bak<<EOF
interface br0 {
        address-pool pool1 3600;
};
pool pool1 {
        range PREFIX_MIN to PREFIX_MAX ;
};
EOF
sleep 5
echo "end"
sleep 2
reboot
