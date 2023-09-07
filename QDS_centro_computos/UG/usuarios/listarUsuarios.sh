#!/bin/bash

clear
tput setaf 5
tput cup 1 0; echo "UID"
tput cup 1 15; echo "Usuario"
tput cup 1 34; echo "Grupo"
tput cup 1 51; echo "GID"

w=3

tput setaf 7

for usuario in $(cut -d: -f1,3,4 /etc/passwd)
do
	uid=$(echo "$usuario" | cut -d: -f2)
	if [ "$uid" -ge 1000 ]
	then
		nomUsu=$(echo "$usuario" | cut -d: -f1)
		gid=$(echo "$usuario" | cut -d: -f3)
		grupo=$(grep -w "$gid:" /etc/group | cut -d: -f1)
		tput cup $w 0; echo "$uid"
		tput cup $w 15; echo "$nomUsu"
		tput cup $w 34; echo "$grupo"
		tput cup $w 51; echo "$gid"
		let w=$w+1
	fi 
done

read volver