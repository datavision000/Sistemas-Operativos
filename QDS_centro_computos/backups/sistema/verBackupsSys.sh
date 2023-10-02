#!/bin/bash

clear

tput cup 1 0; tput setaf 5; echo "Backups de las Config. del Sistema"
tput cup 3 0

if [ "$(ls -A /home/admin/backups/copias-etc)" ]
then
	tput cup 3 0; tput setaf 3
	cd /home/admin/backups/copias-etc; ls -d cop* -1
	cd /home/admin/QDS_centro_computos
else
	tput cup 4 0; tput setaf 1
	echo "No hay copias de seguridad guardadas actualmente..."
fi

echo " "; tput setaf 2; echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera
