# UFI_debian_ipv6
开启UFI debian的ipv6

中途需要手动输入一下br0指定一下网卡 


**一定要在adb shell中执行！**
**因为ssh会因为配置变动中断**


命令：

```
apt update
apt -y install git 
git clone https://github.com/PAINCLOWN/UFI_debian_ipv6.git 
cd UFI_debian_ipv6 
chmod +x debain-get-ipv6.sh 
sh debain-get-ipv6.sh
```

命令（国内）：

```
apt update
apt -y install git 
git clone https://ghproxy.com/https://github.com/PAINCLOWN/UFI_debian_ipv6.git 
cd UFI_debian_ipv6 
chmod +x debain-get-ipv6.sh 
sh debain-get-ipv6.sh
```


一键梭哈：

```
apt update && apt -y install git && git clone https://ghproxy.com/https://github.com/PAINCLOWN/UFI_debian_ipv6.git && cd UFI_debian_ipv6 && chmod +x debain-get-ipv6.sh && sh debain-get-ipv6.sh
```


 **Q&A**
 
 
出现一下情况，直接回车，adb shell 的问题
![image](https://user-images.githubusercontent.com/29433774/236858403-082a77be-9532-4dbd-ba1e-65fc564f5580.png)




出现以下问题，是apt被占用了，可以reboot重启试试（脚本结束会自动重启）
![image](https://user-images.githubusercontent.com/29433774/236858855-8dc60081-026a-499c-b5a9-5d69adec24a7.png)
