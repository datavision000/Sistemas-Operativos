#!/bin/bash
clear

formato="^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$"

tput setaf 5; tput cup 1 0; echo "Cambiar Mi Contrasena"
tput setaf 3; tput cup 3 0; echo "Ingrese la nueva contrasena: "
tput setaf 3; tput cup 4 0; echo "Ingrese nuevamente la nueva contrasena: "
tput setaf 2; tput cup 6 0; echo "(Ingrese 0 para regresar...)"

while [ true ]
do
	tput cup 3 29; echo "                                                            "
	tput cup 4 40; echo "                                                            "
	tput setaf 7
	tput cup 3 29; read contrasenaNueva1
	tput cup 4 40; read contrasenaNueva2

	if [[ $contrasenaNueva1 == 0 ]] || [[ $contrasenaNueva2 == 0 ]]
	then
		break
	elif [[ $contrasenaNueva1 != $contrasenaNueva2 ]]
	then
		tput cup 7 0; echo "                                                                                "
		tput cup 8 0; echo "                                                                                            "
		tput cup 7 0; tput setaf 1; echo "Las contrasenas no coinciden..."
		tput cup 8 0; echo "Pruebe nuevamente."
	elif [ -z $contrasenaNueva1 ] || [ -z $contrasenaNueva2 ]
	then
		tput cup 7 0; echo "                                                                                "
		tput cup 8 0; echo "                                                                                            "
		tput setaf 1; tput cup 7 0; echo "Ingrese datos validos."
	elif [[ $contrasenaNueva2 =~ $formato ]]
	then
		tput cup 7 0; echo "                                                                                "
		tput cup 8 0; echo "                                                                      "
		tput cup 9 0; echo "                                                                 "
		tput setaf 1
		tput cup 7 0; echo "Formato no valido..."
		tput cup 8 0; echo "Debe contener: al menos una mayuscula, una minuscula, un numero y 8 caracteres"
	else

		tput setaf 3; tput cup 8 0
		echo "Esta seguro que desea modificar su contrasena?"
		echo "Pulse A para aceptar"
		echo "Pulse S para salir sin aceptar"
		tput setaf 7; tput cup 12 0; read opcion

		while [[ $opcion != "A" ]] && [[ $opcion != "S" ]] && [[ $opcion != "s" ]] && [[ $opcion != "a" ]]
		do
			tput cup 12 0; echo "                                          "
			tput setaf 1; tput cup 14 0; echo "Opcion incorrecta!"
			echo "Debe ingresar <A> o <S>."
			tput cup 12 0; tput setaf 7; read opcion
		done

		tput cup 14 0; echo "                                 "
		tput cup 15 0; echo "                               "
		
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
			
				echo "$contrasenaNueva1" | passwd --stdin $(whoami)
				tput cup 14 0; tput setaf 2; echo "Tu contrasena fue modificada correctamente!"
				echo "Presione cualquier tecla para volver..."; read espera; break ;;		
			"S")
				break
				;;

		esac
		
	fi

done