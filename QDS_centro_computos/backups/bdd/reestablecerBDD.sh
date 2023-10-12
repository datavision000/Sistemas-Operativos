#!/bin/bash
clear

tput cup 1 0; tput setaf 5; echo "Reestablecer Base de Datos"
tput cup 3 0

if [ "$(ls -A /home/admin/backups/copias-bdd)" ]
then
	tput cup 3 0; tput setaf 7
	cd /home/admin/backups/copias-bdd; ls -f qds* -1

	cantBackups=$(ls /home/admin/backups/copias-bdd | wc -l)
	x=$(($cantBackups + 4))
	z=$(($x + 2))

	tput cup $x 0; tput setaf 3; echo "Ingrese el nombre EXACTO de la copia a utilizar: "
	tput cup $z 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"
	
	while [ true ]
	do
		tput cup $x 49; echo "                                                                "
		tput setaf 7; tput cup $x 49; read copiaElegida

		if [ $copiaElegida == 0 ]
		then
			break
		elif [ ! -e "$(pwd)/$copiaElegida" ]
		then
			tput cup $(($x + 3)) 0; tput setaf 1; echo "                               "
			tput cup $(($x + 3)) 0; tput setaf 1; echo "Ingrese una copia valida..." 
		else
			y=$(($x + 3))
			
			tput cup $z 0; echo "                                                "
			tput setaf 1
			tput cup $y 0; echo "****************************************************************"
			tput cup $(($y + 1)) 0; echo "*  ATENCION!   Esta accion es irreversible una vez ejecutada.  *"
			tput cup $(($y + 2)) 0; echo "****************************************************************"
			tput cup $(($y + 4)) 0; tput setaf 3; echo "Esta seguro de reestablecer la config. del sistema, usuarios y grupos desde la copia indicada?"
			echo "Pulse R para reestablecer"
			echo "Pulse S para salir sin reestablecer"
			tput cup $(($y + 9)) 0; tput setaf 7; read opcion

			while [[ $opcion != "R" ]] && [[ $opcion != "r" ]] && [[ $opcion != "S" ]] && [[ $opcion != "s" ]]
			do
				tput cup $(($y + 9)) 0; echo "                                     "
				tput setaf 1; tput cup $(($y + 12)) 0; echo "Opcion incorrecta!"
				echo "Debe ingresar <R> o <S>."
				tput cup $(($y + 9)) 0; tput setaf 7; read opcion
			done

			tput cup $(($y + 12)) 0; echo "                                 "
			tput cup $(($y + 13)) 0; echo "                               "

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
					mysql -u root -p'DVeul000' -e "DROP DATABASE QDS; CREATE DATABASE QDS;"
					mysql -u root -p'DVeul000' QDS < $copiaElegida
					tput cup $(($y + 12)) 0; tput setaf 2; echo "Base de datos reestablecida correctamente!"
					fechaActual=$(date +%d/%m/%Y)
					horaActual=$(date +%H:%M)
					echo "$fechaActual - $horaActual" > /home/admin/QDS_centro_computos/backups/registros/ult-reestablecimiento-bdd.txt
					echo "Toque cualquier tecla para volver..."; tput setaf 7; read espera; break ;;
				
				"S")
					break
					;;
			esac
		fi

	done

else
	tput cup 4 0; tput setaf 1
	echo "No hay copias de seguridad guardadas actualmente..."
	echo ""; tput setaf 7; read espera
fi