#!/bin/bash
#统计passwd文件中各种shell个种类以及个数
declare -A ss
while read line
do
	type=`echo "$line" | awk -F":" '{print $NF}'`
	if [ ! -z "$type" ] ; then
		let ss[$type]++
	fi
done < /etc/passwd
echo "${!ss[*]}"
for i in ${!ss[@]}
do
	echo "$i:${ss[$i]}"
done
