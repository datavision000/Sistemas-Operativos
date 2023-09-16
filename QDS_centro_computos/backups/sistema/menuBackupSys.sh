#!/bin/bash

while [[ $opcion != 0 ]]
do
	clear
	tput setaf 5; tput cup 1 0; echo "Backup de Config. del Sistema"
	tput setaf 7
	echo ""
	echo "1. Realizar Backup"
	echo "2. Listar Backups"
	echo "3. Reestablecer a Partir de Backup"
	tput setaf 3; echo "0. Volver"
	tput setaf 7; echo " "
	read opcion
	case $opcion in
		1) sh backups/sistema/backupSys.sh ;;
		2) sh backups/sistema/verBackupsSys.sh ;;
		3) sh backups/sistema/reestablecerSys.sh ;;
		0) exit ;;
	esac
done


