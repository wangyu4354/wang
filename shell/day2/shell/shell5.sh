#!/bin/bash
if [ $# -eq 0 ]; then
	echo "useage: `basename $0` file"
	exit
fi
if [ ! -f $1 ]; then
	echo "not file"
	exit
fi

for ip in `cat $1`
do
	ping -c1 $ip &> /dev/null
	if [ $? -eq 0 ] ; then
		echo "$ip is up"
	else 
		echo " $ip is down"
	fi
done

