#!/bin/bash
while [[ $op != 0 ]]
do
	clear
	echo ""
	tput setaf 5; echo "Gestionar Grupos"
	tput setaf 7
	echo ""
	echo "1. Agregar Grupo"
	echo "2. Eliminar Grupo"
	echo "3. Modificar Grupo"
	echo "4. Buscar Grupo"
	echo "5. Listar Grupos"
	echo "6. Listar Usuarios de un Grupo"
	tput setaf 3; echo "0. Volver"
	tput setaf 7; echo " "
	read op
	case $op in
		1) sh UG/grupos/agregarGrupo.sh ;;
		2) sh UG/grupos/eliminar/eliminarGrupo.sh ;;
		3) sh UG/grupos/modificar/modificarGrupo.sh ;;
		4) sh UG/grupos/buscar/buscarGrupo.sh ;;
		5) sh UG/grupos/listar/listarGrupos.sh ;;
		6) sh UG/grupos/listar/listarUsusGr.sh ;;
		0) ;;
		*) echo "Esa opcion no existe..."
	esac
done