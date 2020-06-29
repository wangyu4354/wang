#!/bin/bash
if [ ! -f $1 ];then
	echo "$1 不是文件"
	exit
fi
IFS=$'\n'
for line in `cat $1`
do
	user=`echo "$line" | awk '{print $1}'`
	pass=`echo "$line" | awk '{print $2}'`
	id $user &> /dev/null
	if [ $? -eq 0 ] ;then
		echo "$user 已经存在"
	else
		useradd $user
		#centos支持
		#echo "$pass" | passwd --stdin $user &> /dev/null
		#Ubuntu支持
		echo  $user:$pass|chpasswd
		if [ $? -eq 0 ] ;then
			echo "$user 创建成功"
		else 
			echo "$user 密码设置失败"
		fi
	fi
done
