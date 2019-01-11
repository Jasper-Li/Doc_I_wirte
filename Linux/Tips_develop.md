# 1. Linux
## 1.1 查看 Linux 中的可用 cc
```sh
update-alternatives --display cc
```
# 2. Makefile
## 2.1 Makefile 查看 C 编译器
```make
$(info CC is $(CC))
```
