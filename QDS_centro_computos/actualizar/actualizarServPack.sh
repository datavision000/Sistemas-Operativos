#!/bin/bash

clear
tput setaf 5; tput cup 1 0; echo "Actualizar Servicios y Paquetes"
tput setaf 1; tput cup 3 0

echo "***********************************************"
echo "* Esta operacion puede tardar varios minutos! *"
echo "***********************************************"

tput cup 7 0; tput setaf 3
echo "Ultima actualizacion realizada:"
tput cup 7 32; tput setaf 7; cat /home/admin/QDS_centro_computos/backups/registros/ult-actualizacion.txt

tput cup 9 0; tput setaf 3; echo "Esta seguro que desea continuar? No podra cancelar la operacion cuando este en curso..."
echo "Pulse A para aceptar"
echo "Pulse S para salir sin aceptar"
tput cup 13 0; tput setaf 7; read opcion

if [[ $opcion == "a" ]]
then
	opcion="A"
fi

if [[ $opcion == "s" ]]
then
	opcion="S"
fi

case $opcion in

	"A")
		clear
		tput setaf 5; tput cup 1 0; echo "Actualizando servicios y paquetes..."
		echo " "; tput setaf 1
		echo "*************************************************************"
		echo "* No presione ninguna tecla hasta que la operacion termine! *"
		echo "*************************************************************"

		fechaActual=$(date +%d/%m/%Y)
		horaActual=$(date +%H:%M)
		echo "$fechaActual - $horaActual" > /home/admin/QDS_centro_computos/backups/registros/ult-actualizacion.txt
		echo ""; tput setaf 7
		sh /home/admin/scripts-backups/update-serv-pack.sh
		echo ""; tput setaf 2; echo "Servicios y paquetes actualizados correctamente!"
		echo "Toque cualquier tecla para volver..."; tput setaf 7; read espera
		
		;;
		
	"S")

		;;
esac

