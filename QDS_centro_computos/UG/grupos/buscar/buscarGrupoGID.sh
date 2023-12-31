#!/bin/bash
clear

tput cup 1 0; tput setaf 5; echo "Buscar un Grupo (por GID)"

tput setaf 3; tput cup 3 0; echo "Ingrese el GID del grupo a buscar: "
tput cup 5 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"


while [ true ]
do
	tput  cup 3 35; echo "                                                            "
	tput setaf 7; tput cup 3 35; read gid

	gid2=$(cut -d: -f3 /etc/group | grep -w "$gid")

	if [[ $gid == 0 ]]
	then
		break
	elif [ -z $gid ]
	then
		tput cup 6 0; echo "                                                                      "
		tput setaf 1; tput cup 6 0; echo "Ingrese un dato valido."
	elif [ -z $gid2 ]
	then
		tput cup 6 0; echo "                                                            "
		tput setaf 1; tput cup 6 0; echo "No existe un grupo con GID '$gid' en el sistema..."
		tput cup 7 0; echo "Intente nuevamente."
	else
		tput cup 5 0; echo "                                                           "
		tput cup 6 0; echo "                                                                "
		tput cup 7 0; echo "                                "

		nomGr=$(grep -w "$gid" /etc/group | cut -d: -f1)

		tput cup 5 0; tput setaf 6; echo "Nombre de Grupo:"; tput cup 5 17; tput setaf 7; echo "$nomGr"
		tput cup 6 0; tput setaf 6; echo "GID:"; tput cup 6 5; tput setaf 7; echo "$gid"

		tput cup 9 0; tput setaf 2; echo "Presione cualquier tecla para volver..."; tput setaf 7
		read espera; break
	fi

done