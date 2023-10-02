#!/bin/bash

clear

tput cup 1 0; tput setaf 5; echo "Ultima Sesion de un Usuario en el Sistema (por nombre)"

tput setaf 3; tput cup 3 0; echo "Ingrese el nombre del usuario a buscar: "
tput cup 5 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"
tput cup 3 40; tput setaf 7; read usu

if [[ $usu != 0 ]]
then

	nomUsu2=$(cut -d: -f1 /etc/passwd | grep -w "$usu")

	while [ -z $nomUsu2 ]
	do
		tput cup 6 0; echo "                                                                   "
		tput setaf 1; tput cup 6 0; echo "No existe un usuario llamado '$usu' en el sistema..."
		tput cup 7 0; echo "Intente nuevamente."
		tput setaf 7
		tput cup 3 40; echo "                                                              "
		tput cup 3 40; read usu
		nomUsu2=$(cut -d: -f1 /etc/passwd | grep -w "$usu")
	done

	tput cup 6 0; echo "                                                                         "
	tput cup 7 0; echo "                              "

	tput cup 5 0; echo "                                                        "
	tput setaf 6; tput cup 5 0
	echo "Usuario"
	tput cup 5 23; echo "Terminal"
	tput cup 5 39; echo "Fecha"
	tput cup 5 57; echo "Hora"

	tput cup 7 0; tput setaf 7

	lastlog -u $usu | tail -1 | awk '{printf "%-22s %-15s %-1s %-1s %-10s %-12s\n", $1, $2, $5, $4, $8, $6}'


	echo " "; echo " "; tput setaf 2; echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera

fi