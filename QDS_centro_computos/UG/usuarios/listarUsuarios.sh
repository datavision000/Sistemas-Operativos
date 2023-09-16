#!/bin/bash
clear

tput cup 1 0; tput setaf 5; echo "Usuarios en el Sistema"

tput setaf 6
tput cup 3 0; echo "UID"
tput cup 3 15; echo "Usuario"
tput cup 3 34; echo "Grupo"
tput cup 3 51; echo "GID"

w=5

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

read espera