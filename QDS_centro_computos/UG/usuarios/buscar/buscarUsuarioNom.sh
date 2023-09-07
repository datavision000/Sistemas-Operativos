#!/bin/bash

clear

tput setaf 3; tput cup 1 0; echo "Ingrese el nombre del usuario a buscar: "
tput setaf 7; tput cup 1 40; read nomUsu

nomUsu2=$(cut -d: -f1 /etc/passwd | grep -w "$nomUsu")

while [ -z $nomUsu2 ]
do
	tput cup 4 0; echo "                                                            "
        tput setaf 1; tput cup 4 0; echo "No existe un usuario llamado '$nomUsu' en el sistema..."
	tput cup 5 0; echo "Intente nuevamente."
	tput setaf 7
        tput cup 1 40; echo "                                                              "
	tput cup 1 40; read nomUsu
	nomUsu2=$(cut -d: -f1 /etc/passwd | grep -w "$nomUsu")
done

tput cup 4 0; echo "                                                                         "
tput cup 5 0; echo "                              "

uid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f3)
ingreso=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f5)
gid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f4)
grupo=$(grep -w "$gid:" /etc/group | cut -d: -f1)

tput cup 3 0; tput setaf 6; echo "Nombre de Usuario:"; tput cup 3 19; tput setaf 7; echo "$nomUsu"
tput cup 4 0; tput setaf 6; echo "UID:"; tput cup 4 5; tput setaf 7; echo "$uid"
tput cup 5 0; tput setaf 6; echo "Grupo:"; tput cup 5 7; tput setaf 7; echo "$grupo (GID: $gid)"
tput cup 6 0; tput setaf 6; echo "Ingreso al sistema: "; tput cup 6 20; tput setaf 7; echo "$ingreso"

tput cup 9 0; tput setaf 2; echo "Presione cualquier tecla para volver..."; tput setaf 7
read espera