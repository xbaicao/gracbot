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

function caoaboutyunzai()
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
9.修复（遇到报错，或者出现了什么奇奇怪怪的问题，看这里）
10.安装ffmpeg
11.安装python3.10.0
12.自建本地接口api签名（手机可部署）
13.api签名使用方法
99.报错237修复
100.一键卸载关于bot所有相关内容
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
            error
            ;;
        
        10)
            ffmpeginstall
            ;;

        11)
            pythoninstall3.10.0
            ;;

        12)
            apisignature
            ;;

        13)
            useapi
            ;;

        99)
            loginfrequently
            ;;

        100)
            rmaboutbot
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
            caoaboutyunzai
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
	caoaboutyunzai
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
	caoaboutyunzai
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
    echo -e "启动脚本快捷键\033[47;35mbc\033[0m"
    echo -e "前台启动叽叽人\033[47;35mqd\033[0m"
    echo -e "后台启动叽叽人\033[47;35mhtqd\033[0m"
    echo -e "查看叽叽人日志\033[47;35mlog\033[0m"
    echo -e "停止叽叽人运行\033[47;35mstop\033[0m"
    echo
    echo
    read -s -n1 -p "按任意键或直接回车以返回"
    caoaboutyunzai
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
	caoaboutyunzai
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
	caoaboutyunzai
	storagenumber
	fi
}

#插件管理
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
4.更新全部git插件
5.删除插件（js插件）
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
            caoaboutyunzai
            storagenumber
            ;;
        2)
            pluginsindex
            ;;
		3)
            deletegitplugin
			;;
        4)
            updateplugins
            ;;
        5)
            deletejs
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

#判断项目再管理
cd ~
if  [ -e /root/Yunzai-Bot ];then
    PluginIndex
    PluginIndexNum
else
    echo "叽叽人都没装怎么管理插件呢"
    sleep 1s
    caoaboutyunzai
	storagenumber
fi

}

#相关索引
function pluginsindex()
{
	clear
	echo '————————————————————————————————————————————————————'
	echo
	echo 'bot相关索引详情请见如下网址(bot要用到的功能均来自插件)'
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
    PluginIndex
    PluginIndexNum
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
		    echo -e "\t\t\033[34m$file\033[0m"
            echo
        fi
	done
    echo
    echo -e '\n'
    echo '复制粘贴需要删除的插件名称，需要返回输入0并回车'
    echo
	read -p '删除前请确认是否删除，别不小心删错了哦：' pluginname
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

#更新全部git插件
function updateplugins()
{
    clear
    echo '正在更新所有插件'
    cd && cd Yunzai-Bot/plugins
    for d in */; do
  (cd "$d" && git pull)
  if [ $(git rev-parse HEAD) = "$(git ls-remote $(git rev-parse --abbrev-ref @{u} | sed 's!/! !g') | cut -f1)" ]; then
    last_commit_date=$(cd "$d" && git log -1 --format='%cd' --date=format:'%Y-%-m-%-d %H:%M')
    echo "$d 最后更新时间 $last_commit_date"
fi
done
    echo '已更新全部插件'
    sleep 2s
	PluginIndex
    PluginIndexNum
}

#删除js插件
function deletejs()
{
	clear
    echo -e '\n'
	echo '以下是已安装的js插件'
    echo -e '\n'
    for file in `ls ~/Yunzai-Bot/plugins/example`;do
        if [ "$file" != "other" ];then
		    echo -e "\t\t\033[36m$file\033[0m"
            echo
        fi
	done
    echo
    echo -e '\n'
    echo '复制粘贴需要删除的插件名称，需要返回输入0并回车'
    echo
	read -p '删除前请确认是否删除，别不小心删错了哦：' jsname
	if [ -e ~/Yunzai-Bot/plugins/example/$jsname ];then
		rm -rf ~/Yunzai-Bot/plugins/example/$jsname
        echo
		echo -e '正在删除'
        sleep 1s
		if [ -e ~/Yunzai-Bot/plugins/example/$jsname ];then
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
	elif [ $jsname == 0 ];then
        PluginIndex
        PluginIndexNum
    else
        echo
		echo '插件名称输错了吧，或者没有该插件，快去确认一下'
		sleep 1s
        deletejs
	fi
}

#报错修复
function error()
{
function errorlist()
{
	clear
    cat <<run
1.QQ版本过低或禁止登录(45报错)
2.cannot find package 'oicq'
3.cannot find package 'icqq'
4.puppeteer启动失败
5.出现奇奇怪怪的东西，这里重装依赖尝试一下
6.返回
0.退出脚本

run
}
function RepaireNum()
{
    read -p '出现什么报错就选哪个：' repaireNum
	case $repaireNum in
        0)
			exit
            ;;
        1)
            QQ-repaire
            ;;
        2)
            oicq-repaire
            ;;
        3)
            icqq-repaire
            ;;
        4)
            puppeteer-false
            ;;
        5)
            pnpminstall
            ;;
		6)
			caoaboutyunzai
            storagenumber
			;;
        *)
           clear
            echo
            figlet ?
            echo -e '\n'
            echo '你确定你输入对了ma'
            echo
            sleep 1s
            errorlist
            RepaireNum
            ;;
    esac
}
function QQ-repaire()
{
function QQ-repaire-list()
{
    clear
    cat <<out
    
1.修改端口与device文件
2.修改端口与subid
3.更新icqq（icqq版本4以上都是需要api签名的）
4.api签名使用方法
0.返回

out
}
function QQ-repaire-num()
{
    read -p '请输入数字选项：' num
    case $num in
        0)
            errorlist
            RepaireNum
            ;;
        1)
            device
            ;;
        2)
            subid
            ;;
        3)
            icqq
            ;;
        4)
            api
            ;;
        *)
           clear
            echo
            figlet ?
            echo -e '\n'
            echo '你确定你输入对了ma'
            echo
            sleep 1s
            QQ-repaire-list
            QQ-repaire-num
            ;;
    esac
}

function device()
{
	echo '如果执行该选项后仍然提示qq版本过低，请继续使用后续方案，或尝试进行扫码登录'
	read -p '输入你的叽叽人的qq号并回车：' QQnumber
    sed -i '/platform/d' /root/Yunzai-Bot/config/config/qq.yaml
    echo platform: 4 >> /root/Yunzai-Bot/config/config/qq.yaml
    cd ~/Yunzai-Bot/data/$QQnumber
    curl -o device-$QQnumber.json https://gitee.com/cao100/caoyz.sh/raw/master/QQrepaire
	echo '已尝试进行修复'
	read -p '是否立刻启动叽叽人，1启动，0不启动' num
	if [ $num == 1 ];then
		redis-server --daemonize yes --save 900 1 --save 300 10 && cd ~/Yunzai-Bot && node app
		exit
	else
		echo '不启动叽叽人，请后续自行启动查看是否修复完成'
		sleep 1s
	fi
	QQ-repaire-list
	QQ-repaire-num
}

function subid()
{
    echo '如果该选项执行后仍然提示qq版本过低，请继续使用后续方案，或尝试进行扫码登录'
    read -p '请输入你的叽叽人qq号并回车：' QQnumber
    sed -i '/platform/d' /root/Yunzai-Bot/config/config/qq.yaml
    echo platform: 4 >> /root/Yunzai-Bot/config/config/qq.yaml
    sed -i 's/537064315/537128930/' /root/Yunzai-Bot/node_modules/oicq/lib/core/device.js
    cd ~/Yunzai-Bot/data/$QQnumber
    curl -o device-$QQnumber.json https://gitee.com/cao100/caoyz.sh/raw/master/QQrepaire
	echo '已尝试进行修复'
	read -p '是否立刻启动叽叽人，1启动，0不启动' num
	if [ $num == 1 ];then
		redis-server --daemonize yes --save 900 1 --save 300 10 && cd ~/Yunzai-Bot && node app
		exit
	else
		echo '不启动叽叽人，请后续自行启动查看是否修复完成'
		sleep 1s
	fi
	QQ-repaire-list
	QQ-repaire-num
}

function icqq()
{
    echo '正在尝试进行解决……'
    cd ~/Yunzai-Bot && pnpm install && pnpm install icqq@latest -w
    echo '已尝试进行解决'
    sleep 2s
	QQ-repaire-list
	QQ-repaire-num
}

function api()
{
    clear
    echo '在文件管理器中找到叽叽人根目录，找到config/config/bot.yaml打开并编辑，在末尾另起一行添加sign_api_addr:
注意冒号后面有个空格，在后面添加上api签名地址，然后重启你的叽叽人就好啦'
    read -s -n1 -p "按任意键或直接回车以返回"
	QQ-repaire-list
	QQ-repaire-num
}

QQ-repaire-list
QQ-repaire-num

}

function oicq-repaire()
{
    echo '正在尝试进行解决……'
    cd ~/Yunzai-Bot && pnpm add image-size axios express multer body-parser jsonwebtoken systeminformation oicq -w
    echo '已尝试进行解决'
    sleep 2s
	errorlist
	RepaireNum
}
function icqq-repaire()
{
    echo '正在尝试进行解决……'
    cd ~/Yunzai-Bot && pnpm install && pnpm install icqq@latest -w
    echo '已尝试进行解决'
    sleep 2s
	errorlist
	RepaireNum
}
function pnpminstall()
{
    echo '正在尝试进行解决,这里重建依赖的时间可能比较久'
    cd && rm -rf Yunzai-Bot/node_modules && pnpm install
    echo '已尝试进行解决'
    sleep 2s
	errorlist
	RepaireNum
}
function puppeteer-false()
{
    clear
    echo 请选择你的系统版本：
    echo 1.ubuntu18.04
    echo 2.ubuntu20.04
    echo 3.ubuntu22.04
    echo 4.不知道？那这里为你自动检测
    echo 0.返回
    read -p '请输入数字并回车：' num
    if [ $num == 1 ];then
        cd root/Yunzai-Bot
        git reset --hard origin/main
        git checkout . && git pull
        pnpm update
        pnpm add puppeteer@13.7.0 -w
    elif [ $num == 2 ] || [ $num == 3 ];then
        cd root/Yunzai-Bot
        git reset --hard origin/main
        git checkout . && git pull
        node ./node_modules/puppeteer/install.js
        apt-get update
        apt-get install ca-certificates fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release wget xdg-utils libxkbcommon0 -y
    elif [ $num == 4 ];then
        cd root/Yunzai-Bot
        git reset --hard origin/main
        git checkout . && git pull
        pnpm update
        pnpm add puppeteer@13.7.0 -w
        echo 记住了，你的系统版本是ubuntu18.04
        sleep 1.5s
    elif [ $num == 0 ];then
        errorlist
	    RepaireNum
    else
            figlet ?
            echo -e '\n'
            echo '你确定你输入对了ma'
            echo
            sleep 1s
            puppeteer-false
    fi
    echo 已经尝试修复，行不行看运气吧
    sleep 1.5s
}
#报错处理列表运行
if [ -e /root/Yunzai-Bot ]; then
errorlist
RepaireNum
else
echo 叽叽人没装，你到底要修复什么呢
sleep 1.5s
caoaboutyunzai
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
    caoaboutyunzai
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
	caoaboutyunzai
    storagenumber
}

#自建本地接口api签名
function apisignature()
{
    echo '我好懒，所以这里调用白狐自建脚本'
    echo 'bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/QSignServer2.0.sh)'
	sleep 1s
	bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/QSignServer2.0.sh)
}

#使用api签名教程
function useapi()
{
    clear
    echo '在文件管理器中找到叽叽人根目录，找到config/config/bot.yaml打开并编辑，在末尾另起一行添加sign_api_addr:
注意冒号后面有个空格，在后面添加上api签名地址，然后重启你的叽叽人就好啦'
    read -s -n1 -p "按任意键或直接回车以返回"
	caoaboutyunzai
    storagenumber
}

#237报错
function loginfrequently()
{
    clear
    echo
    echo ！！！！！！！！！！！！！！！！！！！！！！！！！！！！
    echo
    echo
    echo '想什么呢，237是登录频繁了，这可修复不了哦（手动狗头），还是老老实实等半天或者干脆换号吧'
    echo
    echo
    echo ！！！！！！！！！！！！！！！！！！！！！！！！！！！！
    echo
    read -s -n1 -p "按任意键或直接回车以返回"
	caoaboutyunzai
    storagenumber
}

#删库跑路
function rmaboutbot()
{
    clear
	echo '确定要删库跑路吗，你真的放得下吗，你真的忍心吗，请三思'
	echo
    echo '1-算了，返回	2-确定'
	read -p '请输入数字后回车：' change
	if [ $change == 1 ];then
		caoaboutyunzai
        storagenumber	
	elif [ $change == 2 ];then
		cd && rm -rf Yunzai-Bot
        echo '已删除bot数据库' 
        sleep 1s
	else
		echo '请输入选项数字，即将退出'
        sleep 3s
		exit
	fi		
}


#figlet要用到，不管咋样装上好了
if [ $(id -u) == 0 ];then
    if ! type figlet >/dev/null 2>&1; then
        apt-get update
        apt-get install figlet -y
    fi
	clear
    echo '阁下想用哪个叽叽人呢（作者我用的是云崽）'
    echo
    echo
    echo
    echo '1-云崽     2-喵崽'
    echo '1-云崽     2-喵崽'
    echo '1-云崽     2-喵崽'
    echo '1-云崽     2-喵崽'
    echo '1-云崽     2-喵崽'
    echo
    echo
    echo
	read -p '请输入数字并回车：' change
	if [ $change == 1 ];then
		caoaboutyunzai
        storagenumber
	elif [ $change == 2 ];then
		bash <(curl -sL https://gitee.com/cao100/caoyz.sh/raw/master/caomyz.sh)
	else
		echo '你输入的不是有效数字，为您退出脚本（脚本启动快捷键bc）'
		exit
	fi		
else
    echo '运行环境出现问题咯'
    echo '手机用户确认容器状态，服务器用户确认root状态'
fi