#!/bin/bash
clear

tput setaf 5; tput cup 1 0; echo "Modificar un Usuario (por nombre)"

tput setaf 3; tput cup 3 0; echo "Ingrese el nombre del usuario a modificar: "
tput cup 5 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"


while [ true ]
do
	tput cup 3 43; echo "                                                                 "
	tput setaf 7; tput cup 3 43; read nomUsu
	nomUsu2=$(cut -d: -f1 /etc/passwd | grep -w "$nomUsu")

	if [[ $nomUsu == 0 ]]
	then
		break
	elif [ -z $nomUsu ]
	then
		tput cup 7 0; echo "                             "
		tput cup 6 0; echo "                                                                      "
		tput setaf 1; tput cup 6 0; echo "Ingrese un dato valido."
	elif [ -z $nomUsu2 ]
	then
		tput cup 6 0; echo "                                                                      "
		tput setaf 1; tput cup 6 0; echo "No existe un usuario llamado '$nomUsu' en el sistema..."
		tput cup 7 0; echo "Intente nuevamente."
	elif [[ $nomUsu == "admin" ]]
	then
		tput cup 6 0; echo "                                                                      "
		tput setaf 1; tput cup 6 0; echo "El usuario 'admin' no puede ser modificado..."	
		tput cup 7 0; echo "Intente nuevamente."
	else
		tput cup 5 0; echo "                                                            "
		tput cup 6 0; echo "                                                            "
		tput cup 7 0; echo "                              "

		uid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f3)
		ingreso=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f5)
		gid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f4)
		grupo=$(grep -w "$gid:" /etc/group | cut -d: -f1)
		mail=$(grep -w "$nomUsu" /etc/mails | cut -d: -f2)

		tput cup 5 0; tput setaf 6; echo "Nombre de Usuario:"; tput cup 5 19; tput setaf 7; echo "$nomUsu"
		tput cup 6 0; tput setaf 6; echo "UID:"; tput cup 6 5; tput setaf 7; echo "$uid"
		tput cup 7 0; tput setaf 6; echo "Grupo:"; tput cup 7 7; tput setaf 7; echo "$grupo (GID: $gid)"
		tput cup 8 0; tput setaf 6; echo "Mail:"; tput cup 8 6; tput setaf 7; echo "$mail"
		tput cup 9 0; tput setaf 6; echo "Ingreso al sistema: "; tput cup 9 20; tput setaf 7; echo "$ingreso"

		tput setaf 3; tput cup 11 0; echo "Que desea modificar?:"
		tput cup 12 0; echo "Nombre de usuario"; tput setaf 6; tput cup 12 18; echo "(ingrese 'nom')"
		tput cup 13 0; tput setaf 3; echo "Grupo actual"; tput setaf 6; tput cup 13 13; echo "(ingrese 'gr')"
		tput cup 14 0; tput setaf 3; echo "Mail"; tput setaf 6; tput cup 14 5; echo "(ingrese 'mail')"
		tput cup 16 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"

		while [ true ]
		do
			tput cup 11 22; echo "                                                         "
			tput setaf 7; tput cup 11 22; read dato

			if [[ $dato == 0 ]]
			then
				break 2
			elif [[ $dato != "nom" ]] && [[ $dato != "NOM" ]] && [[ $dato != "GR" ]] && [[ $dato != "gr" ]] && [[ $dato != "mail" ]] && [[ $dato != "MAIL" ]]
			then
				tput cup 19 0; tput setaf 1; echo "Opcion incorrecta!"
				echo "Debe ingresar <nom>, <gr>, <mail> o 0."
			else
				tput cup 16 0; echo "                                           "
				tput cup 19 0; echo "                              "
				tput cup 20 0; echo "                                             "

				if [[ $dato == "NOM" ]]
				then
					dato="nom"
				fi

				if [[ $dato == "nom" ]]
				then
					tput setaf 3; tput cup 16 0; echo "Nuevo nombre de usuario:"
					
					while [ true ]
					do
						tput cup 16 25; echo "                                                            "
						tput setaf 7; tput cup 16 25; read nom2
						usu2=$(cut -d: -f1 /etc/passwd | grep -w "$nom2")
						nom2Letras=$(echo "${#nom2}")

						if [[ -z $nom2 ]]
						then
							tput cup 19 0; echo "                                                                     "
							tput setaf 1; tput cup 19 0; echo "Ingrese un dato valido."
						elif [ $nom2Letras -lt 3 ]
						then
							tput cup 19 0; echo "                                                                  "
							tput setaf 1; tput cup 19 0; echo "El nombre de usuario debe contener al menos 3 caracteres..."
						elif [[ $nom2 =~ [0-9] ]]
						then
							tput cup 19 0; echo "                                                                  "
							tput setaf 1; tput cup 19 0; echo "El nombre de usuario no puede contener numeros..."
						elif [[ $nom2 == $nomUsu ]]
						then
							tput cup 19 0; echo "                                                                     "
							tput setaf 1; tput cup 19 0; echo "Ingrese un nombre diferente al original..."
						elif [[ $usu2 != "" ]]
						then
							tput cup 19 0; echo "                                                               "
							tput setaf 1; tput cup 19 0; echo "El usuario '$nom2' ya existe en el sistema..."
						else
							tput cup 19 0; echo "                                                "
		
							nomUsuLetras=$(echo "${#nomUsu}")
							x=$((50 + $nomUsuLetras))
							y=$(($x + 3))
							z=$(($y + $nom2Letras + 2))

							tput setaf 3; tput cup 18 0; echo "Esta seguro que desea modificar este usuario de"; tput cup 18 48; tput setaf 5; echo "'$nomUsu'"
							tput cup 18 $x; tput setaf 3; echo " a"; tput cup 18 $y; tput setaf 5; echo "'$nom2'"; tput cup 18 $z; tput setaf 3; echo "?"
							echo "Pulse M para modificar"
							echo "Pulse S para salir sin modificar"
							tput cup 22 0; tput setaf 7; read opcion

							while [[ $opcion != "S" ]] && [[ $opcion != "M" ]] && [[ $opcion != "m" ]] && [[ $opcion != "s" ]]
							do
								tput cup 22 0; echo "                                     "
								tput setaf 1; tput cup 25 0; echo "Opcion incorrecta!"
								echo "Debe ingresar <M> o <S>."
								tput cup 22 0; tput setaf 7; read opcion
							done

							tput cup 25 0; echo "                                 "
							tput cup 26 0; echo "                               "

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
									sudo usermod -l $nom2 $nomUsu
							
									mv /etc/mails /etc/mails2
									grep -v "$nomUsu" /etc/mails2 > /etc/mails
									rm /etc/mails2

									echo "$nom2:$mail" >> /etc/mails

									tput cup 24 0; tput setaf 2; echo "Nombre de usuario modificado correctamente!"
									echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera; break 2
									;;
								
								"S")
									break 2
									;;
							esac


						fi

					done

				fi

				if [ $dato == "GR" ]
				then
					dato="gr"
				fi

				if [[ $dato == "gr" ]]
				then
					tput setaf 3; tput cup 16 0; echo "Nombre del grupo al que lo desea mover: "
					
					# comenzar while [ true ]

					tput setaf 7; tput cup 16 40; read gr2

				fi
			fi

		done

	fi

done


		

		

		

		

	

	

	if [[ $dato == "gr" ]]
	then
		tput setaf 3; tput cup 16 0; echo "Nombre del grupo al que lo desea mover: "
		tput setaf 7; tput cup 16 40; read gr2

		while [[ $gr2 == $grupo ]]
		do
			tput cup 19 0; echo "                                                          "
			tput setaf 1; tput cup 19 0; echo "El usuario '$nomUsu' ya esta ingresado en ese grupo!"
			tput cup 20 0; echo "Intente ingresando uno diferente."
			tput setaf 7
			tput cup 16 40; echo "                                                              "
			tput cup 16 40; read gr2 

		done

		tput cup 19 0; echo "                                                            "
		tput cup 20 0; echo "                                                               "

		gr3=$(cut -d: -f1 /etc/group | grep -w "$gr2")

		while [ -z $gr3 ]
		do
			tput cup 19 0; echo "                                                          "
				tput setaf 1; tput cup 19 0; echo "No existe un grupo llamado '$gr2' en el sistema..."
			tput cup 20 0; echo "Intente ingresando uno existente o regrese luego de crearlo."
			tput setaf 7
				tput cup 16 40; echo "                                                              "
			tput cup 16 40; read gr2
			gr3=$(cut -d: -f1 /etc/group | grep -w "$gr2")
		done

		tput cup 19 0; echo "                                                            "
		tput cup 20 0; echo "                                                               "

		grupoLetras=$(echo "${#grupo}")
		gr2Letras=$(echo "${#gr2}")
		u=$((54 + $grupoLetras))
		v=$(($u + 9))
		w=$(($v + $gr2Letras + 2))

		tput setaf 3; tput cup 18 0; echo "Esta seguro que desea cambiar al usuario del grupo"; tput cup 18 51; tput setaf 5; echo "'$grupo'"
		tput setaf 3; tput cup 18 $u; echo "al grupo"; tput setaf 5; tput cup 18 $v; echo "'$gr2'"; tput setaf 3; tput cup 18 $w; echo "?"
		echo "Pulse A para aceptar"
		echo "Pulse S para salir sin aceptar"
		tput cup 22 0; tput setaf 7; read opcion2

		if [[ $opcion2 == "a" ]]
		then
			opcion2="A"
		fi

		if [[ $opcion2 == "s" ]]
		then
			opcion2="S"
		fi

		case $opcion2 in

			"A") 
				gid2=$(cut -d: -f3 /etc/group | grep -w "$gr2")
				sudo usermod -g $gr2 $nomUsu
		
				if [[ $grupo == "admin" ]]
				then
					mv /etc/sudoers /etc/sudoers2
					grep -v "$nomUsu ALL" /etc/sudoers2 > /etc/sudoers
					rm /etc/sudoers2
				fi

				if [[ $gr2 == "admin" ]]
				then
					echo "$nomUsu ALL=(ALL:ALL) ALL" >> /etc/sudoers
				fi
				
				tput cup 24 0; tput setaf 2; echo "Grupo del usuario '$nomUsu' modificado correctamente!"
				echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera2
				;;
			
			"S")

				;;
		esac

	fi

	if [ $dato == "MAIL" ]
	then
		dato="mail"
	fi

	if [[ $dato == "mail" ]]
	then

		tput setaf 3; tput cup 16 0; echo "Nuevo mail:"
		tput setaf 7; tput cup 16 12; read mail2

		while [[ $mail2 == $mail ]]
		do
			tput cup 16 12; echo "                                        "
			tput setaf 1; tput cup 19 0; echo "Ingrese un mail diferente al original..."
			tput cup 16 12; tput setaf 7; read mail2
		done

		tput cup 19 0; echo "                                                "

		mail3=$(grep -w ":$mail2" /etc/mails)

		while [ $mail3 ]
		do
			tput setaf 1; tput cup 19 0; echo "Ese correo ya esta registrado en el sistema..."
			tput cup 20 0; echo "Ingrese uno diferente."
			tput setaf 7; tput cup 16 12; echo "                                        "
			tput cup 16 12; read mail2
			mail3=$(grep -w ":$mail2" /etc/mails)
		done

		tput cup 19 0; echo "                                                "
		tput cup 20 0; echo "                                                "

		mailLetras=$(echo "${#mail}")
		mail2Letras=$(echo "${#mail2}")
		u=$((44 + $mailLetras))
		v=$(($u + 2))
		w=$(($v + $mail2Letras + 2))

		tput setaf 3; tput cup 18 0; echo "Esta seguro que desea cambiar el mail de"; tput cup 18 41; tput setaf 5; echo "'$mail'"
		tput setaf 3; tput cup 18 $u; echo "a"; tput setaf 5; tput cup 18 $v; echo "'$mail2'"; tput setaf 3; tput cup 18 $w; echo "?"
		echo "Pulse A para aceptar"
		echo "Pulse S para salir sin aceptar"
		tput cup 22 0; tput setaf 7; read opcion2

		if [[ $opcion2 == "a" ]]
		then
			opcion2="A"
		fi

		if [[ $opcion2 == "s" ]]
		then
			opcion2="S"
		fi

		case $opcion2 in

			"A") 

				mv /etc/mails /etc/mails2
				grep -v "$nomUsu" /etc/mails2 > /etc/mails
				rm /etc/mails2

				echo "$nomUsu:$mail2" >> /etc/mails
							
				tput cup 24 0; tput setaf 2; echo "Mail del usuario '$nomUsu' modificado correctamente!"
				echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera2
				;;
			
			"S")

				;;
		esac

	fi

fi