#!/bin/bash
clear

tput setaf 5; tput cup 1 0; echo "Eliminar un Grupo (por GID)"

tput setaf 3; tput cup 3 0; echo "Ingrese el GID del grupo a eliminar: "
tput cup 5 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"

while [ true ]
do
	tput cup 3 37; echo "                                                              "
	tput setaf 7; tput cup 3 37; read gid

	verificacionGr=$(cut -d: -f4 /etc/passwd | grep -w "$gid")
	gid2=$(cut -d: -f3 /etc/group | grep -w "$gid")

	if [[ $gid == 0 ]]
	then
		break
	elif [ -z $gid ]
	then
		tput cup 6 0; echo "                                                                      "
		tput setaf 1; tput cup 6 0; echo "Ingrese un dato valido."
	elif [[ $gid == 1000 ]]
	then
		tput setaf 1; tput cup 6 0; echo "                                                                       "
		tput cup 7 0; echo "                                            "
		tput cup 8 0; echo "                                   "
		tput cup 6 0; echo "Este grupo no puede ser eliminado del sistema!"
		echo "(Grupo administrador)"
	elif [[ ! -z $verificacionGr ]] && [[ $gid != 1000 ]]
	then
		tput cup 6 0; tput setaf 1; echo "                                                                 "
		tput cup 7 0; tput setaf 1; echo "                                                                 "
		tput cup 6 0; echo "El grupo con GID '$gid' no puede ser eliminado del sistema!"
		echo "Contiene usuarios dentro..."
		echo "Ingrese un grupo vacio."
	elif [[ -z $gid2 ]]
	then
		tput cup 6 0; echo "                                                            "
		tput cup 7 0; echo "                                                            "
		tput cup 8 0; echo "                                                            "
		tput setaf 1; tput cup 6 0; echo "No existe un grupo con GID '$gid' en el sistema..."
		tput cup 7 0; echo "Intente nuevamente."
	else
		tput cup 5 0; echo "                                                                   "
		tput cup 6 0; echo "                                                                       "
		tput cup 7 0; echo "                                    "
		tput cup 8 0; echo "                                    "

		nomGr=$(grep -w "$gid" /etc/group | cut -d: -f1)

		tput cup 5 0; tput setaf 6; echo "Nombre de Grupo:"; tput cup 5 17; tput setaf 7; echo "$nomGr"
		tput cup 6 0; tput setaf 6; echo "GID:"; tput cup 6 5; tput setaf 7; echo "$gid"

		tput setaf 3; tput cup 8 0
		echo "Esta seguro que desea eliminar este grupo?"
		echo "Pulse A para aceptar"
		echo "Pulse S para salir sin aceptar"
		tput setaf 7; tput cup 12 0; read opcion

		while [[ $opcion != "A" ]] && [[ $opcion != "S" ]] && [[ $opcion != "s" ]] && [[ $opcion != "a" ]]
		do
			tput cup 12 0; echo "                                     "
			tput setaf 1; tput cup 15 0; echo "Opcion incorrecta!"
			echo "Debe ingresar <A> o <S>."
			tput cup 12 0; tput setaf 7; read opcion
		done

		tput cup 15 0; echo "                                 "
		tput cup 16 0; echo "                             "

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
				sudo groupdel $nomGr
				tput cup 14 0; tput setaf 2
				echo "El grupo con GID '$gid' fue eliminado del sistema correctamente!"
				echo "Toque cualquier tecla para volver..."; tput setaf 7; read espera; break ;;
				
			"S")
				break
				;;
		esac

	fi

done