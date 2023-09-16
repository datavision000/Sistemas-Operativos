while [[ $opc != 0 ]]
do
	clear
	echo ""
	tput setaf 5; echo "Listar Usuarios de un Grupo"
	tput setaf 7
	echo ""
	echo "1. Buscar grupo por Nombre"
	echo "2. Buscar grupo por GID"
	tput setaf 3; echo "0. Volver"
	tput setaf 7; echo " "
	read opc
	case $opc in
		1) sh UG/grupos/listar/listarUsusGrNom.sh ;;
		2) sh UG/grupos/listar/listarUsusGrGID.sh ;;
		0) ;;
	esac
done