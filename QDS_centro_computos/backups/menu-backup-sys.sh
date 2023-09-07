#!/bin/bash

while [[ $opcion != 0 ]]
do
	clear
	tput setaf 5; tput cup 1 0; echo "Backup de config. del sistema"
	tput setaf 7
	echo ""
	echo "1. Realizar backup"
	echo "2. Listar backups"
	tput setaf 3; echo "0. Volver"
	tput setaf 7; echo " "
	read opcion
	case $opcion in
		1) sh backups/backup-sys.sh ;;
		2) sh backups/ver-backups-sys.sh ;;
		0) exit ;;
	esac
done


