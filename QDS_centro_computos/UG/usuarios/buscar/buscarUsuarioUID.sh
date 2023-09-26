#!/bin/bash
clear

tput setaf 5; tput cup 1 0; echo "Buscar un Usuario (por UID)"

tput setaf 3; tput cup 3 0; echo "Ingrese el UID del usuario a buscar: "
tput setaf 7; tput cup 3 37; read uid

uid2=$(grep -w "x:$uid" /etc/passwd | cut -d: -f3)

while [ -z $uid2 ]
do
	tput cup 6 0; echo "                                                            "
        tput setaf 1; tput cup 6 0; echo "No existe un usuario con UID '$uid' en el sistema..."
	tput cup 7 0; echo "Intente nuevamente."
	tput setaf 7
        tput cup 3 37; echo "                                                              "
	tput cup 3 37; read uid
	uid2=$(cut -d: -f3 /etc/passwd | grep -w "$uid")
done

tput cup 6 0; echo "                                                                            "
tput cup 7 0; echo "                              "

nomUsu=$(grep -w "x:$uid" /etc/passwd | cut -d: -f1)
ingreso=$(grep -w "x:$uid" /etc/passwd | cut -d: -f5)
gid=$(grep -w "x:$uid" /etc/passwd | cut -d: -f4)
grupo=$(grep -w "$gid:" /etc/group | cut -d: -f1)
mail=$(grep -w "$nomUsu" /etc/mails | cut -d: -f2)

tput cup 5 0; tput setaf 6; echo "Nombre de Usuario:"; tput cup 5 19; tput setaf 7; echo "$nomUsu"
tput cup 6 0; tput setaf 6; echo "UID:"; tput cup 6 5; tput setaf 7; echo "$uid"
tput cup 7 0; tput setaf 6; echo "Grupo:"; tput cup 7 7; tput setaf 7; echo "$grupo (GID: $gid)"
tput cup 8 0; tput setaf 6; echo "Mail:"; tput cup 8 6; tput setaf 7; echo "$mail"
tput cup 9 0; tput setaf 6; echo "Ingreso al sistema: "; tput cup 9 20; tput setaf 7; echo "$ingreso"

tput cup 12 0; tput setaf 2; echo "Presione cualquier tecla para volver..."; tput setaf 7
read espera