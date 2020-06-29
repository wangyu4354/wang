# Shell 2 day
## 变量
### 自定义变量

|   变量   | 作用                                                        |
| :------: | :---------------------------------------------------------- |
| 定义变量 | 必须以字母或下划线开头，区分大小写 .a=wangyu                |
| 引用变量 | `$变量名`或`${变量名}`                                      |
| 查看变量 | `echo $变量名` 或 set(所有的变量，包括自定义变量和环境变量) |
| 取消变量 | `unset 变量名`                                              |
| 作用范围 | 当前shell中有效                                             |
|  $1,$2   | shell后面跟的参数，详情参考案例2                            |


**案例**
```
#!/bin/bash
read -p "please is input:" ip
ping -c1 $ip &> /dev/null
if [ $? -eq 0 ]; then
	echo "$ip is up"
else 
	echo "$ip is down"
fi

```
- read 表示读取从键盘输入，-p表示提示placeHodler
- then前面的; 是因为then也是命令，用;隔开。或者then另写一行

**案例**
```
#!/bin/bash
ping -c1 $1 &> /dev/null
if [ $? -eq 0 ]; then
	echo "$1 is up"
else 
	echo "$1 is down"
fi
```
- `./shell2.sh 10.0.0.1`的方式执行，$1表示shell后面跟的参数1

### 环境变量

|     变量     | 作用                                                                        |
| :----------: | :-------------------------------------------------------------------------- |
| 定义环境变量 | 方法1 `export 变量名=值`<br/>方法2 `export 变量` 将定义的变量转换为环境变量 |
| 引用环境变量 | `$变量名`或`${变量名}`                                                      |
| 查看环境变量 | `echo $变量名`或`env` 显示全部的 列如 `env | grep 变量名`                   |
| 取消环境变量 | `unset 变量名`                                                              |
|   作用范围   | 当前shell和子shell中有效                                                    |

**案例**
```
$ w=wnagyu
$ cat shell3.sh 
    #!/bin/bash
    echo "环境变量w的$w"
$ ./shell3.sh 
    环境变量w的
$ export w
    （将环境变量w转换为系统变量）
$ ./shell3.sh 
环境变量w的wnagyu

```
- 可以通过`public.sh` 里面放共有变量，在`sub.sh`中引入`public.sh`脚本，进行变量的转换<br/>引入方式`. public.sh`表示在当前shell中执行

### 预定义变量

| 变量  | 作用                                       |
| :---: | :----------------------------------------- |
| `$0`  | 脚本名                                     |
| `$*`  | 所有参数                                   |
| `$@`  | 所有参数                                   |
| `$#`  | 参数个数                                   |
| `$$`  | 当前进程PID                                |
| `$!`  | 上一个后台进程的PID                        |
| `$?`  | 上一个命令的返回结果。0表示成功，非0是失败 |

**案例**
```
#!/bin/bash
echo "第一个参数："$1
echo "第2个参数："$2
echo "参数个数："$#
echo "所有参数："$@
echo "所有参数："$*
echo "脚本名字:"$0
echo "当前进程PID："$$
echo "上一个进程PID："$!
```
- `$@`和`$*`的区别 。
  - `$*`将命令行的所有参数看成一个整体
  - `$@`则区分各个参数

<!-- <font color=red size=1>asdfja</font> -->


**案例**
```
读取文件中的ip，先判断是否为文件，然后ping
$cat <<-EOF > ip.txt
127.0.0.1
198.168.1.1
10.0.0.1
EOF

$ cat shell5.sh 
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

$ ./shell5.sh ip.txt 
127.0.0.1 is up
 198.168.1.1 is down
10.0.0.1 is up

```
- `basename 文件路径/a.txt`可以输出文件名，不包含路径
- `dirname 文件路径/ax.txt`可以输出文件路径，无文件名
- `[ ! -f $1]`判断参数1是否是文件

### 变量的赋值
|      方式      | 效果                                                                                                                                 |
| :------------: | :----------------------------------------------------------------------------------------------------------------------------------- |
|    显示赋值    | <font color=red>变量名=变量值</font><br/>``将内容转换为命令等效于$()<br/>" " 用"是当字符串，如果无，则是两个。<br/>列如:wang="w a n" |
| read从键盘读取 | <font color=red>read 变量名</font><br/>read -t 5 -n 2 -p "提示" 变量名<br/>-t表示5s后停止输入。-n表示只提取输入的前2个               |

**案例**
```
$ cat input2.sh 
#!/bin/bash
read -p "请输入姓名" name
read -p "请输入性别" sex
read -p "请输入年龄" age
echo "您的姓名为: $name,性别为:$sex,年龄为：$age"
$ cat input1.sh 
#!/bin/bash
read -p "请输入姓名，性别，年龄 [e.g wang n 20]:" name sex age
echo "您的姓名为: $name,性别为:$sex,年龄为：$age"
```
- <font color=red>""与‘’的区别</font>
  - ”“是弱引用
  - ‘’是强引用

**案例**
```
$ wang=wangyu
$ echo "$wang la"
wangyu la
$ echo '$wang la'
$wang la
```

## 运算
### 整数运算

|  方式   | 效果及案例                                                                          |
| :-----: | :---------------------------------------------------------------------------------- |
| `expr`  | expr 1 + 1 适用于 + - `\*` / %.<br/>注意：`\*`是转义*的作用。<br/>注意1+1的前后空格 |
| `$(())` | $((1+1)) 适用于 + - * / % **,()中的\$可以省去                                       |
|  `$[]`  | $[1+1]适用于 + - * / % **,()中的\$可以省去                                          |
|  `let`  | 经常使用 `let i++`，注意i前面没有\$符号，实现递增.            |

**案例**
```
查看内存占用的百分比
#!/bin/bash
mem_used=`free -m | grep '^Mem:' | awk '{print $3}'`
mem_total=`free -m | grep '^Mem:' | awk '{print $2}'`
mem_percent=$(($mem_used*100/$mem_total))
echo "当前内存使用的百分比:$mem_percent"

或者let mem_percent=$mem_used*100/$mem_total
```
### 小数运算
```
$ echo "scale=2;6/4" | bc
1.50
$ echo "scale=3;6/4" | bc
1.500
$ echo "1/3" | bc
0
$ echo "2^4" | bc
16
$ echo "3*4" | bc
12

```
### 删除和替换

|       格式       | 作用                                                                                              |
| :--------------: | :------------------------------------------------------------------------------------------------ |
|   `${#变量名}`   | 获取变量长度                                                                                      |
|  `${变量名#*.}`  | 返回一个：删除变量中的第一个.前面的字符串<br/><font color=red>原字符没有改变<br/>*是通配符</font> |
| `${变量名##*.}`  | 返回一个：删除变量中的到最后一个.前面的所有字符串<br/><font color=red>原字符没有改变</font>       |
| `${变量名%com}`  | 从尾部删除，同#相似<br/><font color=red>原字符没有改变</font>                                     |
| `${变量名:0:3}`  | 切片的方式，根据索引切割<br/><font color=red>原字符没有改变</font>                                |
| `${变量名/n/N}`  | 将字符串替换,第一个n替换<br/><font color=red>原字符没有改变</font>                                |
| `${变量名//n/N}` | 将字符串替换，所有的n都替换<br/><font color=red>原字符没有改变</font>                             |
|  `${变量名-值}`  | 如果没有值，则给变量默认值。有值则不替换                                                          |
| `${变量名:-值}`  | 如果是空值，它也能替换，比上面的厉害                                                              |


```
$ url=www.baidu.com
$ echo ${url}
www.baidu.com
$ echo ${#url}
13
$ echo ${url#ww}
w.baidu.com
$ echo ${url#*.}
baidu.com
$ echo ${url##*.}
com

$ echo ${url%%.*}
www
$ echo ${url%.*}
www.baidu
$ echo ${url%com}
www.baidu.

```
**案例**
```
数字的判断脚本
#!/bin/bash
read -p "请输入一个数字:" num
if [[ ! "$num" =~ ^[0-9]+$ ]];then
	echo "你输入的不是数子"
	exit
fi
```
### 各种符号
符号|作用
:--:|:--
`()`|sub shell
`(())`|数值比较。<br/>比如:((1>2))返回false(1)
`$()`|等效\`\`
`$(())`|数值运算
`{}`|集合
`${}`|变量引用以及替换
`[]`|条件测试
`[[]]`|具备`[]`的所有，并支持正则。<br/>[[ =~ ]]正则比较方式
`$[]`|整数运算

---
## 条件测试之if
- 格式
  1. `test 条件表达式`
  2. `[条件表达式]`
  3. `[[条件表达式]]`

**语法**
```
test 条件表达式
列如：test -d 变量名:判断变量是否是一个目录
[条件表达式]
列如：[ -d 变量名 ]：判断变量是否是一个目录
[是一个命令，必须要空格
[[条件表达式]]
支持正则匹配,全是数字 [[ 数值 =~ ^[0-9]+$ ]]
:与true是一样的,通常使用在if后面当做占位符,也是表示true的意思
```
**man [**
条件表达式的格式|作用
:--:|:--
`[ 条件表达式 -a 条件表达式 ]`|相当于条件表达式1AND 条件表达式2
`[ 条件表达式 -o 条件表达式 ]`|相当于条件表达式1 OR 条件表达式2
`[ -z string ]`|是一个字符串长度为zero（0）
`[ -n string]`|是一个字符串长度为非0
`[ 整数1 -eq 整数2 ]`|数值比较,整数等于
`[ 整数1 -ge 整数2 ]`|数值比较，大于等于
`[ 整数1 -gt 整数2 ]`|数值比较，大于
`[ 整数1 -le 整数2 ]`|数值比较，小于等于
`[ 整数1 -lt 整数2 ]`|数值比较，小于
`[ 整数1 -ne 整数2 ]`|数值比较,不等于
`[ 字符串1 == 字符串2 ]`|字符串比较，`!=`

文件测试|作用
:--:|:--
`[ FILE1 -nt FILE2 ]`|FILE1比2新
`[ FILE1 -ot FILE2 ]`|FILE1比2旧
`[ -d FILE ]`|文件存在是一个目录
`[ -f FILE ]`|文件存在是一个文件
`[ -b FILE ]`|文件存在是一个块设备
`[ -e FILE ]`|文件存在
`[ -r FILE ]`|文件存在必须有<font color=red>当前用户</font>读权限
`[ -w FILE ]`|文件存在必须有<font color=red>当前用户</font>写权限
`[ -x FILE ]`|文件存在必须有<font color=red>当前用户</font>执行权限

**案例**
```
用户创建案例
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
----------
elif此方式
```
**数字比较方式2**
方式|作用
:--:|:--
((1<2))|比较数字大于或小于
((1==2))|比较数字等于
((1!=2))|比较数字不等于


**字符串的比较**
- 最好使用\"\"将其引住
```
$ whoami
w
$ [ "$USER" == "w" ];echo $?
0
$ [ "$USER" == "root" ];echo $?
1
$ [ "$USERX" == "w" ];echo $?
1
$ [ $USERX == w ];echo $?
bash: [: ==: 需要一元表达式
2
$ [ $USER == w ];echo $?
0

```
<font color=red>特别注意:</font>
```
$ var=""
$ echo $var
$ echo ${#var}
0
$ [ -z $var ];echo $?
0
$ [ -n $var ];echo $?
0
$ [ -n "$var" ];echo $?
1
$ [ -z "$var" ];echo $?
0
```

## 条件测试之case
- 格式
```
case 变量 in 
one)
	运行的命令
	;;
"two")
	运行的命令
	;;
*)
	运行的命令
	;;
esac
```

<font color=red>特别注意:</font>
```
case只能比较字符串,不能比较其他类型,建议最好加上双引号
```

**案例**
```
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
```