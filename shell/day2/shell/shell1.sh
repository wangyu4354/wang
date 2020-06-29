#!/bin/bash
read -p "please is input:" ip
if [ $? -eq 0 ]; then
	echo "$ip is up"
else 
	echo "$ip is down"
fi
