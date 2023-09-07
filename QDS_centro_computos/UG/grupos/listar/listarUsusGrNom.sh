#!/bin/bash
clear

tput setaf 3; tput cup 1 0; echo "Ingrese el nombre del grupo a buscar: "
tput setaf 7; tput cup 1 38; read nomGr

nomGr2=$(cut -d: -f1 /etc/group | grep -w "$nomGr")

while [ -z $nomGr2 ]
do
	tput cup 4 0; echo "                                                            "
        tput setaf 1; tput cup 4 0; echo "No existe un grupo llamado '$nomGr' en el sistema..."
	tput cup 5 0; echo "Intente nuevamente."
	tput setaf 7
        tput cup 1 38; echo "                                                              "
	tput cup 1 38; read nomGr
	nomGr2=$(cut -d: -f1 /etc/group | grep -w "$nomGr")
done

tput cup 4 0; echo "                                              "
tput cup 5 0; echo "                              "

gid=$(grep -w "$nomGr:x" /etc/group | cut -d: -f3)

tput cup 3 0; tput setaf 5; echo "Usuarios del grupo '$nomGr' (GID: $gid)"

tput setaf 5
tput cup 5 0; echo "UID"
tput cup 5 15; echo "Usuario"
tput cup 5 34; echo "Ingreso al sistema"

w=7

tput setaf 7

for usuario in $(cut -d: -f1,3,4 /etc/passwd)
do
	gidUsu=$(echo "$usuario" | cut -d: -f3)
	if [ "$gidUsu" -eq "$gid" ]
	then
		uid=$(echo "$usuario" | cut -d: -f2)
		ingreso=$(grep -w "x:$uid" /etc/passwd | cut -d: -f5)
		nomUsu=$(echo "$usuario" | cut -d: -f1)
		tput cup $w 0; echo "$uid"
		tput cup $w 15; echo "$nomUsu"
		tput cup $w 34; echo "$ingreso"
		let w=$w+1
	fi
done

read volver