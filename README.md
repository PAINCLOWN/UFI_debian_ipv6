# UFI_debian_ipv6
开启UFI debian的ipv6

中途需要手动输入一下br0指定一下网卡 
#一定要在adb shell中执行！
因为ssh会因为配置变动中断


梭哈：
```
apt update
apt -y install git 
git clone https://github.com/PAINCLOWN/UFI_debian_ipv6.git 
cd UFI_debian_ipv6 
chmod +x debain_get_ipv6.sh 
sh debain_get_ipv6.sh
```

国内：
```
apt update
apt -y install git 
git clone https://ghproxy.com/https://github.com/PAINCLOWN/UFI_debian_ipv6.git 
cd UFI_debian_ipv6 
chmod +x debain_get_ipv6.sh 
sh debain_get_ipv6.sh
```

