#!/bin/bash

#初始化加载
if [ -f "$HOME/.Yunzai" ]; then
  echo -e "\033[32m校验成功\033[0m"
else
  echo -e "\033[33m初始化文件中\033[0m"
  sleep 0.3
  echo "/root/Yunzai-Bot" > "$HOME/.Yunzai"
fi
#定义云崽路径
Yz=$(head -n 1 "${HOME}/.Yunzai")

cd $Yz

clear

echo -e "\033[1;32m已安装的js插件：\033[0m"
echo
# 读取目录中的文件，并为每个文件标上序号
files=(plugins/example/*)
num=1
for file in "${files[@]}"; do
    echo "$num. $(basename "$file")"
    ((num++))
done

# 提示用户输入要删除的文件的序号
echo
echo "输入要删除的文件序号，以空格分隔："
read -r nums

# 定义一个函数，用于检查输入的序号是否合法
function check_num {
    local re='^[0-9]+$'
    if ! [[ $1 =~ $re ]] || (( $1 < 1 || $1 > ${#files[@]} )); then
        echo "无效选项：$1. 请输入一个介于 1 和 ${#files[@]} 之间的有效数字"
        exit 1
    fi
}

# 检查用户输入的序号是否合法
for num in $nums; do
    check_num "$num"
done

# 确认用户是否要删除选中的文件
echo "您确定要删除这些插件吗？(Y/n)"
read -r confirmation

if [[ $confirmation =~ ^([yY]|[yY][eE][sS])$ ]]; then
    # 删除用户输入的指定文件
    for num in $nums; do
        file="${files[num-1]}"
        if [ -f "$file" ]; then
            rm -rf "$file"
            echo "插件 $(basename "$file") 已被删除"
        fi
    done
    # 输出删除成功信息
    echo -en "\033[32m 卸载完成 回车返回\033[0m";read -p ""
else
    echo -en "操作已取消。回车退出..";read -p ""
    exit 0
fi