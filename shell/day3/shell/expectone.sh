#!/bin/bash
/usr/bin/expect <<-EOF
set timeout 1
spawn ssh wang1@127.0.0.1
expect {
	"yes/no" { send "yes\r"; exp_continue }
	"password" { send "wang1\r" }
}
#interact
expect "$"
send "ifconfig\r"
send "pwd\r"
send "exit\r"
expect eof
EOF
