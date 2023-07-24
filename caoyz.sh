#!/bin/bash

echo echo 前台启动rediis.叽叽人等... > /usr/bin/qd
    sed -i -e '1a redis-server --daemonize yes --save 900 1 --save 300 10 && cd ~/Yunzai-Bot && node app' /usr/bin/qd
    chmod 777 /usr/bin/qd
    echo echo 后台启动中... > /usr/bin/htqd
	sed -i -e '1a cd ~/Yunzai-Bot && pnpm start' /usr/bin/htqd
	chmod 777 /usr/bin/htqd
    echo echo 查看log > /usr/bin/log
    sed -i -e '1a cd ~/Yunzai-Bot && pnpm run log' /usr/bin/log 
    chmod 777 /usr/bin/log
    echo echo 停止叽叽人等下哦... > /usr/bin/stop
    sed -i -e '1a cd ~/Yunzai-Bot && pnpm stop' /usr/bin/stop
    chmod 777 /usr/bin/stop
    echo echo 启动脚本中 > /usr/bin/bc
    sed -i -e '1a bash <(curl -sL https://gitee.com/cao100/caoyz.sh/raw/master/caoyz.sh)' /usr/bin/bc
    chmod 777 /usr/bin/bc
cd ~

function caoaboutYunzai()
{
	clear
    cat <<cao

1.部署叽叽人
2.启动
3.关闭
4.查看快捷键
5.重置叽叽人登录
6.更换主人QQ
7.后台启动叽叽人
8.插件管理
9.安装ffmpeg
10.安装python3.10.0
0.退出
00.此项为百草测试项，误点请ctrl+c退出

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
            yzinstall
            ;;
        2)
            start
            ;;

        3)  
            stop
            ;;

        4)  
            shortcuts
            ;;

        5)
            resetbotqq
            ;;

        6)
            resetmasterqq
            ;;

        7)
            htstart
            ;;
        
        8)
            plugins
            ;;
        
        9)
            ffmpeginstall
            ;;

        10)
            pythoninstall3.10.0
            ;;

        00)
            caotest
            ;;

        999)
            test
            ;;
        *)
           clear
            echo
            figlet ?
            echo -e '\n'
            echo '你确定你输入对了ma'
            echo
            sleep 1s
            caoaboutYunzai
            storagenumber
            ;;
    esac
}
    
function yzinstall()
{	
	clear
	echo '正在进行叽叽人部署，别断网了'
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
        git clone --depth=1 https://gitee.com/cao100/caoyz.sh.git ./node/
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
	if [ -e Yunzai-Bot ];then
		echo -e '已有叽叽人文件或同名文件\n请选择删除文件重新下载，或选择忽略'
		read -p '输入1删除并重新下载，输入0忽略（别忘记回车）：' number
		if [ $number == 1 ];then
			#删除文件夹
			echo '正在删除已有文件……'
			rm -rf Yunzai-Bot
			echo '删除完成'
			sleep 1s
			echo '重新部署叽叽人项目'
			sleep 1s
			git clone --depth=1 https://gitee.com/yoimiya-kokomi/Yunzai-Bot.git
			sleep 1s
			echo '叽叽人项目部署完成'
		elif [ $number == 0 ];then
			echo '忽略，不重下项目文件'
		fi
	else
		echo '正在下载叽叽人项目文件'
		sleep 1s
		git clone --depth=1 https://gitee.com/yoimiya-kokomi/Yunzai-Bot.git
		echo '叽叽人项目文件下完啦'
		sleep 3s
	fi

#安装依赖
    cd ~/Yunzai-Bot
	echo '开始装依赖'
    echo 'npm install pnpm -g'
	sleep 1s
    npm install pnpm -g
	ln -sf /home/node17.9.0/bin/pnpm /usr/local/bin
    pnpm install -P
    echo '叽叽人依赖成功部署'
	sleep 1.5s
	
#部署喵喵插件
	echo '准备装喵喵插件'
    sleep 1s
	cd ~/Yunzai-Bot/plugins
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
    cd ~/Yunzai-Bot && pnpm add image-size axios express multer body-parser jsonwebtoken systeminformation -w
    
#启动快捷键 
    echo echo 前台启动redis.叽叽人等... > /usr/bin/qd
    sed -i -e '1a redis-server --daemonize yes --save 900 1 --save 300 10 && cd ~/Yunzai-Bot && node app' /usr/bin/qd
    chmod 777 /usr/bin/qd
    echo echo 后台启动中... > /usr/bin/htqd
	sed -i -e '1a cd ~/Yunzai-Bot && pnpm start' /usr/bin/htqd
	chmod 777 /usr/bin/htqd
    echo echo 查看log > /usr/bin/log
    sed -i -e '1a cd ~/Yunzai-Bot && pnpm run log' /usr/bin/log 
    chmod 777 /usr/bin/log
    echo echo 停止叽叽人等下哦 ...> /usr/bin/stop
    sed -i -e '1a cd ~/Yunzai-Bot && pnpm stop' /usr/bin/stop
    chmod 777 /usr/bin/stop
    echo echo 启动脚本中 > /usr/bin/bc
    sed -i -e '1a bash <(curl -sL https://gitee.com/cao100/caoyz.sh/raw/master/caoyz.sh)' /usr/bin/bc
    chmod 777 /usr/bin/bc
   
	clear
    exit
}

#启动叽叽人
function start()
{
	if [ -e /root/Yunzai-Bot ];then
    clear
    echo '叽叽人，启动!'
    echo 'redis-server --daemonize yes --save 900 1 --save 300 10 && cd ~/Yunzai-Bot && node app'
	sleep 1s
	redis-server --daemonize yes --save 900 1 --save 300 10 && cd ~/Yunzai-Bot && node app
	else
	echo '先安装叽叽人再说吧！'
	sleep 1s
	caoaboutYunzai
	storagenumber
	fi
}

#关闭叽叽人
function stop()
{
	if [ -e /root/Yunzai-Bot ];then
	echo '正在关闭叽叽人'
    echo 'cd ~/Yunzai-Bot && pnpm stop'    
	sleep 1s
	cd ~/Yunzai-Bot && pnpm stop
	else
	echo '你装叽叽人了吗?'
	sleep 1s
	caoaboutYunzai
	storagenumber
	fi
}

#查看快捷指令
function shortcuts()
{
	clear
	echo '——————————————'
	echo
	echo '以下是快捷指令'
	echo
	echo '——————————————'
	echo
    echo -e "启动脚本快捷键\033[47;31mbc\033[0m"
    echo -e "前台启动叽叽人\033[47;31mqd\033[0m"
    echo -e "后台启动叽叽人\033[47;31mhtqd\033[0m"
    echo -e "查看叽叽人日志\033[47;31mlog\033[0m"
    echo -e "停止叽叽人运行\033[47;31mstop\033[0m"
    echo
    echo
    read -s -n1 -p "按任意键或直接回车以返回"
    caoaboutYunzai
    storagenumber
}

#重置叽叽人登录
function resetbotqq()
{
    redis-server --daemonize yes --save 900 1 --save 300 10
    cd ~/Yunzai-Bot && pnpm run login
}


#更换主人QQ
function resetmasterqq()
{
    cd ~/Yunzai-Bot/config/config
    read -p '输入要更换的主人qq：' yourmasterQQ
    sed -i '7d' other.yaml
    sed -i "/masterQQ:/ a\  - \\$yourmasterQQ" other.yaml
    sleep 1s
    echo '已经修改成功咯'
    sleep 1s
	caoaboutYunzai
	storagenumber
}

#后台启动叽叽人
function htstart()
{
	if [ -e /root/Yunzai-Bot ];then
    clear
    echo '叽叽人，启动!'
    echo 'cd ~/Yunzai-Bot && pnpm start'
	sleep 1s
	cd ~/Yunzai-Bot && pnpm start
	else
	echo '先安装叽叽人再说吧！'
	sleep 1s
	caoaboutYunzai
	storagenumber
	fi
}

#插件
function plugins()
{
function PluginIndex()
{
	clear
    cat <<cao
0.退出脚本
1.返回
2.插件索引
3.删除插件（git插件）
4.
cao
}
function PluginIndexNum()
{
	read -p '请输入数字选项并回车：' indexNum
	case $indexNum in
        0)
			exit
            ;;
        1)
            caoaboutYunzai
            storagenumber
            ;;
        2)
            pluginsindex
            ;;
		3)
            deletegitplugin
			;;
        *)
           clear
            echo
            figlet ?
            echo -e '\n'
            echo '你确定你输入对了ma'
            echo
            sleep 1s
            PluginIndex
            PluginIndexNum
            ;;
    esac
}

#索引
function pluginsindex()
{
	clear
	echo '————————————————————————————————————————————————————'
	echo
	echo 'bot想关索引详情请见如下网址(bot要用到的功能均来自插件)'
	echo
	echo '————————————————————————————————————————————————————'
	echo
    echo
    echo
    echo '————————————————————————————————————————————————————'
    echo
    echo 'https://gitee.com/yhArcadia/Yunzai-Bot-plugins-index'
    echo
    echo '————————————————————————————————————————————————————'
    echo
    echo
    echo
    read -s -n1 -p "按任意键或直接回车以返回"
    caoaboutYunzai
    storagenumber
}

#删除git插件

function deletegitplugin()
{
	clear
    echo -e '\n'
	echo '以下是已安装的git插件'
    echo -e '\n'
    for file in `ls ~/Yunzai-Bot/plugins`;do
        if [ "$file" != "example" ] && [ "$file" != "other" ] && [ "$file" != "system" ] && [ "$file" != "genshin" ];then
		    echo -e "\t\t\033[32m$file\033[0m"
            echo
        fi
	done
    echo
    echo -e '\n'
    echo '复制粘贴需要删除的插件名称，需要返回输入0并回车'
    echo
	read -p '删除前请确认是否删除，别不小心删错了：' pluginname
	if [ -e ~/Yunzai-Bot/plugins/$pluginname ];then
		rm -rf ~/Yunzai-Bot/plugins/$pluginname
        echo
		echo -e '正在删除'
        sleep 1s
		if [ -e ~/Yunzai-Bot/plugins/$pluginname ];then
            echo
			echo -e '删除失败，请重新执行或手动删除'
			sleep 1.5s
            PluginIndex
            PluginIndexNum
		else
            echo
			echo -e '删除成功'
            sleep 1s
            PluginIndex
            PluginIndexNum
			fi
	elif [ $pluginname == 0 ];then
        PluginIndex
        PluginIndexNum
    else
        echo
		echo '插件名称输错了吧，或者没有该插件，快去确认一下'
		sleep 1s
        deletegitplugin
	fi
}

#判断项目再管理

cd ~
if  [ -e /root/Yunzai-Bot ];then
    PluginIndex
    PluginIndexNum
else
    echo "叽叽人都没装怎么管理插件呢"
    sleep 1s
    caoaboutYunzai
    storagenumber
fi

}

#安装ffmpeg
function ffmpeginstall()
{
    clear
	echo '正在准备安装ffmpeg……'
    sleep 0.5s
    if ! type git >/dev/null 2>&1; then
        apt update && apt install git -y
    fi
    git clone --depth=1 https://gitee.com/cao100/caoyz.sh.git
    if [ $(uname -m) == "aarch64" ]; then
        cp /root/yunzai-ffmpeg/arm.tar.gz /home/
        rm -rf /root/yunzai-ffmpeg
        cd /home/
        mkdir ffmpeg5.1.1
        tar -xvf arm.tar.gz -C ffmpeg5.1.1 --strip-components 1
        rm -rf arm.tar.gz
    elif [ $(uname -m) == "x86_64" ]; then
        cp /root/yunzai-ffmpeg/amd.tar.gz /home/
        rm -rf /root/yunzai-ffmpeg
        cd /home/
        mkdir ffmpeg5.1.1
        tar -xvf amd.tar.gz -C ffmpeg5.1.1 --strip-components 1
        rm -rf amd.tar.gz
    fi
#软链接
    ln -sf /home/ffmpeg5.1.1/ffmpeg /usr/local/bin/ffmpeg
    ln -sf /home/ffmpeg5.1.1/ffprobe /usr/local/bin/ffprobe
    echo 'ffmpeg安装完成'
    echo -e 你的ffmpeg是：\\n$(ffmpeg -version)
    caoaboutYunzai
    storagenumber
}

#安装python3.10.0
function pythoninstall3.10.0()
{
    echo  '正在准备安装python3.10.0，时间要蛮久的哦，估计三十分钟左右，可以挂后台去干别的事情'
    sleep 3s
    cd ~
#安装依赖
    apt update
    apt install git build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget make libbz2-dev -y
#下载python3.10.0压缩包
    git clone --depth=1 https://gitee.com/cao100/caoyz.sh
    cp /root/caoyz.sh/Python-3.10.0.tgz /home/
    cd /home/
#解压
    tar -zxvf Python-3.10.0.tgz
    cd Python-3.10.0
    ./configure --enable-optimizations
    make
    make install
    rm -rf Python-3.10.0.tgz
#软链接
    ln -sf /usr/local/bin/python3 /usr/bin/python
    ln -sf /usr/local/bin/pip3 /usr/bin/pip
    echo 'python3.10.0安装完成'
    echo -e 当前默认python版本为$(python --version)
    sleep 1.5s
	caoaboutYunzai
    storagenumber
}

#figlet要用到，不管咋样装上好了
    if ! type figlet >/dev/null 2>&1; then
        apt-get update
        apt-get install figlet -y
    fi
    caoaboutYunzai
    storagenumber
else
    echo '不支持当前环境'
    echo '手机请确认是否进入容器，服务器请确认是否root'
fi