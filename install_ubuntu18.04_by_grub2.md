#使用 GRUB2 安装 Ubuntu 18.04 

使用 GRUB2 安装 Ubuntu 18.04 的原因是机器上已经有 Ubuntu 16.04 在了，GRUB 引导自然也是有的。
我以往常使用传统硬盘安装的方式, GRUB2 本身是硬盘安装的一种方式，只是引导器选择了GRUB2。
好处是只要有 ISO 的安装镜像就可以了,不需要像传统的方法从源里新下载适用于硬盘的引导 vmlinux & initrd, 它们俩一般在 hd-media 目录,如下是阿里云 Ubuntu 18.04 的路径。
>https://mirrors.aliyun.com/ubuntu/dists/bionic/main/installer-amd64/current/images/hd-media/

# 流程
0. 下载 Ubuntu 18.04 镜像，更名为 Ubuntu-18.04.iso, 放在某盘根目录。
1. 进入 GRUB2， 在界面按提示 C 进入 Command Mode
2. ls (hd**xx**, msdos**xx**)/, 寻找 Ubuntu-18.04.iso 的存放路径。本次为 (hd2, msdos1)
3. 执行指令
```
loopback loop (hd2, msdos1)/Ubuntu-18.04.iso
linux (loop)/casper/vmlinuz boot=casper iso-scan/filename=/Ubuntu-18.04.iso
initrd (loop)/casper/initrd.lz
boot
```
说明：

* (loop)后的路径，依据 vmlinuz & initrd.lz 实际的来。可以 tab 自动补全，或 ls 查看。
* linux 指令后，没有增加其它指令（quiet splash)。好处是在运行过程中，有 LOG 。解决了我因为打印机连接而 Pending 的问题。
