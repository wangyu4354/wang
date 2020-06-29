#!/bin/bash
echo "第一个参数："$1
echo "第2个参数："$2
echo "参数个数："$#
echo "所有参数："$@
echo "所有参数："$*
echo "脚本名字:"$0
echo "当前进程PID："$$
echo "上一个进程PID："$!
