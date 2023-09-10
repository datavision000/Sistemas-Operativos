#!/bin/bash

clear

tput cup 1 0; tput setaf 5; echo "Realizar backup de la base de datos"
tput cup 3 0; tput setaf 3; echo "Esta seguro que desea realizar un backup de la base de datos actual?"
echo "Pulse B para comenzar backup"
echo "Pulse S para salir"

tput cup 7 0; tput setaf 7; read op

if [[ $op == "b" ]]
then
	op="B"
fi

if [[ $op == "s" ]]
then
	op="S"
fi

case $op in

	"B")
		
		sh /home/admin/scripts-backups/backup-bdd.sh
		tput cup 9 0; tput setaf 2; echo "La copia de seguridad fue realizada correctamente!"
		echo "Toque cualquier tecla para volver..."; tput setaf 7; read espera ;;
		
	"S")

		;;
esac