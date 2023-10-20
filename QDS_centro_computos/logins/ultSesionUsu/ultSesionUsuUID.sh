#!/bin/bash

clear

tput cup 1 0; tput setaf 5; echo "Ultima Sesion de un Usuario en el Sistema (por UID)"

tput setaf 3; tput cup 3 0; echo "Ingrese el UID del usuario a buscar: "
tput cup 5 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"

while [ true ]
do
	tput cup 3 37; echo "                                                "
	tput cup 3 37; tput setaf 7; read uid
	uid2=$(grep -w "x:$uid" /etc/passwd | cut -d: -f3)

	if [[ $uid == 0 ]]
	then
		break
	elif [ -z $uid ]
	then
		tput cup 6 0; echo "                                                                      "
		tput setaf 1; tput cup 6 0; echo "Ingrese un dato valido."
	elif [ -z $uid2 ]
	then
		tput cup 6 0; echo "                                                                     "
		tput setaf 1; tput cup 6 0; echo "No existe un usuario con UID '$uid' en el sistema..."
		tput cup 7 0; echo "Intente nuevamente."
	else
		tput cup 5 0; echo "                                                      "
		tput cup 6 0; echo "                                                                          "
		tput cup 7 0; echo "                              "

		tput setaf 6; tput cup 5 0
		echo "Usuario"
		tput cup 5 23; echo "Terminal"
		tput cup 5 39; echo "Fecha"
		tput cup 5 57; echo "Hora"

		tput cup 7 0; tput setaf 7

		usu=$(grep -w "x:$uid" /etc/passwd | cut -d: -f1)

		lastlog -u $usu | tail -1 | awk '{printf "%-22s %-15s %-1s %-1s %-10s %-12s\n", $1, $2, $5, $4, $8, $6}'

		echo " "; echo " "; tput setaf 2; echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera; break
	fi

done