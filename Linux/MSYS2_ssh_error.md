# 1. Error Info
```
$ ssh -version
C:/msys64/usr/bin/ssh.exe: error while loading shared libraries: msys-crypto-1.1.dll: cannot open shared object file: No such file or directory
```
但是本地有的

/usr/bin/msys-crypt-0.dll

所以最终解决是升级了 msys2 。

