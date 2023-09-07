#!/bin/bash

while [[ $opcion != 0 ]]
do
	clear
	tput setaf 3
	tput cup 1 0; echo "************************************************"
	tput cup 2 0; echo "*                                              *"
	tput cup 3 0; echo "*           QDS - Centro de computos           *"
	tput cup 4 0; echo "*                                              *"
	tput cup 5 0; echo "************************************************"
	tput setaf 7
	echo ""
	echo "1. Gestionar Usuarios y Grupos"
	echo "2. Actualizar Servicios"
	echo "3. Backup - Base de Datos"
	echo "4. Backup - Config. del sistema" 
	tput setaf 1; echo "0. Salir"
	tput setaf 7; echo " "
	read opcion
	case $opcion in
		1) sh UG/usuariosGrupos.sh ;;
		2) sh actualizar/actualizar-serv-pack.sh ;;
		3) sh respaldoBDD.sh ;;
		4) sh backups/menu-backup-sys.sh ;;
		0) exit ;;
		esac
done
