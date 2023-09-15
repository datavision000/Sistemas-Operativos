#!/bin/bash
fechaHora=$(date +%d-%m-%Y,%H:%M)

if [ "$(ls -A /home/admin/backups/copias-etc)" ]
then

	copias=($(cd /home/admin/backups/copias-etc; ls -d cop* -1))
	cd /home/admin/QDS_centro_computos
	num_copias="${#copias[@]}"

	if [ $num_copias -gt 4 ]
	then

		copia_mas_antigua="${copias[0]}"
		rm -r /home/admin/backups/copias-etc/$copia_mas_antigua
		rm /home/admin/backups/copias-etc/informe-$copia_mas_antigua

	fi

fi


rsync -zaq --log-file=/home/admin/backups/copias-etc/informe-copia-etc$fechaHora /etc/ /home/admin/backups/copias-etc/copia-etc$fechaHora
