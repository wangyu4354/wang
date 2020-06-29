#!/bin/bash
while [ $# -ne 0 ]
do
	let sum+=$1
	shift 2
done
echo "sum:$sum"
