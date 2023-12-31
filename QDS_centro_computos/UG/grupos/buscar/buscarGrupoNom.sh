#!/bin/bash
clear

tput setaf 5; tput cup 1 0; echo "Buscar un Grupo (por nombre)"

tput setaf 3; tput cup 3 0; echo "Ingrese el nombre del grupo a buscar: "
tput cup 5 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"

while [ true ]
do
	tput cup 3 38; echo "                                                        "
	tput setaf 7; tput cup 3 38; read nomGr
	nomGr2=$(cut -d: -f1 /etc/group | grep -w "$nomGr")

	if [[ $nomGr == 0 ]]
	then
		break
	elif [ -z $nomGr ]
	then
		tput cup 6 0; echo "                                                                      "
		tput setaf 1; tput cup 6 0; echo "Ingrese un dato valido."
	elif [ -z $nomGr2 ]
	then
		tput cup 6 0; echo "                                                            "
		tput setaf 1; tput cup 6 0; echo "No existe un grupo llamado '$nomGr' en el sistema..."
		tput cup 7 0; echo "Intente nuevamente."
	else

		tput cup 5 0; echo "                                                        "
		tput cup 6 0; echo "                                              "
		tput cup 7 0; echo "                              "

		gid=$(grep -w "$nomGr:x" /etc/group | cut -d: -f3)

		tput cup 5 0; tput setaf 6; echo "Nombre de Grupo:"; tput cup 5 17; tput setaf 7; echo "$nomGr"
		tput cup 6 0; tput setaf 6; echo "GID:"; tput cup 6 5; tput setaf 7; echo "$gid"

		tput cup 9 0; tput setaf 2; echo "Presione cualquier tecla para volver..."; tput setaf 7
		read espera; break

	fi

done