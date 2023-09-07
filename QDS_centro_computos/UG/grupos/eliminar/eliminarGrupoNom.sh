#!/bin/bash

clear

tput setaf 3; tput cup 1 0; echo "Ingrese el nombre del grupo a eliminar: "
tput setaf 7; tput cup 1 40; read nomGr

gid=$(grep -w "$nomGr:x" /etc/group | cut -d: -f3)
verificacionGr=$(cut -d: -f4 /etc/passwd | grep -w "$gid")

while [[ ! -z $verificacionGr ]]
do
	tput cup 4 0; tput setaf 1; echo "                                                                        "
	tput cup 4 0; echo "El grupo llamado '$nomGr' no puede ser eliminado del sistema!"
	echo "Contiene usuarios dentro..."
	echo "Ingrese un grupo vacio."
	tput cup 1 40; echo "                                                       "
	tput cup 1 40; tput setaf 7; read nomGr
	gid=$(grep -w "$nomGr:x" /etc/group | cut -d: -f3)
	verificacionGr=$(cut -d: -f4 /etc/passwd | grep -w "$gid")
done

tput cup 4 0; echo "                                                              "
tput cup 5 0; echo "                                  "
tput cup 6 0; echo "                                 "

nomGr2=$(cut -d: -f1 /etc/group | grep -w "$nomGr")

while [[ -z $nomGr2 ]]
do
	tput cup 4 0; echo "                                                            "
        tput setaf 1; tput cup 4 0; echo "No existe un grupo llamado '$nomGr' en el sistema..."
	tput cup 5 0; echo "Intente nuevamente."
	tput setaf 7
        tput cup 1 40; echo "                                                              "
	tput cup 1 40; read nomGr
	nomGr2=$(cut -d: -f1 /etc/group | grep -w "$nomGr")
done

tput cup 4 0; echo "                                                          "
tput cup 5 0; echo "                              "

gid=$(grep -w "$nomGr:x" /etc/group | cut -d: -f3)

tput cup 3 0; tput setaf 6; echo "Nombre de Grupo:"; tput cup 3 17; tput setaf 7; echo "$nomGr"
tput cup 4 0; tput setaf 6; echo "GID:"; tput cup 4 5; tput setaf 7; echo "$gid"

tput setaf 3; tput cup 6 0
echo "Esta seguro que desea eliminar este grupo?"
echo "Pulse E para eliminar"
echo "Pulse S para salir sin eliminar"
tput setaf 7; tput cup 10 0; read opcion

if [[ $opcion == "e" ]]
then
	opcion="E"
fi

if [[ $opcion == "s" ]]
then
	opcion="S"
fi

case $opcion in

	"E") 
		sudo groupdel $nomGr
		tput cup 12 0; tput setaf 2
		echo "El grupo llamado '$nomGr' fue eliminado del sistema correctamente!"
		echo "Toque cualquier tecla para volver..."; tput setaf 7; read espera ;;
		
	"S")

		;;
esac