while [[ $opci != 0 ]]
do
	clear
	echo ""
	tput setaf 5; echo "Eliminar un grupo"
	tput setaf 7
	echo ""
	echo "1. Eliminar por nombre"
	echo "2. Eliminar por GID"
	tput setaf 3; echo "0. Volver"
	tput setaf 7; echo " "
	read opci
	case $opci in
		1) sh UG/grupos/eliminar/eliminarGrupoNom.sh ;;
		2) sh UG/grupos/eliminar/eliminarGrupoGID.sh ;;
		0) ;;
	esac
done
