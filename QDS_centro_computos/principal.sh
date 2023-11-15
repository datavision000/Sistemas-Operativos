#!/bin/bash
while [[ $opcion != 0 ]]
do
	clear
	tput setaf 3
	tput cup 1 0; echo "************************************************"
	tput cup 2 0; echo "*                                              *"
	tput cup 3 0; echo "*           QDS - Centro de Computos           *"
	tput cup 4 0; echo "*                                              *"
	tput cup 5 0; echo "************************************************"
	tput setaf 7
	echo ""
	echo "1. Gestionar Usuarios y Grupos"
	echo "2. Actualizar Servicios"
	echo "3. Backup - Base de Datos"
	echo "4. Backup - Config. del Sistema"
	echo "5. Gestionar Logins"
	echo "6. Mostrar Conexion a QDS"
	echo "7. Configurar Conexion a Base de Datos"
	echo "8. Cambiar mi Contrasena"
	tput setaf 1; echo "0. Salir"
	tput setaf 7; echo " "
	read opcion
	case $opcion in
		1) sh UG/usuariosGrupos.sh ;;
		2) sh actualizar/actualizarServPack.sh ;;
		3) sh backups/bdd/menuBackupBDD.sh ;;
		4) sh backups/sistema/menuBackupSys.sh ;;
		5) sh logins/menuLogins.sh ;;
		6) sh mostrarIP.sh ;;
		7) sh configurarBDD.sh ;;
		8) sh cambiarContrasena.sh ;;
		0) sh exitQDS.sh ;; 
	esac
done

