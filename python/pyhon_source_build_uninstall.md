# source build

# uninstall from source build.
```
sudo apt-get install -y gcc make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev
```
## checkinstall
```
sudo apt-get install checkinstall  # install the checkinstall package
cd /home/user/Python-2.5.4
sudo checkinstall -D --fstrans=no make install   # make the deb package
sudo dpkg -i Python-2.5.4.deb   # reinstall python to /usr/local
sudo dpkg -r Python-2.5.4       # remove python from /usr/local
```
## setup.py
setup.py uninstall
