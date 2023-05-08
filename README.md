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
chmod +x debain-get-ipv6.sh 
sh debain-get-ipv6.sh
```

国内：
```
apt update
apt -y install git 
git clone https://ghproxy.com/https://github.com/PAINCLOWN/UFI_debian_ipv6.git 
cd UFI_debian_ipv6 
chmod +x debain-get-ipv6.sh 
sh debain-get-ipv6.sh
```



```
apt update && apt -y install git && git clone https://ghproxy.com/https://github.com/PAINCLOWN/UFI_debian_ipv6.git && cd UFI_debian_ipv6 && chmod +x debain-get-ipv6.sh && sh debain-get-ipv6.sh
```


Q&A
出现一下情况，直接回车，adb shell 的问题
![image](https://user-images.githubusercontent.com/29433774/236858403-082a77be-9532-4dbd-ba1e-65fc564f5580.png)
