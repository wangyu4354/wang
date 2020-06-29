#!/bin/bash
array1=(wang 18 yu)
declare -A arr1
arr1=([name]=wangyu [age]=20)
a(){
	for i in $*
	do
		echo "$i爱上点击爱上当减肥"

	done
}
a ${arr1[*]}
echo "${array1[0]}"
