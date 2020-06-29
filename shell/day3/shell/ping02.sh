#!/bin/bash
#批量的ping嗅探
>ip.txt
thread=5
tmp_fifofile=/tmp/$$.fifo

mkfifo $tmp_fifofile
exec 88<> $tmp_fifofile
rm $tmp_fifofile
for i in `seq $thread`
do
	echo >&88
done

read -p "请输入网段[列如:10.0.0]:" wd
if [[ $wd =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]];then
    for i in `seq 254`
    do
	read -u 88
	{
	ping -c1 -W1 $wd.$i &> /dev/null
	if [ $? -eq 0 ] ;then
		echo "$wd.$i" |tee -a ip.txt
	else
		echo -e "\e[1;35m$wd.$i \e[0m"
	fi
	echo >&88
	}&
    done
else
    echo "格式错误,程序退出"
    exit
fi
