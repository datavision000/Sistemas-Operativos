#!/bin/bash
clear

tput setaf 5; tput cup 1 0; echo "Eliminar un Usuario (por nombre)"

tput setaf 3; tput cup 3 0; echo "Ingrese el nombre del usuario a eliminar: "
tput setaf 7; tput cup 3 42; read nomUsu

nomUsu2=$(cut -d: -f1 /etc/passwd | grep -w "$nomUsu")

while [ -z $nomUsu2 ]
do
	tput cup 6 0; echo "                                                            "
        tput setaf 1; tput cup 6 0; echo "No existe un usuario llamado '$nomUsu' en el sistema..."
	tput cup 7 0; echo "Intente nuevamente."
	tput setaf 7
        tput cup 3 42; echo "                                                              "
	tput cup 3 42; read nomUsu
	nomUsu2=$(cut -d: -f1 /etc/passwd | grep -w "$nomUsu")
done

tput cup 6 0; echo "                                                   "
tput cup 7 0; echo "                              "

uid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f3)

while [[ $uid == 1000 ]]
do
	tput cup 6 0; echo "                                                            "
        tput setaf 1; tput cup 6 0; echo "No es posible eliminar a este usuario..."
	tput setaf 7
        tput cup 3 42; echo "                                                              "
	tput cup 3 42; read nomUsu
	uid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f3)
done

tput cup 6 0; echo "                                                      "

uid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f3)
fechaIngreso=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f5)
gid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f4)
grupo=$(grep -w "$gid:" /etc/group | cut -d: -f1)

tput cup 5 0; tput setaf 6; echo "Nombre de Usuario:"; tput cup 5 19; tput setaf 7; echo "$nomUsu"
tput cup 6 0; tput setaf 6; echo "UID:"; tput cup 6 5; tput setaf 7; echo "$uid"
tput cup 7 0; tput setaf 6; echo "Grupo:"; tput cup 7 7; tput setaf 7; echo "$grupo (GID: $gid)"
tput cup 8 0; tput setaf 6; echo "Fecha de ingreso al sistema: "; tput cup 8 29; tput setaf 7; echo "$fechaIngreso"

tput cup 10 0; tput setaf 3; echo "Desea eliminar el directorio personal del usuario?"
echo "Pulse <S> para 'si' o <N> para 'no'"
tput cup 13 0; tput setaf 7; read opcionDirectorio

while [[ $opcionDirectorio != "S" ]] && [[ $opcionDirectorio != "N" ]] && [[ $opcionDirectorio != "n" ]] && [[ $opcionDirectorio != "s" ]]
do
	tput cup 13 0; echo "                                     "
	tput setaf 1; tput cup 16 0; echo "Opcion incorrecta!"
	echo "Debe ingresar <N> o <S>."
	tput cup 13 0; tput setaf 7; read opcionDirectorio
done

tput cup 16 0; echo "                                 "
tput cup 17 0; echo "                               "

if [[ $opcionDirectorio == "s" ]]
then
	opcionDirectorio="S"
fi

if [[ $opcionDirectorio == "n" ]]
then
	opcionDirectorio="N"
fi

tput setaf 3; tput cup 15 0
echo "Esta seguro que desea eliminar este usuario?"
echo "Pulse E para eliminar"
echo "Pulse S para salir sin eliminar"
tput setaf 7; tput cup 19 0; read opcion

if [[ $opcion == "e" ]]
then
	opcion="E"
fi

if [[ $opcion == "s" ]]
then
	opcion="S"
fi

case $opcion in

	"E")
		
		if [[ $opcionDirectorio == "S" ]]
		then
			sudo userdel -f -r $nomUsu
		else
			sudo userdel -f $nomUsu
		fi
		if [[ $grupo == "admin" ]]
		then
			mv /etc/sudoers /etc/sudoers2
			grep -v "$nomUsu ALL" /etc/sudoers2 > /etc/sudoers
			rm /etc/sudoers2
		fi

		mv /etc/mails /etc/mails2
		grep -v "$nomUsu" /etc/mails2 > /etc/mails
		rm /etc/mails2

		tput cup 22 0; tput setaf 2
		echo "El usuario llamado '$nomUsu' fue eliminado del sistema correctamente!"
		echo "Toque cualquier tecla para volver..."; tput setaf 7; read espera ;;
		
	"S")

		;;
esac