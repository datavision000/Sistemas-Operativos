while [[ $opc != 0 ]]
do
	clear
	echo ""
	tput setaf 5; echo "Buscar un Grupo"
	tput setaf 7
	echo ""
	echo "1. Buscar por nombre"
	echo "2. Buscar por GID"
	tput setaf 3; echo "0. Volver"
	tput setaf 7; echo " "
	read opc
	case $opc in
		1) sh UG/grupos/buscar/buscarGrupoNom.sh ;;
		2) sh UG/grupos/buscar/buscarGrupoGID.sh ;;
		0) ;;
	esac
done