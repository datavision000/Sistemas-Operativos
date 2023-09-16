#!/bin/bash

while [[ $opci != 0 ]]
do
	clear
	echo ""
	tput setaf 5; echo "Eliminar un Usuario"
	tput setaf 7
	echo ""
	echo "1. Eliminar por Nombre"
	echo "2. Eliminar por UID"
	tput setaf 3; echo "0. Volver"
	tput setaf 7; echo " "
	read opci
	case $opci in
		1) sh UG/usuarios/eliminar/eliminarUsuarioNom.sh ;;
		2) sh UG/usuarios/eliminar/eliminarUsuarioUID.sh ;;
		0) ;;
	esac
done
