#!/bin/bash

clear

tput setaf 3; tput cup 1 0; echo "Ingrese el UID del usuario a modificar: "
tput setaf 7; tput cup 1 40; read uid

uid2=$(cut -d: -f3 /etc/passwd | grep -w "$uid")

while [ -z $uid2 ]
do
	tput cup 4 0; echo "                                                            "
        tput setaf 1; tput cup 4 0; echo "El usuario con UID '$uid' no existe en el sistema..."
	tput cup 5 0; echo "Intente nuevamente."
	tput setaf 7
        tput cup 1 40; echo "                                                              "
	tput cup 1 40; read uid
	uid2=$(cut -d: -f3 /etc/passwd | grep -w "$uid")
done

tput cup 4 0; echo "                                                     "
tput cup 5 0; echo "                              "

nomUsu=$(grep -w "x:$uid" /etc/passwd | cut -d: -f1)
ingreso=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f5)
gid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f4)
grupo=$(grep -w "$gid:" /etc/group | cut -d: -f1)

tput cup 3 0; tput setaf 6; echo "Nombre de Usuario:"; tput cup 3 19; tput setaf 7; echo "$nomUsu"
tput cup 4 0; tput setaf 6; echo "UID:"; tput cup 4 5; tput setaf 7; echo "$uid"
tput cup 5 0; tput setaf 6; echo "Grupo:"; tput cup 5 7; tput setaf 7; echo "$grupo (GID: $gid)"
tput cup 6 0; tput setaf 6; echo "Ingreso al sistema: "; tput cup 6 20; tput setaf 7; echo "$ingreso"

tput setaf 3; tput cup 8 0
echo "Que desea modificar?:"; echo "Nombre de usuario"; tput setaf 6; tput cup 9 18; echo "(ingrese 'nom')"
tput setaf 3; tput cup 9 34; echo "/ grupo actual"; tput setaf 6; tput cup 9 49; echo "(ingrese 'gr')" 

tput setaf 7; tput cup 11 0; read dato

while [[ $dato != "nom" ]] && [[ $dato != "NOM" ]] && [[ $dato != "GR" ]] && [[ $dato != "gr" ]]
do
	tput cup 11 0; echo "                                                          "
	tput cup 14 0; tput setaf 1; echo "Dato incorrecto!"
	echo "Debe ingresar <nom> o <gr>."
	tput cup 11 0; tput setaf 7; read dato
done

tput cup 14 0; echo "                              "
tput cup 15 0; echo "                                  "

if [[ $dato == "NOM" ]]
then
	dato="nom"
fi

if [[ $dato == "nom" ]]
then
	tput setaf 3; tput cup 13 0; echo "Nuevo nombre de usuario:"
	tput setaf 7; tput cup 13 25; read nom2

	while [[ $nom2 == $nomUsu ]]
	do
		tput cup 13 25; echo "                                        "
		tput setaf 1; tput cup 16 0; echo "Ingrese un nombre diferente al original..."
		tput cup 13 25; tput setaf 7; read nom2
	done		

	nomUsuLetras=$(echo "${#nomUsu}")
	nom2Letras=$(echo "${#nom2}")
	x=$((50 + $nomUsuLetras))
	y=$(($x + 3))
	z=$(($y + $nom2Letras + 2))

	tput setaf 3; tput cup 15 0; echo "Esta seguro que desea modificar este usuario de"; tput cup 15 48; tput setaf 5; echo "'$nomUsu'"
	tput cup 15 $x; tput setaf 3; echo " a"; tput cup 15 $y; tput setaf 5; echo "'$nom2'"; tput cup 15 $z; tput setaf 3; echo "?"
	echo "Pulse M para modificar"
	echo "Pulse S para salir sin modificar"
	tput cup 19 0; tput setaf 7; read opcion

	if [[ $opcion == "m" ]]
	then
		opcion="M"
	fi

	if [[ $opcion == "s" ]]
	then
		opcion="S"
	fi

	case $opcion in

		"M") 
			sudo usermod -l $nom2 $nomUsu
			tput cup 22 0; tput setaf 2; echo "Nombre de usuario modificado correctamente!"
			echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera
			;;
		
		"S")

			;;
	esac

fi

if [ $dato == "GR" ]
then
	dato="gr"
fi

if [[ $dato == "gr" ]]
then
	tput setaf 3; tput cup 13 0; echo "Nombre del grupo al que lo desea mover: "
	tput setaf 7; tput cup 13 40; read gr2

	while [[ $gr2 == $grupo ]]
	do
		tput cup 16 0; echo "                                                          "
		tput setaf 1; tput cup 16 0; echo "El usuario '$nomUsu' ya esta ingresado en ese grupo!"
		tput cup 17 0; echo "Intente ingresando uno diferente."
		tput setaf 7
		tput cup 13 40; echo "                                                              "
		tput cup 13 40; read gr2 

	done

	tput cup 16 0; echo "                                                            "
	tput cup 17 0; echo "                                                               "

	gr3=$(cut -d: -f1 /etc/group | grep -w "$gr2")

	while [ -z $gr3 ]
	do
		tput cup 16 0; echo "                                                          "
        	tput setaf 1; tput cup 16 0; echo "No existe un grupo llamado '$gr2' en el sistema..."
		tput cup 17 0; echo "Intente ingresando uno existente o regrese luego de crearlo."
		tput setaf 7
        	tput cup 13 40; echo "                                                              "
		tput cup 13 40; read gr2
		gr3=$(cut -d: -f1 /etc/group | grep -w "$gr2")
	done

	tput cup 16 0; echo "                                                            "
	tput cup 17 0; echo "                                                               "

	grupoLetras=$(echo "${#grupo}")
	gr2Letras=$(echo "${#gr2}")
	u=$((54 + $grupoLetras))
	v=$(($u + 9))
	w=$(($v + $gr2Letras + 2))

	tput setaf 3; tput cup 15 0; echo "Esta seguro que desea cambiar al usuario del grupo"; tput cup 15 51; tput setaf 5; echo "'$grupo'"
	tput setaf 3; tput cup 15 $u; echo "al grupo"; tput setaf 5; tput cup 15 $v; echo "'$gr2'"; tput setaf 3; tput cup 15 $w; echo "?"

	echo "Pulse A para aceptar"
	echo "Pulse S para salir sin aceptar"
	tput cup 19 0; tput setaf 7; read opcion2

	if [[ $opcion2 == "a" ]]
	then
		opcion2="A"
	fi

	if [[ $opcion2 == "s" ]]
	then
		opcion2="S"
	fi

	case $opcion2 in

		"A") 
			gid2=$(cut -d: -f3 /etc/group | grep -w "$gr2")
			sudo usermod -g $gr2 $nomUsu
			tput cup 22 0; tput setaf 2; echo "Grupo del usuario '$nomUsu' ($uid) modificado correctamente!"
			echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera2
			;;
		
		"S")

			;;
	esac


fi