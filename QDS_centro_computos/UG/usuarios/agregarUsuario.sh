#!/bin/bash

clear
fechaActual=$(date +%d/%m/%Y)
horaActual=$(date +%H.%M)
comentario=$(echo "$fechaActual-$horaActual")

echo ""
tput setaf 5; echo "Ingresar un Usuario"

tput setaf 3
tput cup 3 0; echo "Nombre de usuario: "
tput cup 4 0; echo "Nombre del grupo: "
tput cup 5 0; echo "Mail: "
tput cup 7 0; tput setaf 2; echo "(Ingrese 0 en cualquier campo para regresar...)"
tput setaf 7

while [ true ]
do
	tput cup 3 19; echo "                                                   "
	tput setaf 7; tput cup 3 19; read usu

	usuLetras=$(echo "${#usu}")
	usu2=$(cut -d: -f1 /etc/passwd | grep -w "$usu")

	if [[ $usu == 0 ]]
	then
		break
	elif [ -z $usu ]
	then
		tput cup 8 0; echo "                                                                      "
		tput setaf 1; tput cup 8 0; echo "Ingrese un dato valido."
	elif [ $usuLetras -lt 3 ]
	then
		tput cup 8 0; echo "                                                                  "
		tput setaf 1; tput cup 8 0; echo "El nombre de usuario debe contener al menos 3 caracteres..."
		usuLetras=$(echo "${#usu}")
	elif [[ $usu =~ [0-9] ]]
	then
		tput cup 8 0; echo "                                                                  "
		tput setaf 1; tput cup 8 0; echo "El nombre de usuario no puede contener numeros..."
	elif [[ $usu2 != "" ]]
	then
		tput cup 8 0; echo "                                                               "
       	tput setaf 1; tput cup 8 0; echo "El usuario '$usu' ya existe en el sistema..."
		tput setaf 7
	else

		tput cup 8 0; echo "                                                                  "
		tput cup 9 0; echo "                                                                  "

		while [ true ]
		do
			tput cup 4 18; echo "                                                   "
			tput setaf 7; tput cup 4 18; read grupo
			grupo2=$(cut -d: -f1 /etc/group | grep -w "$grupo")

			if [[ $grupo == 0 ]]
			then
				break 2
			elif [ -z $grupo2 ]
			then
				tput cup 8 0; echo "                                                             "
				tput setaf 1; tput cup 8 0; echo "El grupo '$grupo' no existe en el sistema..."
				tput cup 9 0; echo "Intente ingresando uno existente o regrese luego de crearlo."
			else
		
				tput cup 8 0; echo "                                                                  "
				tput cup 9 0; echo "                                                                  "

				while [ true ]
				do
					tput cup 5 6; echo "                                       "
					tput cup 5 6; tput setaf 7; read mail
					mail2=$(grep -w "$mail" /etc/mails | cut -d: -f2)

					if [[ $mail == 0 ]]
					then
						break 3
					elif [ $mail2 ]
					then
						tput setaf 1; tput cup 8 0; echo "Ese correo ya esta registrado en el sistema..."
						tput cup 9 0; echo "Ingrese uno diferente."
					else
						if [[ $grupo == "admin" ]]
						then
							echo "$usu ALL=(ALL:ALL) ALL" >> /etc/sudoers
						fi

						useradd -g $grupo -c $comentario $usu
						contrasenia=$(tr -dc 'A-Z0-9' < /dev/urandom | head -c 8; echo)
						mysql -h "192.168.5.50" -u "amadeus.gonzalez" -p"55055884" "datavision" -e "INSERT INTO login (nom_usu, mail, tipo_usu, contrasenia) VALUES ('$usu', '$mail', '$grupo', '$contrasenia')"
						echo "$usu:$contrasenia" | chpasswd
						echo "$usu:$mail" >> /etc/mails
						tput cup 7 0; echo "                                                        "
						if [[ $grupo == "admin" ]]
						then
							tput setaf 1
							tput cup 8 0; echo "*************************************************************************************************"
							echo "IMPORTANTE! Asegurese de brindar el siguiente codigo al usuario creado: $contrasenia"
							echo "Este, debera usar el codigo para loguearse por primera vez y luego poder modificar su contrasena."
							echo "*************************************************************************************************"
							tput setaf 2; tput cup 13 0
							echo "El usuario '$usu' (grupo: '$grupo') fue ingresado correctamente al sistema!"
							echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera; break 3
						else
							tput setaf 2; tput cup 8 0
							echo "El usuario '$usu' (grupo: '$grupo') fue ingresado correctamente al sistema!"
							echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera; break 3
						fi
						
					fi

				done

			fi

		done

	fi

done