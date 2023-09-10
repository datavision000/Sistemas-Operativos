#!/bin/bash
clear

tput setaf 3; tput cup 1 0; echo "Ingrese el GID del grupo a buscar: "
tput setaf 7; tput cup 1 35; read gid

gid2=$(cut -d: -f3 /etc/group | grep -w "$gid")

while [ -z $gid2 ]
do
	tput cup 4 0; echo "                                                            "
        tput setaf 1; tput cup 4 0; echo "No existe un grupo con GID '$gid' en el sistema..."
	tput cup 5 0; echo "Intente nuevamente."
	tput setaf 7
        tput cup 1 35; echo "                                                              "
	tput cup 1 35; read gid
	gid2=$(cut -d: -f3 /etc/group | grep -w "$gid")
done

tput cup 4 0; echo "                                                             "
tput cup 5 0; echo "                              "

nomGr=$(grep -w "$gid" /etc/group | cut -d: -f1)

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
		nomUsu=$(echo "$usuario" | cut -d: -f1)
		ingreso=$(grep -w "x:$uid" /etc/passwd | cut -d: -f5)
		tput cup $w 0; echo "$uid"
		tput cup $w 15; echo "$nomUsu"
		tput cup $w 34; echo "$ingreso"
		let w=$w+1
	fi
done

read volver