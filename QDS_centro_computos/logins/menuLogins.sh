#!/bin/bash

while [[ $opcion != 0 ]]
do
	clear
	tput setaf 5; tput cup 1 0; echo "Gestion de logins"
	tput setaf 7
	echo ""
	echo "1. Usuarios Conectados en Este Momento"
	echo "2. Ultima Sesion de los Usuarios"
	echo "3. Ultima Sesion de un Usuario"
	echo "4. Logins Exitosos"
	echo "5. Logins Fallidos"
	tput setaf 3; echo "0. Volver"
	tput setaf 7; echo " "
	read opcion
	case $opcion in
		1) sh logins/ususConectados.sh ;;
		2) sh logins/ultSesionUsus.sh ;;
		3) sh logins/ultSesionUsu.sh ;;
		4) sh logins/loginsExitosos.sh ;;
		5) sh logins/loginsFallidos.sh ;;
		0) exit ;;
	esac
done
