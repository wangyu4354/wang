#!/bin/bash
#生成公钥传输给ip.txt中的主机,然后批量复制文件
if [ ! -f ~/.ssh/id_rsa ];then
	ssh-keygen -P \"wangyu\" -f ~/.ssh/id_rsa
fi
if [ $? -eq 0 ];then
	while read line
	do
		host=`echo "$line" | awk '{print $1}'`
		ping -c1 -W2 $host &> /dev/null
		if [ ! $? -eq 0 ] ; then
			echo "$host 连接故障"
			continue
		fi
		user=`echo "$line" | awk '{print $2}'`
		pass=`echo "$line" | awk '{print $3}'`
		echo "$host|$user|$pass"
		/usr/bin/expect <<-EOF
		spawn scp -r $1 $user@$host:/
		expect {
			"yes/no" { send "yes\r" ;exp_continue}
			"password" { send "$pass\r" }
		}
		expect eof
		EOF
	done <ip.txt
fi
