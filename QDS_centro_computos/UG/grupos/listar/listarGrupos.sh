#!/bin/bash

clear
tput setaf 5
tput cup 1 0; echo "Grupos en el Sistema"
tput setaf 6
tput cup 3 0; echo "GID"
tput cup 3 15; echo "Grupo"
w=5

tput setaf 7

for grupo in $(cut -d: -f1,3 /etc/group)
do
	gid=$(echo "$grupo" | cut -d: -f2)
	if [ "$gid" -ge 1000 ]
	then
		nomGr=$(echo "$grupo" | cut -d: -f1)
		tput cup $w 0; echo "$gid"
		tput cup $w 15; echo "$nomGr"
		let w=$w+1
	fi 
done

echo " "; echo " "; tput setaf 2; echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera