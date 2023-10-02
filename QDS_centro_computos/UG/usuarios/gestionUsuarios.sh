#!/bin/bash
while [[ $op != 0 ]]
do
	clear
	echo ""
	tput setaf 5; echo "Gestionar Usuarios"
	tput setaf 7
	echo ""
	echo "1. Agregar Usuario"
	echo "2. Eliminar Usuario"
	echo "3. Modificar Usuario"
	echo "4. Buscar Usuario"
	echo "5. Listar Usuarios"
	tput setaf 3; echo "0. Volver"
	tput setaf 7; echo " "
	read op
	case $op in
		1) sh UG/usuarios/agregarUsuario.sh ;;
		2) sh UG/usuarios/eliminar/eliminarUsuario.sh ;;
		3) sh UG/usuarios/modificar/modificarUsuario.sh ;;
		4) sh UG/usuarios/buscar/buscarUsuario.sh ;;
		5) sh UG/usuarios/listarUsuarios.sh ;;
		0) ;;
	esac
done
