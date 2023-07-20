cd ~
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
pkg install proot git python -y
git clone https://gitee.com/Le-niao/termux-install-linux.git
echo echo 正在启动ubuntu > $PREFIX/bin/u 
sed -i -e '1a cd ~/Termux-Linux/Ubuntu' $PREFIX/bin/u
sed -i -e '2a ./start-ubuntu.sh' $PREFIX/bin/u
chmod 777 $PREFIX/bin/u
#安装ubuntu
cd termux-install-linux
yes 1 |python termux-linux-install.py