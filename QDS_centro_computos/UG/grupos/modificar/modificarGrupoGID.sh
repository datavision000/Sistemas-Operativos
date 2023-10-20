#!/bin/bash
clear

tput cup 1 0; tput setaf 5; echo "Modificar un Grupo (por GID)"

tput setaf 3; tput cup 3 0; echo "Ingrese el GID del grupo a modificar: "
tput cup 5 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"


while [ true ]
do
	tput cup 3 38; echo "                                             "
	tput setaf 7; tput cup 3 38; read gid
	gid2=$(cut -d: -f3 /etc/group | grep -w "$gid")
	nomGr=$(grep -w "$gid" /etc/group | cut -d: -f1)

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
	elif [[ $gid == 1001 ]]
	then
		tput cup 6 0; echo "                                                            "
		tput setaf 1; tput cup 6 0; echo "El grupo 'admin' (GID '1001') no puede ser modificado..."
		tput cup 7 0; echo "Intente nuevamente."
	else
		tput cup 5 0; echo "                                                        "
		tput cup 6 0; echo "                                                          "
		tput cup 7 0; echo "                              "

		tput cup 5 0; tput setaf 6; echo "Nombre de Grupo:"; tput cup 5 17; tput setaf 7; echo "$nomGr"
		tput cup 6 0; tput setaf 6; echo "GID:"; tput cup 6 5; tput setaf 7; echo "$gid"

		tput cup 8 0; tput setaf 3; echo "Ingrese el nuevo nombre para el grupo: "
		tput cup 10 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"
	
		while [ true ]
		do
			tput cup 8 39; echo "                                                      "
			tput cup 8 39; tput setaf 7; read nuevoNom
			nuevoNom2=$(cut -d: -f1 /etc/group | grep -w "$nuevoNom")

			if [[ $nuevoNom == 0 ]]
			then
				break 2
			elif [ -z $nuevoNom ]
			then
				tput cup 11 0; echo "                                                                      "
				tput setaf 1; tput cup 11 0; echo "Ingrese un dato valido."
			elif [[ $nuevoNom =~ [0-9] ]]
			then
				tput cup 11 0; echo "                                                               "
				tput setaf 1; tput cup 11 0; echo "El nombre del grupo no puede contener numeros..."
			elif [[ $nuevoNom == $nomGr ]]
			then
				tput cup 11 0; echo "                                                               "
				tput setaf 1; tput cup 11 0; echo "Ingrese un nombre diferente al original..."
			elif [[ $nuevoNom2 != "" ]]
			then
				tput cup 11 0; echo "                                                                                          "
				tput setaf 1; tput cup 11 0; echo "El grupo '$nuevoNom' ya existe en el sistema..."
			else
				tput cup 10 0; echo "                                                              "
				tput cup 11 0; echo "                                                                       "

				nomGrLetras=$(echo "${#nomGr}")
				nuevoNomLetras=$(echo "${#nuevoNom}")
				x=$((58 + $nomGrLetras))
				y=$(($x + 2))
				z=$(($y + $nuevoNomLetras + 2))

				tput setaf 3; tput cup 10 0; echo "Esta seguro que desea modificar el nombre del grupo de"; tput cup 10 55; tput setaf 5; echo "'$nomGr'"
				tput cup 10 $x; tput setaf 3; echo "a"; tput cup 10 $y; tput setaf 5; echo "'$nuevoNom'"; tput cup 10 $z; tput setaf 3; echo "?"
				echo "Pulse M para modificar"
				echo "Pulse S para salir sin modificar"
				tput cup 14 0; tput setaf 7; read opcion

				while [[ $opcion != "S" ]] && [[ $opcion != "M" ]] && [[ $opcion != "m" ]] && [[ $opcion != "s" ]]
				do
					tput cup 14 0; echo "                                     "
					tput setaf 1; tput cup 17 0; echo "Opcion incorrecta!"
					echo "Debe ingresar <M> o <S>."
					tput cup 14 0; tput setaf 7; read opcion
				done

				tput cup 17 0; echo "                                 "
				tput cup 18 0; echo "                               "

				if [[ $opcion == "m" ]]
				then
					opcion="M"
				fi

				if [[ $opcion == "s" ]]
				then
					opcion="S"
				fi

				case $opcion in

					"M") 
						sudo groupmod -n $nuevoNom $nomGr
						tput cup 16 0; tput setaf 2; echo "Nombre del grupo modificado correctamente!"
						echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera; break 2
						;;
						
					"S")
						break 2
						;;
				esac

			fi

		done

	fi

done