#!/bin/bash

clear

tput cup 1 0; tput setaf 5; echo "Reestablecer Config. del Sistema"
tput cup 3 0

if [ "$(ls -A /home/admin/backups/copias-etc)" ]
then
	tput cup 3 0; tput setaf 7
	cd /home/admin/backups/copias-etc; ls -d cop* -1

	cantArch=$(ls /home/admin/backups/copias-etc | wc -l)
	cantBackups=$(($cantArch / 2))
	x=$(($cantBackups + 4))
	z=$(($x + 2))

	tput cup $x 0; tput setaf 3; echo "Ingrese el nombre EXACTO de la copia a utilizar: "
	tput cup $z 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"
	tput setaf 7; tput cup $x 49; read copiaElegida

	if [[ $copiaElegida != 0 ]]
	then

		while [ ! -e "$(pwd)/$copiaElegida" ]
		do
			tput cup $(($x + 3)) 0; tput setaf 1; echo "Ingrese una copia valida..." 
			tput cup $x 49; echo "                               "
			tput cup $x 49; tput setaf 7; read copiaElegida
		done

		tput cup $(($x + 3)) 0; tput setaf 1; echo "                                  "

		y=$(($x + 3))

		tput cup $y 0; echo "****************************************************************"
		tput cup $(($y + 1)) 0; echo "*  ATENCION!   Esta accion es irreversible una vez ejecutada.  *"
		tput cup $(($y + 2)) 0; echo "****************************************************************"
		tput cup $(($y + 4)) 0; tput setaf 3; echo "Esta seguro de reestablecer la config. del sistema, usuarios y grupos desde la copia indicada?"
		echo "Pulse R para reestablecer"
		echo "Pulse S para salir sin reestablecer"
		tput cup $(($y + 9)) 0; tput setaf 7; read opcion


		if [[ $opcion == "r" ]]
		then
			opcion="R"
		fi

		if [[ $opcion == "s" ]]
		then
			opcion="S"
		fi

		case $opcion in

			"R")
				# hacer reestablecimiento
				tput cup $(($y + 12)) 0; tput setaf 2; echo "Configuraciones, usuarios y grupos reestablecidos correctamente!"
				tput cup $(($y + 13)) 0; tput setaf 2; echo "Para guardar los cambios, el sistema debera reiniciarse."
				tiempo_restante=5

				while [ $tiempo_restante -ge 0 ]
				do
					tput cup $(($y + 14)) 0; tput setaf 1; echo "Reinicio en $tiempo_restante segundos..."
					sleep 1
					tiempo_restante=$(($tiempo_restante - 1))
				done

				reboot				

				;;
			
			"S")

				;;
		esac

	fi

else
	tput cup 4 0; tput setaf 1
	echo "No hay copias de seguridad guardadas actualmente..."
	echo ""; tput setaf 7; read espera
fi