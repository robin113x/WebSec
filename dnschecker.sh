#!/bin/zsh

cat $1 |
while read line
do
	curl $line &>/dev/null
	if [ $? == 0 ];
	then
		echo "[+] $line is live"
	fi
done
