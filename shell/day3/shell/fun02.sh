#!/bin/bash
#阶乘
num=1
fun(){
#for w in `seq 5`
#do
#	#num=$[$num * $w]
#	let num*=w
#done
if [ ! $1 -gt 0 ] ; then
	:
else
fun $[$1 - 1]
let num*=$1
fi
}
fun $1
echo "$1的阶乘是$num"
