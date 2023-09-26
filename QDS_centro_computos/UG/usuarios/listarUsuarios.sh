#!/bin/bash
clear

tput cup 1 0; tput setaf 5; echo "Usuarios en el Sistema"

tput setaf 6
tput cup 3 0; echo "UID"
tput cup 3 8; echo "Usuario"
tput cup 3 28; echo "Grupo (GID)"
tput cup 3 54; echo "Mail"
tput cup 3 80; echo "Ingreso"

w=5

tput setaf 7

for usuario in $(cut -d: -f1,3,4 /etc/passwd)
do
	uid=$(echo "$usuario" | cut -d: -f2)
	if [ "$uid" -ge 1000 ]
	then
		nomUsu=$(echo "$usuario" | cut -d: -f1)
		gid=$(echo "$usuario" | cut -d: -f3)
		mail=$(grep -w "$nomUsu" /etc/mails | cut -d: -f2)
		grupo=$(grep -w "$gid:" /etc/group | cut -d: -f1)
		ingreso=$(grep -w "$nomUsu" /etc/passwd | cut -d: -f5)
		tput cup $w 0; echo "$uid"
		tput cup $w 8; echo "$nomUsu"
		tput cup $w 28; echo "$grupo ($gid)"
		tput cup $w 54; echo "$mail"
		tput cup $w 80; echo "$ingreso"
		let w=$w+1
	fi 
done

read espera