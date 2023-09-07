while [[ $opc != 0 ]]
do
	clear
	echo ""
	tput setaf 5; echo "Modificar un grupo"
	tput setaf 7
	echo ""
	echo "1. Modificar buscando por nombre"
	echo "2. Modificar buscando por GID"
	tput setaf 3; echo "0. Volver"
	tput setaf 7; echo " "
	read opc
	case $opc in
		1) sh UG/grupos/modificar/modificarGrupoNom.sh ;;
		2) sh UG/grupos/modificar/modificarGrupoGID.sh ;;
		0) ;;
	esac
done