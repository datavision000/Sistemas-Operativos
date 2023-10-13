#!/bin/bash
clear

echo ""
tput setaf 5; echo "Ingresar un Grupo"

tput setaf 3
tput cup 3 0; echo "Nombre de grupo: "
tput cup 5 0; tput setaf 2; echo "(Ingrese 0 para regresar...)"

while [ true ]
do
	tput cup 3 17; echo "                                                            "
	tput setaf 7; tput cup 3 17; read grupo
	grupo2=$(cut -d: -f1 /etc/group | grep -w "$grupo")
	grupoLetras=$(echo "${#grupo}")

	if [ $grupo == 0 &> /dev/null ]
	then
		break
	elif [[ $grupo2 != "" ]]
	then
		tput cup 6 0; echo "                                                            "
		tput setaf 1; tput cup 6 0; echo "El grupo '$grupo' ya existe en el sistema..."
	elif [ -z $grupo ]
	then
		tput cup 6 0; echo "                                                                      "
		tput setaf 1; tput cup 6 0; echo "Ingrese un dato valido."
	elif [ $grupoLetras -lt 3 ]
	then
		tput cup 6 0; echo "                                                                            "
		tput setaf 1; tput cup 6 0; echo "El nombre del grupo debe contener al menos 3 caracteres..."
	elif [[ $grupo =~ [0-9] ]] || [[ $grupo =~ : ]]
	then
		tput cup 6 0; echo "                                                                            "
		tput setaf 1; tput cup 6 0; echo "El nombre del grupo no puede contener numeros o dos puntos..."
	else
		tput cup 5 0; echo "                                                                  "
		tput cup 6 0; echo "                                                                  "

		sudo groupadd $grupo

		tput cup 6 0; tput setaf 2
		echo "El grupo '$grupo' fue ingresado correctamente al sistema!"
		echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera; break
	fi
done