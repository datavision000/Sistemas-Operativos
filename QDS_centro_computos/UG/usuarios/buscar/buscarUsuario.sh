#!/bin/bash

while [[ $opc != 0 ]]
do
	clear
	echo ""
	tput setaf 5; echo "Buscar un Usuario"
	tput setaf 7
	echo ""
	echo "1. Buscar por Nombre"
	echo "2. Buscar por UID"
	tput setaf 3; echo "0. Volver"
	tput setaf 7; echo " "
	read opc
	case $opc in
		1) sh UG/usuarios/buscar/buscarUsuarioNom.sh ;;
		2) sh UG/usuarios/buscar/buscarUsuarioUID.sh ;;
		0) ;;
	esac
done
