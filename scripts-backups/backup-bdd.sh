#!/bin/bash
fechaHora=$(date +%d-%m-%Y,%H:%M)

if [ "$(ls -A /home/admin/backups/copias-bdd)" ]
then

	copias=($(cd /home/admin/backups/copias-bdd; ls -f qds* -1))
	cd /home/admin/QDS_centro_computos
	num_copias="${#copias[@]}"

	if [ $num_copias -gt 4 ]
	then

		copia_mas_antigua="${copias[0]}"
		rm -r /home/admin/backups/copias-bdd/$copia_mas_antigua
		rm /home/admin/backups/copias-bdd/informe-$copia_mas_antigua

	fi

fi

mysqldump -h '192.168.5.50' -u amadeus.gonzalez -p'55055884' datavision > /home/admin/backups/copias-bdd/qds$fechaHora.sql
