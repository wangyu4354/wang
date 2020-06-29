#!/bin/bash
#删除用户
if [ ! -f $1 ];then
	echo "$1不是文件"
fi
while read line
do
	user=`echo "$line" | awk '{print $1}'`
	id $user &> /dev/null
	if [ $? -eq 0 ];then
		userdel $user
		if [ $? -eq 0 ];then
			echo "$user 删除成功"
		fi
	else
		echo "$user 用户不存在"
	fi
done < /home/w/shell/day3/user.txt
