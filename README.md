# UFI_debian_ipv6
开启UFI debian的ipv6
![image](https://user-images.githubusercontent.com/29433774/236867501-58f5799f-5077-48d9-a537-74f547afdc95.png)

中途需要手动输入一下br0指定一下网卡 
![image](https://user-images.githubusercontent.com/29433774/236862281-c60bf2c7-634f-45fd-a6ff-6608fc260c12.png)


**一定要在adb shell中执行！**
**不然ssh连接会断掉，看不到后续控制台输出内容**


**提示：**


**脚本会创建一个热点，@sudo_LTE,密码741852abc,(可以自行去脚本里修改，或者跑完之后在nmtui修改)**



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
apt update;apt -y install git,rm -Rf UFI_debian_ipv6;git clone https://gitclone.com/github.com/PAINCLOWN/UFI_debian_ipv6.git;cd UFI_debian_ipv6&&chmod +x debain-get-ipv6.sh&&sh debain-get-ipv6.sh
```


 **Q&A**
 
 
出现一下情况，直接回车，adb shell 的问题
![image](https://user-images.githubusercontent.com/29433774/236858403-082a77be-9532-4dbd-ba1e-65fc564f5580.png)




出现以下问题，是apt被占用了，可以reboot重启试试（脚本结束会自动重启）
![image](https://user-images.githubusercontent.com/29433774/236858855-8dc60081-026a-499c-b5a9-5d69adec24a7.png)
