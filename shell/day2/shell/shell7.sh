#!/bin/bash
read -p "请输入一个数字:" num
	if [[ ! "$num" =~ ^[0-9]+$ ]];then
	echo "你输入的不是数子"
exit
fi
	
