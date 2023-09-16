#!/bin/bash
clear

tput setaf 5; tput cup 1 0; echo "Eliminar un Usuario (por UID)"

tput setaf 3; tput cup 3 0; echo "Ingrese el UID del usuario a eliminar: "
tput setaf 7; tput cup 3 39; read uid

uid2=$(grep -w "x:$uid" /etc/passwd | cut -d: -f3)

while [ -z $uid2 ]
do
	tput cup 6 0; echo "                                                            "
        tput setaf 1; tput cup 6 0; echo "No existe un usuario con UID '$uid' en el sistema..."
	tput cup 7 0; echo "Intente nuevamente."
	tput setaf 7
        tput cup 3 39; echo "                                                              "
	tput cup 3 39; read uid
	uid2=$(cut -d: -f3 /etc/passwd | grep -w "$uid")
done

tput cup 6 0; echo "                                                            "
tput cup 7 0; echo "                              "

while [[ $uid == 1000 ]]
do
	tput cup 6 0; echo "                                                            "
        tput setaf 1; tput cup 6 0; echo "No es posible eliminar a este usuario..."
	tput setaf 7
        tput cup 3 39; echo "                                                              "
	tput cup 3 39; read uid
done

tput cup 6 0; echo "                                                      "

nomUsu=$(grep -w "x:$uid" /etc/passwd | cut -d: -f1)
ingreso=$(grep -w "x:$uid" /etc/passwd | cut -d: -f5)
gid=$(grep -w "x:$uid" /etc/passwd | cut -d: -f4)
grupo=$(grep -w "$gid:" /etc/group | cut -d: -f1)

tput cup 5 0; tput setaf 6; echo "Nombre de Usuario:"; tput cup 5 19; tput setaf 7; echo "$nomUsu"
tput cup 6 0; tput setaf 6; echo "UID:"; tput cup 6 5; tput setaf 7; echo "$uid"
tput cup 7 0; tput setaf 6; echo "Grupo:"; tput cup 7 7; tput setaf 7; echo "$grupo (GID: $gid)"
tput cup 8 0; tput setaf 6; echo "Ingreso al sistema: "; tput cup 8 20; tput setaf 7; echo "$ingreso"

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

		tput cup 22 0; tput setaf 2
		echo "El usuario con UID '$uid' fue eliminado del sistema correctamente!"
		echo "Toque cualquier tecla para volver..."; tput setaf 7; read espera ;;
		
	"S")

		;;
esac