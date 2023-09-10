#!/bin/bash

while [[ $opcion != 0 ]]
do
	clear
	tput setaf 5; tput cup 1 0; echo "Gestion de logins"
	tput setaf 7
	echo ""
	echo "1. Ultimos Usuarios Conectados"
	echo "2. Intentos de Login Exitosos"
	echo "3. Intentos de Login Fallidos"
	tput setaf 3; echo "0. Volver"
	tput setaf 7; echo " "
	read opcion
	case $opcion in
		1) sh logins/ultUsusConectados.sh ;;
		2) sh logins/loginsExitosos.sh ;;
		3) sh logins/loginsFallidos.sh ;;
		0) exit ;;
	esac
done
