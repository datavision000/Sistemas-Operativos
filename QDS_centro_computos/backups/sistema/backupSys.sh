#!/bin/bash

clear

tput cup 1 0; tput setaf 5; echo "Realizar Backup de Config. del Sistema"
tput cup 3 0; tput setaf 3; echo "Esta seguro que desea realizar un backup de la configuracion del sistema actual?"
echo "Pulse B para comenzar backup"
echo "Pulse S para salir"

tput cup 7 0; tput setaf 7; read op

while [[ $op != "B" ]] && [[ $op != "b" ]] && [[ $op != "S" ]] && [[ $op != "s" ]]
do
	tput cup 7 0; echo "                                     "
	tput setaf 1; tput cup 10 0; echo "Opcion incorrecta!"
	echo "Debe ingresar <B> o <S>."
	tput cup 7 0; tput setaf 7; read op
done

tput cup 10 0; echo "                                 "
tput cup 11 0; echo "                               "

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
		
		sh /home/admin/scripts-backups/backup-etc.sh
		tput cup 9 0; tput setaf 2; echo "La copia de seguridad fue realizada correctamente!"
		echo "Toque cualquier tecla para volver..."; tput setaf 7; read espera ;;
		
	"S")

		;;
esac