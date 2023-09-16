#!/bin/bash
clear

tput cup 1 0; tput setaf 5; echo "Buscar un Usuario (por nombre)"

tput setaf 3; tput cup 3 0; echo "Ingrese el nombre del usuario a buscar: "
tput setaf 7; tput cup 3 40; read nomUsu

nomUsu2=$(cut -d: -f1 /etc/passwd | grep -w "$nomUsu")

while [ -z $nomUsu2 ]
do
	tput cup 6 0; echo "                                                            "
        tput setaf 1; tput cup 6 0; echo "No existe un usuario llamado '$nomUsu' en el sistema..."
	tput cup 7 0; echo "Intente nuevamente."
	tput setaf 7
        tput cup 3 40; echo "                                                              "
	tput cup 3 40; read nomUsu
	nomUsu2=$(cut -d: -f1 /etc/passwd | grep -w "$nomUsu")
done

tput cup 6 0; echo "                                                                         "
tput cup 7 0; echo "                              "

uid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f3)
ingreso=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f5)
gid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f4)
grupo=$(grep -w "$gid:" /etc/group | cut -d: -f1)

tput cup 5 0; tput setaf 6; echo "Nombre de Usuario:"; tput cup 5 19; tput setaf 7; echo "$nomUsu"
tput cup 6 0; tput setaf 6; echo "UID:"; tput cup 6 5; tput setaf 7; echo "$uid"
tput cup 7 0; tput setaf 6; echo "Grupo:"; tput cup 7 7; tput setaf 7; echo "$grupo (GID: $gid)"
tput cup 8 0; tput setaf 6; echo "Ingreso al sistema: "; tput cup 8 20; tput setaf 7; echo "$ingreso"

tput cup 11 0; tput setaf 2; echo "Presione cualquier tecla para volver..."; tput setaf 7
read espera