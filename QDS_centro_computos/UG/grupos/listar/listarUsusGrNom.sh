#!/bin/bash
clear

tput cup 1 0; tput setaf 5; echo "Listar Usuarios de un Grupo (por nombre)"

tput setaf 3; tput cup 3 0; echo "Ingrese el nombre del grupo a buscar: "
tput cup 5 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"


while [ true ]
do
	tput cup 3 38; echo "                                                         "
	tput setaf 7; tput cup 3 38; read nomGr

	nomGr2=$(cut -d: -f1 /etc/group | grep -w "$nomGr")

	if [ $gid == 0 ]
	then
		break
	elif [ -z $nomGr2 ]
	then
		tput cup 6 0; echo "                                                            "
		tput setaf 1; tput cup 6 0; echo "No existe un grupo llamado '$nomGr' en el sistema..."
		tput cup 7 0; echo "Intente nuevamente."
	else

		tput cup 5 0; echo "                                                        "
		tput cup 6 0; echo "                                                             "
		tput cup 7 0; echo "                              "

		gid=$(grep -w "$nomGr:x" /etc/group | cut -d: -f3)

		tput cup 5 0; tput setaf 5; echo "Usuarios del grupo '$nomGr' (GID: $gid)"

		tput setaf 6
		tput cup 7 0; echo "UID"
		tput cup 7 8; echo "Usuario"
		tput cup 7 30; echo "Ingreso al sistema"

		w=9

		tput setaf 7

		for usuario in $(cut -d: -f1,3,4 /etc/passwd)
		do
			gidUsu=$(echo "$usuario" | cut -d: -f3)

			if [ "$gidUsu" -eq "$gid" ]
			then
				uid=$(echo "$usuario" | cut -d: -f2)
				ingreso=$(grep -w "x:$uid" /etc/passwd | cut -d: -f5)
				nomUsu=$(echo "$usuario" | cut -d: -f1)
				tput cup $w 0; echo "$uid"
				tput cup $w 8; echo "$nomUsu"
				tput cup $w 30; echo "$ingreso"
				let w=$w+1
			fi
		done

		verificacion=$(cat /etc/passwd | cut -d: -f4 | grep -w "$gid")

		if [ -z "$verificacion" ]
		then
			tput cup 7 0; echo "                                                        "
			tput cup 8 0; tput setaf 1; echo "El grupo '$nomGr' (GID '$gid') no contiene usuarios dentro actualmente..."
		fi

		echo " "; echo " "; tput setaf 2; echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera; break

	fi

done