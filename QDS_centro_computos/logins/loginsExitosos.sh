#!/bin/bash

clear

tput cup 1 0; tput setaf 5; echo "Logins al Sistema Exitosos"

tput cup 3 0; tput setaf 3; echo "Cantidad de sesiones a mostrar: "
tput cup 5 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"
tput cup 3 32; tput setaf 7; read cantPedida; echo ""

if [[ $cantPedida != 0 ]]
then

	while ! [[ $cantPedida =~ ^[0-9]+$ ]] || [[ $cantPedida -gt 65 ]]
	do
		tput cup 6 0; tput setaf 1; echo "Debe ingresar un numero (menor o igual a 65)..."
		tput cup 3 32; echo "                                                     "
		tput cup 3 32; tput setaf 7; read cantPedida
	done	

	tput cup 6 0; echo "                                                         "

	tput cup 5 0; echo "                                                        "
	tput setaf 6; tput cup 5 0; echo "Usuario"
	tput cup 5 23; echo "Terminal"
	tput cup 5 39; echo "Fecha"
	tput cup 5 56; echo "Horario"


	tput cup 7 0; tput setaf 7
	last -R | grep -v "reboot" | awk '{printf "%-22s %-15s %-1s %-1s %-9s %-1s %-1s %-12s\n", $1, $2, $3, $5, $4, $6, " - ", $8}' | head -n $cantPedida

	echo " "; echo " "; tput setaf 2; echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera

fi