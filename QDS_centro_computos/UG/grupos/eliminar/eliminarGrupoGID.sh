#!/bin/bash
clear

tput setaf 5; tput cup 1 0; echo "Eliminar un Grupo (por GID)"

tput setaf 3; tput cup 3 0; echo "Ingrese el GID del grupo a eliminar: "
tput cup 5 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"
tput setaf 7; tput cup 3 37; read gid

if [[ $gid != 0 ]]
then

	verificacionGr=$(cut -d: -f4 /etc/passwd | grep -w "$gid")

	while [[ ! -z $verificacionGr ]]
	do
		tput cup 6 0; tput setaf 1; echo "                                                                 "
		tput cup 6 0; echo "El grupo con GID '$gid' no puede ser eliminado del sistema!"
		echo "Contiene usuarios dentro..."
		echo "Ingrese un grupo vacio."
		tput cup 3 37; echo "                                                      "
		tput cup 3 37; tput setaf 7; read gid
		verificacionGr=$(cut -d: -f4 /etc/passwd | grep -w "$gid")
	done

	tput cup 6 0; echo "                                                                "
	tput cup 7 0; echo "                                  "
	tput cup 8 0; echo "                                 "

	gid2=$(cut -d: -f3 /etc/group | grep -w "$gid")

	while [[ -z $gid2 ]]
	do
		tput cup 6 0; echo "                                                            "
		tput setaf 1; tput cup 6 0; echo "No existe un grupo con GID '$gid' en el sistema..."
		tput cup 7 0; echo "Intente nuevamente."
		tput setaf 7
		tput cup 3 37; echo "                                                              "
		tput cup 3 37; read gid
		gid2=$(cut -d: -f3 /etc/group | grep -w "$gid")
	done

	tput cup 6 0; echo "                                              "
	tput cup 7 0; echo "                              "

	nomGr=$(grep -w "$gid" /etc/group | cut -d: -f1)

	tput cup 5 0; echo "                                                        "

	tput cup 5 0; tput setaf 6; echo "Nombre de Grupo:"; tput cup 5 17; tput setaf 7; echo "$nomGr"
	tput cup 6 0; tput setaf 6; echo "GID:"; tput cup 6 5; tput setaf 7; echo "$gid"

	tput setaf 3; tput cup 8 0
	echo "Esta seguro que desea eliminar este grupo?"
	echo "Pulse E para eliminar"
	echo "Pulse S para salir sin eliminar"
	tput setaf 7; tput cup 12 0; read opcion

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
			tput cup 14 0; tput setaf 2
			echo "El grupo con GID '$gid' fue eliminado del sistema correctamente!"
			echo "Toque cualquier tecla para volver..."; tput setaf 7; read espera ;;
			
		"S")

			;;
	esac

fi