#!/bin/bash

while [[ $opci != 0 ]]
do
	clear
	tput cup 1 0
	tput setaf 5; echo "Modificar un Usuario"
	tput setaf 7; tput cup 3 0
	echo "1. Modficar Buscando por Nombre"
	echo "2. Modificar Buscando por UID"
	tput setaf 3; echo "0. Volver"
	tput setaf 7; tput cup 7 0; read opci
	case $opci in
		1) sh UG/usuarios/modificar/modificarUsuarioNom.sh ;;
		2) sh UG/usuarios/modificar/modificarUsuarioUID.sh ;;
		0) ;;
	esac
done