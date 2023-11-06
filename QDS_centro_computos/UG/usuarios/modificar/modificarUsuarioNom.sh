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

									id_usuario=$(mysql -h "192.168.5.50" -u "amadeus.gonzalez" -p"55055884" "datavision" -e "SELECT id_usuario FROM login WHERE nom_usu='$nomUsu'" | tail -1)
									mysql -h "192.168.5.50" -u "amadeus.gonzalez" -p"55055884" "datavision" -e "UPDATE login SET nom_usu='$nom2' WHERE id_usuario='$id_usuario'"

									tput cup 24 0; tput setaf 2; echo "Nombre de usuario modificado correctamente!"
									echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera; break 3
									;;
													
								"S")
									break 3
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
					
					while [ true ]
					do
						tput cup 16 40; echo "                                                                         " 
						tput setaf 7; tput cup 16 40; read gr2
						gr3=$(cut -d: -f1 /etc/group | grep -w "$gr2")
						gr2Letras=$(echo "${#gr2}")

						if [ -z $gr2 ]
						then
							tput cup 19 0; echo "                                                                     "
							tput cup 20 0; echo "                                                                      "
							tput setaf 1; tput cup 19 0; echo "Ingrese un dato valido."
						elif [[ $gr2 == $grupo ]]
						then
							tput cup 19 0; echo "                                                                     "
							tput cup 20 0; echo "                                                                      "
							tput setaf 1; tput cup 19 0; echo "El usuario '$nomUsu' ya esta ingresado en ese grupo!"
							tput cup 20 0; echo "Intente ingresando uno diferente."
						elif [ -z $gr3 ]
						then
							tput cup 19 0; echo "                                                                     "
							tput cup 20 0; echo "                                                                      "
							tput setaf 1; tput cup 19 0; echo "No existe un grupo llamado '$gr2' en el sistema..."
							tput cup 20 0; echo "Intente ingresando uno existente o regrese luego de crearlo."
						elif [ $gr2Letras -lt 3 ]
						then
							tput cup 19 0; echo "                                                                            "
							tput cup 20 0; echo "                                                                      "
							tput setaf 1; tput cup 19 0; echo "El nombre del grupo debe contener al menos 3 caracteres..."
						elif [[ $gr2 =~ [0-9] ]] || [[ $gr2 =~ : ]]
						then
							tput cup 19 0; echo "                                                                            "
							tput cup 20 0; echo "                                                                      "
							tput setaf 1; tput cup 19 0; echo "El nombre del grupo no puede contener numeros o dos puntos..."
						else
							tput cup 19 0; echo "                                                                     "
							tput cup 20 0; echo "                                                                      "
							
							grupoLetras=$(echo "${#grupo}")
							gr2Letras=$(echo "${#gr2}")
							u=$((54 + $grupoLetras))
							v=$(($u + 9))
							w=$(($v + $gr2Letras + 2))

							tput setaf 3; tput cup 18 0; echo "Esta seguro que desea cambiar al usuario del grupo"; tput cup 18 51; tput setaf 5; echo "'$grupo'"
							tput setaf 3; tput cup 18 $u; echo "al grupo"; tput setaf 5; tput cup 18 $v; echo "'$gr2'"; tput setaf 3; tput cup 18 $w; echo "?"
							echo "Pulse M para modificar"
							echo "Pulse S para salir sin aceptar"
							tput cup 22 0; tput setaf 7; read opcion2

							while [[ $opcion2 != "S" ]] && [[ $opcion2 != "M" ]] && [[ $opcion2 != "m" ]] && [[ $opcion2 != "s" ]]
							do
								tput cup 22 0; echo "                                     "
								tput setaf 1; tput cup 25 0; echo "Opcion incorrecta!"
								echo "Debe ingresar <M> o <S>."
								tput cup 22 0; tput setaf 7; read opcion2
							done

							tput cup 25 0; echo "                                 "
							tput cup 26 0; echo "                               "

							if [[ $opcion2 == "m" ]]
							then
								opcion2="M"
							fi

							if [[ $opcion2 == "s" ]]
							then
								opcion2="S"
							fi

							case $opcion2 in

								"M") 
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

									id_usuario=$(mysql -h "192.168.5.50" -u "amadeus.gonzalez" -p"55055884" "datavision" -e "SELECT id_usuario FROM login WHERE nom_usu='$nomUsu'" | tail -1)
									mysql -h "192.168.5.50" -u "amadeus.gonzalez" -p"55055884" "datavision" -e "UPDATE login SET tipo_usu='$gr2' WHERE id_usuario='$id_usuario'"

									tput cup 24 0; tput setaf 2; echo "Grupo del usuario '$nomUsu' modificado correctamente!"
									echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera2; break 3
									;;
								
								"S")
									break 3
									;;
							esac

						fi
						
					done	

				fi

				if [ $dato == "MAIL" ]
				then
					dato="mail"
				fi

				if [[ $dato == "mail" ]]
				then
					tput setaf 3; tput cup 16 0; echo "Nuevo mail:"

					while [ true ]
					do
						tput cup 16 12; echo "                                                                 "
						tput setaf 7; tput cup 16 12; read mail2
						mail3=$(cut -d: -f2 /etc/mails | grep -w "$mail2")

						if [ -z $mail2 ]
						then
							tput cup 19 0; echo "                                                                     "
							tput cup 20 0; echo "                                                                      "
							tput setaf 1; tput cup 19 0; echo "Ingrese un dato valido."
						elif [[ $mail2 == $mail ]]
						then
							tput cup 19 0; echo "                                                                     "
							tput cup 20 0; echo "                                                                      "
							tput setaf 1; tput cup 19 0; echo "Ingrese un mail diferente al original..."
						elif [[ $mail3 != "" ]]
						then
							tput cup 19 0; echo "                                                                     "
							tput cup 20 0; echo "                                                                      "
							tput setaf 1; tput cup 19 0; echo "Ese correo ya esta registrado en el sistema..."
							tput cup 20 0; echo "Ingrese uno diferente."
						else
							tput cup 19 0; echo "                                                "
							tput cup 20 0; echo "                                                "

							mailLetras=$(echo "${#mail}")
							mail2Letras=$(echo "${#mail2}")
							u=$((44 + $mailLetras))
							v=$(($u + 2))
							w=$(($v + $mail2Letras + 2))

							tput setaf 3; tput cup 18 0; echo "Esta seguro que desea cambiar el mail de"; tput cup 18 41; tput setaf 5; echo "'$mail'"
							tput setaf 3; tput cup 18 $u; echo "a"; tput setaf 5; tput cup 18 $v; echo "'$mail2'"; tput setaf 3; tput cup 18 $w; echo "?"
							echo "Pulse M para modificar"
							echo "Pulse S para salir sin aceptar"
							tput cup 22 0; tput setaf 7; read opcion2

							while [[ $opcion2 != "S" ]] && [[ $opcion2 != "M" ]] && [[ $opcion2 != "m" ]] && [[ $opcion2 != "s" ]]
							do
								tput cup 22 0; echo "                                     "
								tput setaf 1; tput cup 25 0; echo "Opcion incorrecta!"
								echo "Debe ingresar <M> o <S>."
								tput cup 22 0; tput setaf 7; read opcion2
							done

							tput cup 25 0; echo "                                 "
							tput cup 26 0; echo "                               "

							if [[ $opcion2 == "m" ]]
							then
								opcion2="M"
							fi

							if [[ $opcion2 == "s" ]]
							then
								opcion2="S"
							fi

							case $opcion2 in

								"M") 

									mv /etc/mails /etc/mails2
									grep -v "$nomUsu" /etc/mails2 > /etc/mails
									rm /etc/mails2

									echo "$nomUsu:$mail2" >> /etc/mails
				
									id_usuario=$(mysql -h "192.168.5.50" -u "amadeus.gonzalez" -p"55055884" "datavision" -e "SELECT id_usuario FROM login WHERE nom_usu='$nomUsu'" | tail -1)
									mysql -h "192.168.5.50" -u "amadeus.gonzalez" -p"55055884" "datavision" -e "UPDATE login SET mail='$mail2' WHERE id_usuario='$id_usuario'"
												
									tput cup 24 0; tput setaf 2; echo "Mail del usuario '$nomUsu' modificado correctamente!"
									echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera2; break 3
									;;
								
								"S")
									break 3
									;;
							esac

						fi

					done

				fi

			fi

		done

	fi

done