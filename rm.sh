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
YUNZAI_PATH=$(head -n 1 "${HOME}/.Yunzai")

EXCLUDED_DIRS=("example" "genshin" "system" "other" "bin")

# 检查插件目录是否存在
    if [ ! -d "$YUNZAI_PATH/plugins" ]; then
    printf "目标文件夹不存在：%s/plugins\n" "$YUNZAI_PATH"
    exit 1
    fi


# 获取所有插件目录
    plugin_dirs=()
    counter=1
    while IFS= read -r folder; do
    folder_name=$(basename "$folder")
    if [[ ! "${EXCLUDED_DIRS[@]}" =~ "$folder_name" ]]; then
        plugin_dirs+=("$folder")
        printf "%d. %s\n" "$counter" "$folder_name"
        counter=$((counter+1))
    fi
    done < <(find "$YUNZAI_PATH/plugins" -mindepth 1 -maxdepth 1 -type d)

    # 用户选择要删除的序号并确认
    if [ ${#plugin_dirs[@]} -eq 0 ]; then
    echo -e "\e[31m未找到要删除的插件\e[0m"
    exit 1
    fi


echo -e "\n\e[1;34m请输入你要删除的目录的编号，多个请用空格隔开: \e[0m"
        echo -e "===================================================\e[1;32m"
read -r chosen_indexes
chosen_indexes=($chosen_indexes)

if [ ${#chosen_indexes[@]} -eq 0 ]; then
    echo -e "\e[0m\e[33m未选择任何要删除的目录\n"
    exit 1
fi

chosen_dirs=()
for chosen_index in "${chosen_indexes[@]}"; do
    chosen_dir="${plugin_dirs[$chosen_index-1]}"
    if [ -d "$chosen_dir" ]; then
        chosen_dirs+=("$chosen_dir")
    else
        echo -e "%s \e[0m\e[31m目录不存在\n" "$chosen_dir"
    fi
done

if [ ${#chosen_dirs[@]} -eq 0 ]; then
    echo -e "\e[31m未找到任何要删除的目录\e[0m\n"
    exit 1
fi

clear
printf "\n\e[0m\e[36m你将要删除以下目录：\e[0m\n"
for chosen_dir in "${chosen_dirs[@]}"; do
    printf "%s\n" "$chosen_dir"
done

echo -e "\n是否继续删除？\e[33m[Y/N]\e[0m "
read -r confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo -e "\e[33m删除操作已取消\e[0m"
    exit 0
fi

# 删除选中的目录
for chosen_dir in "${chosen_dirs[@]}"; do
    echo -e "\e[36m正在删除插件\e[0m %s ...\n" "$chosen_dir"
    rm -rf "$chosen_dir"
    printf "\n%s 已被永久删除\n" "$chosen_dir"
done