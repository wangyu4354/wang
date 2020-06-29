#!/bin/bash
read -p "请输入用户名:" username
if id $username &> /dev/null ; then
	echo "$username 存在"
else 
	if useradd $username ; then
		echo "$username 创建成功"
	else
		echo "创建失败,权限不足,退出程序"
		exit
	fi
fi
