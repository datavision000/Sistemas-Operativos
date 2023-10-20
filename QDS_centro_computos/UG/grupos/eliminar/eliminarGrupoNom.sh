#!/bin/bash
clear

tput setaf 5; tput cup 1 0; echo "Eliminar un Grupo (por nombre)"

tput setaf 3; tput cup 3 0; echo "Ingrese el nombre del grupo a eliminar: "
tput cup 5 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"

while [ true ]
do
	tput cup 3 40; echo "                                                                         "
	tput setaf 7; tput cup 3 40; read nomGr

	gid=$(grep -w "$nomGr:x" /etc/group | cut -d: -f3)
	verificacionGr=$(cut -d: -f4 /etc/passwd | grep -w "$gid")
	nomGr2=$(cut -d: -f1 /etc/group | grep -w "$nomGr")

	if [[ $nomGr == 0 ]]
	then
		break
	elif [ -z $nomGr ]
	then
		tput cup 6 0; echo "                                                                      "
		tput setaf 1; tput cup 6 0; echo "Ingrese un dato valido."
	elif [[ $gid == 1001 ]]
	then
		tput setaf 1; tput cup 6 0; echo "                                                                       "
		tput cup 7 0; echo "                                            "
		tput cup 8 0; echo "                                   "
		tput cup 6 0; echo "Este grupo no puede ser eliminado del sistema!"
		echo "(Grupo administrador)"
	elif [[ ! -z $verificacionGr ]] && [[ $gid != 1001 ]]
	then
		tput cup 6 0; tput setaf 1; echo "                                                                        "
		tput cup 7 0; tput setaf 1; echo "                                                                        "
		tput cup 6 0; echo "El grupo llamado '$nomGr' no puede ser eliminado del sistema!"
		echo "Contiene usuarios dentro..."
		echo "Ingrese un grupo vacio."
	elif [[ -z $nomGr2 ]]
	then
		tput cup 6 0; echo "                                                                 "
		tput cup 7 0; echo "                                                                "
		tput cup 8 0; echo "                                                                "
		tput setaf 1; tput cup 6 0; echo "No existe un grupo llamado '$nomGr' en el sistema..."
		tput cup 7 0; echo "Intente nuevamente."
	else
		tput cup 5 0; echo "                                                                   "
		tput cup 6 0; echo "                                                                       "
		tput cup 7 0; echo "                                    "
		tput cup 8 0; echo "                                    "

		tput cup 5 0; tput setaf 6; echo "Nombre de Grupo:"; tput cup 5 17; tput setaf 7; echo "$nomGr"
		tput cup 6 0; tput setaf 6; echo "GID:"; tput cup 6 5; tput setaf 7; echo "$gid"

		tput setaf 3; tput cup 8 0
		echo "Esta seguro que desea eliminar este grupo?"
		echo "Pulse E para eliminar"
		echo "Pulse S para salir sin eliminar"
		tput setaf 7; tput cup 12 0; read opcion

		while [[ $opcion != "E" ]] && [[ $opcion != "S" ]] && [[ $opcion != "s" ]] && [[ $opcion != "e" ]]
		do
			tput cup 12 0; echo "                                     "
			tput setaf 1; tput cup 15 0; echo "Opcion incorrecta!"
			echo "Debe ingresar <E> o <S>."
			tput cup 12 0; tput setaf 7; read opcion
		done

		tput cup 15 0; echo "                                 "
		tput cup 16 0; echo "                             "

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
				echo "El grupo llamado '$nomGr' fue eliminado del sistema correctamente!"
				echo "Toque cualquier tecla para volver..."; tput setaf 7; read espera; break ;;
				
			"S")
				break
				;;
		esac

	fi

done