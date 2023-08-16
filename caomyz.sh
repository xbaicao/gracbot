#!/bin/bash

cd ~

function caoaboutmiaoyunzai()
{
	clear
    cat <<cao

1.部署喵版叽叽人

2.前台启动

3.关闭

cao
}
function storagenumber()
{
    read -p "输入对应数字并回车_" storagenumber
    case $storagenumber in
		0)
            exit 0
            ;;
        1)
            miaoyzinstall
            ;;
        2)
            start
            ;;
        3)  
            stop
            ;;
        *)
           clear
            echo
            figlet ?
            echo -e '\n'
            echo '你确定你输入对了ma'
            echo
            sleep 1s
            caoaboutmiaoyunzai
            storagenumber
            ;;
    esac
}
    
function miaoyzinstall()
{	
	clear
	echo '正在进行喵版叽叽人部署，别断网了'
    echo 'yunzai-install'
	sleep 3s

#git
    if ! type git >/dev/null 2>&1; then
        echo '准备安装git'
        echo 'apt install git -y'
	    sleep 0.5s
        apt update
        apt install git -y
        echo 'git装完'
        sleep 1s
    else
        echo '已经装过了，就不装了'
        sleep 1.5s
    fi
    
#nodejs
	if ! type npm >/dev/null 2>&1; then
        rm -rf /root/node
		echo '看起来没装过，要装一下'
        echo '准备安装nodejs'
	    sleep 0.5s
#下载nodejs
        git clone --depth=1 https://gitee.com/cao100/caobot.sh.git ./node/
        if [ $(uname -m) == "aarch64" ]; then
            cp /root/node/node-v17.9.0-linux-arm64.tar.gz /home/
            rm -rf /root/node
            cd /home/
#解压
            mkdir node17.9.0
            tar -zxvf node-v17.9.0-linux-arm64.tar.gz -C node17.9.0 --strip-components 1
            rm -rf node-v17.9.0-linux-arm64.tar.gz
        elif [ $(uname -m) == "x86_64" ]; then
            cp /root/node/node-v17.9.0-linux-x64.tar.gz /home/
            rm -rf /root/node
            cd /home/
#解压
            mkdir node17.9.0
            tar -zxvf node-v17.9.0-linux-x64.tar.gz -C node17.9.0 --strip-components 1
            rm -rf node-v17.9.0-linux-x64.tar.gz
        fi
        
#软链接
        ln -sf /home/node17.9.0/bin/node /usr/local/bin
        ln -sf /home/node17.9.0/bin/npm /usr/local/bin
        ln -sf /home/node17.9.0/bin/npx /usr/local/bin
        PATH=:/usr/local/node17.9.0/bin:$PATH
        if ! type npm >/dev/null 2>&1; then
            echo '安装失败了，重新用脚本试一下或者手装吧';
            exit
        else
            echo '安装成功'
            sleep 1.5s
        fi
    else
        echo '已经安装了，别重装了'
        sleep 1.5s
	fi

#redis
    if ! type redis-server >/dev/null 2>&1; then
        echo '安装并启动redis'
        echo 'apt-get install redis -y && redis-server --daemonize yes --save 900 1 --save 300 10'
	    sleep 0.5s
        apt-get install redis -y
        redis-server --daemonize yes --save 900 1 --save 300 10
        echo 'redis安装and启动'
	    sleep 1.5s
    else
        echo '已经装过了'
        redis-server --daemonize yes --save 900 1 --save 300 10
        echo '启动redis'
    fi

#安装chroimum
    if ! type chromium-browser >/dev/null 2>&1; then
	    echo '正在准备安装chromuim及中文字体'chro
	    sleep 0.5
        apt install chromium-browser -y
        apt install -y --force-yes --no-install-recommends fonts-wqy-microhei
	    echo '安装成功'
	    sleep 1.5s
    else
        echo 'chromium有了,开始装字体'
        sleep 0.5s
        apt install -y --force-yes --no-install-recommends fonts-wqy-microhei
        echo '安装成功'
        sleep 1.5s
    fi
    
#克隆项目
    cd ~/
	if [ -e Miao-Yunzai ];then
		echo -e '已有喵版叽叽人文件或同名文件\n请选择删除文件重新下载，或选择忽略'
		read -p '输入1删除并重新下载，输入0忽略（别忘记回车）：' number
		if [ $number == 1 ];then
			#删除文件夹
			echo '正在删除已有文件……'
			rm -rf Miao-Yunzai
			echo '删除完成'
			sleep 1s
			echo '重新部署喵版叽叽人项目'
			sleep 1s
			git clone --depth=1 https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git
			sleep 1s
			echo '喵版叽叽人项目部署完成'
		elif [ $number == 0 ];then
			echo '忽略，不重下项目文件'
		fi
	else
		echo '正在下载喵版叽叽人项目文件'
		sleep 1s
		git clone --depth=1 https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git
		echo '喵版叽叽人项目文件下完啦'
		sleep 3s
	fi

#安装依赖
    cd ~/Miao-Yunzai
	echo '开始装依赖'
    echo 'npm install pnpm -g'
	sleep 1s
    npm install pnpm -g
	ln -sf /home/node17.9.0/bin/pnpm /usr/local/bin
    pnpm install -P
    echo '喵版叽叽人依赖成功部署'
	sleep 1.5s
	
#检查云崽安装情况，若有就进行数据迁移
	if [ -e /root/Yunzai-Bot ];then
		echo '检查到已有云崽，是否迁移插件和数据？'
		read -p '请输入选项y/n：' options
		if [ $options == y ];then
#迁移插件
			mkdir /root/Miao-Yunzai/data
			rm -rf /root/Miao-Yunzai/plugins
			cp -r /root/Yunzai-Bot/plugins /root/Miao-Yunzai/
#迁移token等数据
			if [ -e /root/Yunzai-Bot/data/icqq ] && [ ! -e /root/Miao-Yunzai/data/icqq ];then
				cp -r /root/Yunzai-Bot/data/icqq /root/Miao-Yunzai/data
			fi
			if [ -e /root/Yunzai-Bot/data/MysCookie ] && [ ! -e /root/Miao-Yunzai/data/MysCookie ];then
				cp -r /root/Yunzai-Bot/data/MysCookie /root/Miao-Yunzai/data
			fi
			if [ -e /root/Yunzai-Bot/data/NoteData ] && [ ! -e /root/Miao-Yunzai/data/NoteData ];then
				cp -r /root/Yunzai-Bot/data /root/Miao-Yunzai/data
			fi
			if [ -e /root/Yunzai-Bot/data/UserData ] && [ ! -e /root/Miao-Yunzai/data/UserData ];then
				cp -r /root/Yunzai-Bot/data/UserData /root/Miao-Yunzai/data
			fi
			if [ -e /root/Yunzai-Bot/data/gachaJson ] && [ ! -e /root/Miao-Yunzai/data/gachaJson ];then
				cp -r /root/Yunzai-Bot/data/gachaJson /root/Miao-Yunzai/data
			fi
			echo '已成功迁移原云崽数据与插件！'
		elif [ $options == n ];then
			echo '取消迁移数据！'
		else
			echo '输入内容有误，默认不进行迁移，请后续自行手动迁移！'
		fi
	fi
	
#部署喵喵插件
	echo '准备装喵喵插件'
    sleep 1s
	cd ~/Miao-Yunzai/plugins
	if  [ -e miao-plugin ];then
	read -p '已经装过了，要删除重下吗，输入1重下，0忽略：' num
		if [ $num == 0 ];then
			echo 'ok那就忽略，不下了'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf miao-plugin
			git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git
			echo '已删除原文件重下'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git
		echo '装好了'
		sleep 1s
	fi
    cd ~/Miao-Yunzai && pnpm add image-size axios express multer body-parser jsonwebtoken systeminformation -w
	clear
    exit
}

#启动喵版叽叽人
function start()
{
	if [ -e /root/Miao-Yunzai ];then
    clear
    echo '喵版叽叽人，启动!'
    echo 'redis-server --daemonize yes --save 900 1 --save 300 10 && cd ~/Miao-Yunzai && node app'
	sleep 1s
	redis-server --daemonize yes --save 900 1 --save 300 10 && cd ~/Miao-Yunzai && node app
	else
	echo '先安装喵版叽叽人再说吧！'
	sleep 1s
	caoaboutmiaoyunzai
	storagenumber
	fi
}

#关闭喵版叽叽人
function stop()
{
	if [ -e /root/Miao-Yunzai ];then
	echo '正在关闭喵版叽叽人'
    echo 'cd ~/Miao-Yunzai && pnpm stop'    
	sleep 1s
	cd ~/Miao-Yunzai && pnpm stop
	else
	echo '你装喵版叽叽人了吗?'
	sleep 1s
	caoaboutmiaoyunzai
	storagenumber
	fi

#figlet要用到，不管咋样装上好了
if [ $(id -u) == 0 ];then
    if ! type figlet >/dev/null 2>&1; then
        apt-get update
        apt-get install figlet -y
    fi
        caoaboutmiaoyunzai
	    storagenumber		
else
    echo '运行环境出现问题咯'
    echo '手机用户确认容器状态，服务器用户确认root状态'
fi