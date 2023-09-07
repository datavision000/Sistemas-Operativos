#!/bin/bash

clear

echo ""
tput setaf 5; echo "Ingresar Grupo"

tput setaf 3
tput cup 3 0; echo "Nombre de grupo: "
tput setaf 7; tput cup 3 17; read grupo

grupo2=$(cut -d: -f1 /etc/group | grep -w "$grupo")

while [[ $grupo =~ ^[0-9]+$ ]]
do
	tput setaf 1; tput cup 6 0; echo "El nombre del grupo no puede contener numeros..."
	tput setaf 7
	tput cup 3 17; echo "                                            "
	tput cup 3 17; read grupo
done

while [[ $grupo2 != "" ]]
do
        tput setaf 1; tput cup 6 0; echo "El grupo '$grupo' ya existe en el sistema..."
	tput setaf 7
        tput cup 3 17; echo "                                         "
	tput cup 3 17; read grupo
	grupo2=$(cut -d: -f1 /etc/group | grep -w "$grupo")
done

tput cup 6 0; echo "                                                                      "

sudo groupadd $grupo

tput cup 6 0; tput setaf 2
echo "El grupo '$grupo' fue ingresado correctamente al sistema!"
echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera