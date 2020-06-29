#/bin/bash
read -p "请输入你最喜欢的颜色:" red
case $red in
"r")
    echo "红色";;
"h")
    echo "黑色";;
*)
    echo "无颜色";;
esac