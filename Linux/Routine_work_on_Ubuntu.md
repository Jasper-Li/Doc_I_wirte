# 1. app need to install
## 1.1 dev
```
git
```
## 1.2 daily work
```
vim vim-gnome p7zip-full synaptic smplayer doublecmd-gtk 
``` 

# 2. change default system to Windows
configure file: /etc/default/grub
menuentry lists: /boot/grub/grub.cfg


# 3. Windows time change.
## 3.1 check current status
```bash
timedatectl status
                      Local time: 二 2019-01-22 21:05:13 CST
                  Universal time: 二 2019-01-22 13:05:13 UTC
                        RTC time: 二 2019-01-22 13:05:13
                       Time zone: Asia/Shanghai (CST, +0800)
       System clock synchronized: yes
systemd-timesyncd.service active: yes
                 RTC in local TZ: no
```
set window side

# 4. auto mount
/etc/fstab

# 5. vim rc
# 6. office 
libre-office
# 7. chinese support
sudo apt-get install ibus-rime
# 8. smplayer 中文乱码
选项—首选项—字幕—字幕，将默认字幕编码改为简体中文(CP936)
