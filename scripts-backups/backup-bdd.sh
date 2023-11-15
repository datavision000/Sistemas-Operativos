#!/bin/bash
fechaHora=$(date +%d-%m-%Y,%H:%M)

con=$(grep -w "conexion" /home/admin/config/configBDD | cut -d: -f2)
usuCon=$(grep -w "usuCon" /home/admin/config/configBDD | cut -d: -f2)
bddCon=$(grep -w "bddCon" /home/admin/config/configBDD | cut -d: -f2)
passwdCon=$(grep -w "passwdCon" /home/admin/config/configBDD | cut -d: -f2)

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

mysqldump -h '$con' -u $usuCon -p'$passwdCon' datavision > /home/admin/backups/copias-bdd/qds$fechaHora.sql
