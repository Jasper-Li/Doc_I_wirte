# 1. 权限
gpedit.msc进入本地组策略编辑器, 选择管理模板-Windows组件-远程桌面服务-远程桌面会话主机-连接, 
修改限制连接的数量 -> 设置多个
将远程桌面服务用户限制到单独的远程桌面服务会话-> 启用

# 2. rdpwrap
https://github.com/stascorp/rdpwrap/releases/tag/v1.6.2
下载后依次运行install.bat， update.bat,RDPConf.exe 
在 RDPConf.exe 中应为 full supported.
* 问题 win 10 版本更新, not supported
在 issue https://github.com/stascorp/rdpwrap/issues 中搜索版本号 
10.0.18336.657
10.0.18362.267，找到解决方案
更新了这个 ini 文件后，重启，可多用户。

