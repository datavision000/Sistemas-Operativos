#!/bin/bash
clear

con=$(grep -w "conexion" /home/admin/config/configBDD | cut -d: -f2)
usuCon=$(grep -w "usuCon" /home/admin/config/configBDD | cut -d: -f2)
bddCon=$(grep -w "bddCon" /home/admin/config/configBDD | cut -d: -f2)
passwdCon=$(grep -w "passwdCon" /home/admin/config/configBDD | cut -d: -f2)

tput setaf 5; tput cup 1 0; echo "Configurar Conexion a Base de Datos"
tput setaf 3; tput cup 3 0; echo "Actual conexion: "
tput setaf 6; tput cup 4 0; echo "IP conexion a base de datos:"; tput setaf 7; tput cup 4 29; echo "$con"
tput setaf 6; tput cup 5 0; echo "Nombre Base de Datos:"; tput setaf 7; tput cup 5 22; echo "$bddCon"
tput setaf 6; tput cup 6 0; echo "Usuario de conexion:"; tput setaf 7; tput cup 6 21; echo "$usuCon"
tput setaf 6; tput cup 7 0; echo "Contrasena:"; tput setaf 7; tput cup 7 12; echo "$passwdCon"

tput setaf 3; tput cup 9 0
echo "Desea modificar alguno de estos datos?"
echo "Pulse 1 para aceptar"
echo "Pulse 0 para salir sin aceptar"
tput setaf 7; tput cup 13 0; read opcion

while [[ $opcion != "0" ]] && [[ $opcion != "1" ]]
do
	tput cup 13 0; echo "                                                "
	tput setaf 1; tput cup 15 0; echo "Opcion incorrecta!"
	echo "Debe ingresar <1> o <0>."
	tput cup 13 0; tput setaf 7; read opcion
done

tput cup 15 0; echo "                                 "
tput cup 16 0; echo "                               "
	
case $opcion in

	1)
		tput setaf 3; tput cup 15 0; echo "Que desea modificar?:"
		tput cup 16 0; echo "IP conexion"; tput setaf 6; tput cup 16 12; echo "(ingrese 'IP')"
		tput cup 17 0; tput setaf 3; echo "Nombre Base de Datos"; tput setaf 6; tput cup 17 21; echo "(ingrese 'N')"
		tput cup 18 0; tput setaf 3; echo "Usuario de conexion"; tput setaf 6; tput cup 18 20; echo "(ingrese 'U')"
		tput cup 19 0; tput setaf 3; echo "Contrasena"; tput setaf 6; tput cup 19 11; echo "(ingrese 'C')"
		tput cup 21 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"

		while [ true ]
		do
			tput cup 15 22; echo "                                                         "
			tput setaf 7; tput cup 15 22; read dato

			if [[ $dato == 0 ]]
			then
				break 2
			elif [[ $dato != "IP" ]] && [[ $dato != "ip" ]] && [[ $dato != "N" ]] && [[ $dato != "n" ]] && [[ $dato != "U" ]] && [[ $dato != "u" ]] && [[ $dato != "C" ]] && [[ $dato != "c" ]]
			then
				tput cup 23 0; tput setaf 1; echo "Opcion incorrecta!"
				echo "Debe ingresar <IP>, <N>, <U>, <C> o 0."
			else
				tput cup 15 22; echo "                                           "
				tput cup 23 0; echo "                              "
				tput cup 24 0; echo "                                               "

				tput cup 25 0; tput setaf 1; echo "IMPORTANTE! Asegurese de ingresar correctamente el dato."

				if [[ $dato == "ip" ]]
				then
					dato="IP"
				fi

				if [[ $dato == "IP" ]]
				then
					tput setaf 3; tput cup 23 0; echo "Nueva IP de conexion: "
					tput cup 23 22; tput setaf 7; read ip2

					mv /home/admin/config/configBDD /home/admin/config/configBDD2
					grep -v "conexion:$con" /home/admin/config/configBDD2 > /home/admin/config/configBDD
					rm /home/admin/config/configBDD2

					echo "conexion:$ip2" >> /home/admin/config/configBDD
			
					sed -i "s/\$host = \".*\";/\$host = \"$ip2\";/" /home/admin/QDS/modelos/config.php
					
				fi

				if [[ $dato == "n" ]]
				then
					dato="N"
				fi

				if [[ $dato == "N" ]]
				then
					tput setaf 3; tput cup 23 0; echo "Nuevo nombre Base de Datos: "
					tput cup 23 28; tput setaf 7; read nomBDD2

					mv /home/admin/config/configBDD /home/admin/config/configBDD2
					grep -v "bddCon:$bddCon" /home/admin/config/configBDD2 > /home/admin/config/configBDD
					rm /home/admin/config/configBDD2

					echo "bddCon:$nomBDD2" >> /home/admin/config/configBDD

					sed -i "s/\$db = \".*\";/\$db = \"$nomBDD2\";/" /home/admin/QDS/modelos/config.php

				fi

				if [[ $dato == "u" ]]
				then
					dato="U"
				fi

				if [[ $dato == "U" ]]
				then
					tput setaf 3; tput cup 23 0; echo "Nuevo usuario de conexion: "
					tput cup 23 27; tput setaf 7; read nomUSU2

					mv /home/admin/config/configBDD /home/admin/config/configBDD2
					grep -v "usuCon:$usuCon" /home/admin/config/configBDD2 > /home/admin/config/configBDD
					rm /home/admin/config/configBDD2

					echo "usuCon:$nomUSU2" >> /home/admin/config/configBDD

					sed -i "s/\$user = \".*\";/\$user = \"$nomUSU2\";/" /home/admin/QDS/modelos/config.php
	
				fi

				if [[ $dato == "c" ]]
				then
					dato="C"
				fi

				if [[ $dato == "C" ]]
				then
					tput setaf 3; tput cup 23 0; echo "Nueva contrasena: "
					tput cup 23 18; tput setaf 7; read passwdCon2

					mv /home/admin/config/configBDD /home/admin/config/configBDD2
					grep -v "passwdCon:$passwdCon" /home/admin/config/configBDD2 > /home/admin/config/configBDD
					rm /home/admin/config/configBDD2

					echo "passwdCon:$passwdCon2" >> /home/admin/config/configBDD
	
					sed -i "s/\$pass = \".*\";/\$pass = \"$passwdCon2\";/" /home/admin/QDS/modelos/config.php					

				fi

				tput cup 25 0; echo "                                                                              "
				tput setaf 2
				echo "El dato fue modificado correctamente!"
				echo "Toque cualquier tecla para volver..."; tput setaf 7; read espera; break 2

			fi
		done

		;;
		
	0)
		break
		;;

esac