#!/bin/bash
while [[ $opcion != 0 ]]
do
	clear
	tput setaf 5; tput cup 1 0; echo "Gestion de Usuarios y Grupos"
	tput setaf 7
	echo ""
	echo "1. Gestionar Usuarios"
	echo "2. Gestionar Grupos"
	tput setaf 3; echo "0. Volver"
	tput setaf 7; echo " "
	read opcion
	case $opcion in
		1) sh UG/usuarios/gestionUsuarios.sh ;;
		2) sh UG/grupos/gestionGrupos.sh ;;
		0) exit ;;
	esac
done
