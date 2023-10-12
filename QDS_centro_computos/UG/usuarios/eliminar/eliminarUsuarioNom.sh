#!/bin/bash
clear

tput setaf 5; tput cup 1 0; echo "Eliminar un Usuario (por nombre)"

tput setaf 3; tput cup 3 0; echo "Ingrese el nombre del usuario a eliminar: "
tput cup 5 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"

while [ true ]
do
	tput cup 3 42; echo "                                                    "
	tput setaf 7; tput cup 3 42; read nomUsu

	nomUsu2=$(cut -d: -f1 /etc/passwd | grep -w "$nomUsu")
	uid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f3)

	if [[ $nomUsu == 0 ]]
	then
		break
	elif [ -z $nomUsu2 ]
	then
		tput cup 6 0; echo "                                                            "
		tput setaf 1; tput cup 6 0; echo "No existe un usuario llamado '$nomUsu' en el sistema..."
		tput cup 7 0; echo "Intente nuevamente."
	elif [ $uid == 1000 ]
	then
		tput cup 6 0; echo "                                                              "
		tput cup 7 0; echo "                                                               "
       	tput setaf 1; tput cup 6 0; echo "No es posible eliminar a este usuario..."
	else

		uid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f3)
		ingreso=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f5)
		gid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f4)
		grupo=$(grep -w "$gid:" /etc/group | cut -d: -f1)
		mail=$(grep -w "$nomUsu" /etc/mails | cut -d: -f2)

		tput cup 5 0; echo "                                                        "
		tput cup 6 0; echo "                                                              "
		tput cup 7 0; echo "                                                        "

		tput cup 5 0; tput setaf 6; echo "Nombre de Usuario:"; tput cup 5 19; tput setaf 7; echo "$nomUsu"
		tput cup 6 0; tput setaf 6; echo "UID:"; tput cup 6 5; tput setaf 7; echo "$uid"
		tput cup 7 0; tput setaf 6; echo "Grupo:"; tput cup 7 7; tput setaf 7; echo "$grupo (GID: $gid)"
		tput cup 8 0; tput setaf 6; echo "Mail:"; tput cup 8 6; tput setaf 7; echo "$mail"
		tput cup 9 0; tput setaf 6; echo "Ingreso al sistema: "; tput cup 9 20; tput setaf 7; echo "$ingreso"

		tput cup 11 0; tput setaf 3; echo "Desea eliminar el directorio personal del usuario?"
		echo "Pulse <S> para 'si' o <N> para 'no'"
		tput cup 14 0; tput setaf 7; read opcionDirectorio

		while [[ $opcionDirectorio != "S" ]] && [[ $opcionDirectorio != "N" ]] && [[ $opcionDirectorio != "n" ]] && [[ $opcionDirectorio != "s" ]]
		do
			tput cup 14 0; echo "                                     "
			tput setaf 1; tput cup 17 0; echo "Opcion incorrecta!"
			echo "Debe ingresar <N> o <S>."
			tput cup 14 0; tput setaf 7; read opcionDirectorio
		done

		tput cup 17 0; echo "                                 "
		tput cup 18 0; echo "                               "

		if [[ $opcionDirectorio == "s" ]]
		then
			opcionDirectorio="S"
		fi

		if [[ $opcionDirectorio == "n" ]]
		then
			opcionDirectorio="N"
		fi

		tput setaf 3; tput cup 16 0
		echo "Esta seguro que desea eliminar este usuario?"
		echo "Pulse E para eliminar"
		echo "Pulse S para salir sin eliminar"
		tput setaf 7; tput cup 20 0; read opcion

		while [[ $opcion != "E" ]] && [[ $opcion != "S" ]] && [[ $opcion != "s" ]] && [[ $opcion != "e" ]]
		do
			tput cup 20 0; echo "                                     "
			tput setaf 1; tput cup 23 0; echo "Opcion incorrecta!"
			echo "Debe ingresar <E> o <S>."
			tput cup 20 0; tput setaf 7; read opcion
		done

		tput cup 23 0; echo "                                 "
		tput cup 24 0; echo "                               "
		
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
			
				if [[ $opcionDirectorio == "S" ]]
				then
					sudo userdel -f -r $nomUsu
				else
					sudo userdel -f $nomUsu
				fi

				if [[ $grupo == "admin" ]]
				then
					mv /etc/sudoers /etc/sudoers2
					grep -v "$nomUsu ALL" /etc/sudoers2 > /etc/sudoers
					rm /etc/sudoers2
				fi

				mv /etc/mails /etc/mails2
				grep -v "$nomUsu" /etc/mails2 > /etc/mails
				rm /etc/mails2

				tput cup 23 0; tput setaf 2
				echo "El usuario llamado '$nomUsu' fue eliminado del sistema correctamente!"
				echo "Toque cualquier tecla para volver..."; tput setaf 7; read espera; break ;;
			
			"S")
				break
				;;
		esac

	fi

done