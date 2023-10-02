#!/bin/bash
clear

tput cup 1 0; tput setaf 5; echo "Usuarios en el Sistema"

tput setaf 6
tput cup 3 0; echo "UID"
tput cup 3 8; echo "Usuario"
tput cup 3 30; echo "Grupo (GID)"
tput cup 3 54; echo "Ingreso"

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
		ingreso=$(grep -w "$nomUsu" /etc/passwd | cut -d: -f5)
		tput cup $w 0; echo "$uid"
		tput cup $w 8; echo "$nomUsu"
		tput cup $w 30; echo "$grupo ($gid)"
		tput cup $w 54; echo "$ingreso"
		let w=$w+1
	fi 
done

echo " "; echo " "; tput setaf 2; echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera