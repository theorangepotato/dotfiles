#!/usr/bin/expect -f

set prompt "#"
set address 74:5C:4B:0A:6F:DD

send_user "\nConnecting to Jabra Elite Active 65...\r"
spawn bluetoothctl
expect -re $prompt
expect "Agent registered"
send "connect $address\r"
expect "Connection successful"
send "quit\r"
expect eof
send_user "Connected.\r"

