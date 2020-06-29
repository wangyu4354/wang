#!/bin/bash
#批量的ping嗅探
>ip.txt
read -p "请输入网段[列如:10.0.0]:" wd
if [[ $wd =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]];then
    for i in `seq 254`
    do
    {
    ping -c1 -W1 $wd.$i &> /dev/null
    if [ $? -eq 0 ] ;then
        echo "$wd.$i" |tee -a ip.txt
    else
        #echo -e "\e[1;35m$wd.$i \e[0m"
        :
    fi
    }&
    done
else
    echo "格式错误,程序退出"
    exit
fi