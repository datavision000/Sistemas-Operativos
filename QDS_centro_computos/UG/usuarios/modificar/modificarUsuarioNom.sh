#!/bin/bash
clear

tput setaf 5; tput cup 1 0; echo "Modificar un Usuario (por nombre)"

tput setaf 3; tput cup 3 0; echo "Ingrese el nombre del usuario a modificar: "
tput setaf 7; tput cup 3 43; read nomUsu

nomUsu2=$(cut -d: -f1 /etc/passwd | grep -w "$nomUsu")

while [ -z $nomUsu2 ]
do
	tput cup 6 0; echo "                                                            "
        tput setaf 1; tput cup 6 0; echo "No existe un usuario llamado '$nomUsu' en el sistema..."
	tput cup 7 0; echo "Intente nuevamente."
	tput setaf 7
        tput cup 3 43; echo "                                                              "
	tput cup 3 43; read nomUsu
	nomUsu2=$(cut -d: -f1 /etc/passwd | grep -w "$nomUsu")
done

tput cup 6 0; echo "                                                         "
tput cup 7 0; echo "                              "

while [[ $nomUsu == "admin" ]]
do
	tput setaf 1; tput cup 6 0; echo "El usuario 'admin' no puede ser modificado..."	
	tput cup 7 0; echo "Intente nuevamente."
	tput setaf 7
        tput cup 3 43; echo "                                                              "
	tput cup 3 43; read nomUsu
done

tput cup 6 0; echo "                                                            "
tput cup 7 0; echo "                              "

uid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f3)
ingreso=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f5)
gid=$(grep -w "$nomUsu:x" /etc/passwd | cut -d: -f4)
grupo=$(grep -w "$gid:" /etc/group | cut -d: -f1)

tput cup 5 0; tput setaf 6; echo "Nombre de Usuario:"; tput cup 5 19; tput setaf 7; echo "$nomUsu"
tput cup 6 0; tput setaf 6; echo "UID:"; tput cup 6 5; tput setaf 7; echo "$uid"
tput cup 7 0; tput setaf 6; echo "Grupo:"; tput cup 7 7; tput setaf 7; echo "$grupo (GID: $gid)"
tput cup 8 0; tput setaf 6; echo "Ingreso al sistema: "; tput cup 8 20; tput setaf 7; echo "$ingreso"

tput setaf 3; tput cup 10 0
echo "Que desea modificar?:"; echo "Nombre de usuario"; tput setaf 6; tput cup 11 18; echo "(ingrese 'nom')"
tput setaf 3; tput cup 11 34; echo "/ grupo actual"; tput setaf 6; tput cup 11 49; echo "(ingrese 'gr')" 

tput setaf 7; tput cup 13 0; read dato

while [[ $dato != "nom" ]] && [[ $dato != "NOM" ]] && [[ $dato != "GR" ]] && [[ $dato != "gr" ]]
do
	tput cup 13 0; echo "                                                          "
	tput cup 16 0; tput setaf 1; echo "Opcion incorrecta!"
	echo "Debe ingresar <nom> o <gr>."
	tput cup 13 0; tput setaf 7; read dato
done

tput cup 16 0; echo "                              "
tput cup 17 0; echo "                                  "

if [[ $dato == "NOM" ]]
then
	dato="nom"
fi

if [[ $dato == "nom" ]]
then
	tput setaf 3; tput cup 15 0; echo "Nuevo nombre de usuario:"
	tput setaf 7; tput cup 15 25; read nom2

	while [[ $nom2 == $nomUsu ]]
	do
		tput cup 15 25; echo "                                        "
		tput setaf 1; tput cup 18 0; echo "Ingrese un nombre diferente al original..."
		tput cup 15 25; tput setaf 7; read nom2
	done

	tput cup 18 0; echo "                                                "

	usu2=$(cut -d: -f1 /etc/passwd | grep -w "$nom2")

	while [[ $usu2 != "" ]]
	do
		tput cup 18 0; echo "                                                               "
        	tput setaf 1; tput cup 18 0; echo "El usuario '$nom2' ya existe en el sistema..."
		tput setaf 7
        	tput cup 15 25; echo "                                                   "
		tput cup 15 25; read nom2
		usu2=$(cut -d: -f1 /etc/passwd | grep -w "$nom2")
	done

	tput cup 18 0; echo "                                                "
	
	nomUsuLetras=$(echo "${#nomUsu}")
	nom2Letras=$(echo "${#nom2}")
	x=$((50 + $nomUsuLetras))
	y=$(($x + 3))
	z=$(($y + $nom2Letras + 2))

	tput setaf 3; tput cup 17 0; echo "Esta seguro que desea modificar este usuario de"; tput cup 17 48; tput setaf 5; echo "'$nomUsu'"
	tput cup 17 $x; tput setaf 3; echo " a"; tput cup 17 $y; tput setaf 5; echo "'$nom2'"; tput cup 17 $z; tput setaf 3; echo "?"
	echo "Pulse M para modificar"
	echo "Pulse S para salir sin modificar"
	tput cup 21 0; tput setaf 7; read opcion

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
			tput cup 23 0; tput setaf 2; echo "Nombre de usuario modificado correctamente!"
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
	tput setaf 3; tput cup 15 0; echo "Nombre del grupo al que lo desea mover: "
	tput setaf 7; tput cup 15 40; read gr2

	while [[ $gr2 == $grupo ]]
	do
		tput cup 18 0; echo "                                                          "
		tput setaf 1; tput cup 18 0; echo "El usuario '$nomUsu' ya esta ingresado en ese grupo!"
		tput cup 19 0; echo "Intente ingresando uno diferente."
		tput setaf 7
		tput cup 15 40; echo "                                                              "
		tput cup 15 40; read gr2 

	done

	tput cup 18 0; echo "                                                            "
	tput cup 19 0; echo "                                                               "

	gr3=$(cut -d: -f1 /etc/group | grep -w "$gr2")

	while [ -z $gr3 ]
	do
		tput cup 18 0; echo "                                                          "
        	tput setaf 1; tput cup 18 0; echo "No existe un grupo llamado '$gr2' en el sistema..."
		tput cup 19 0; echo "Intente ingresando uno existente o regrese luego de crearlo."
		tput setaf 7
        	tput cup 15 40; echo "                                                              "
		tput cup 15 40; read gr2
		gr3=$(cut -d: -f1 /etc/group | grep -w "$gr2")
	done

	tput cup 18 0; echo "                                                            "
	tput cup 19 0; echo "                                                               "

	grupoLetras=$(echo "${#grupo}")
	gr2Letras=$(echo "${#gr2}")
	u=$((54 + $grupoLetras))
	v=$(($u + 9))
	w=$(($v + $gr2Letras + 2))

	tput setaf 3; tput cup 17 0; echo "Esta seguro que desea cambiar al usuario del grupo"; tput cup 17 51; tput setaf 5; echo "'$grupo'"
	tput setaf 3; tput cup 17 $u; echo "al grupo"; tput setaf 5; tput cup 17 $v; echo "'$gr2'"; tput setaf 3; tput cup 17 $w; echo "?"

	echo "Pulse A para aceptar"
	echo "Pulse S para salir sin aceptar"
	tput cup 21 0; tput setaf 7; read opcion2

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
	
			if [[ $grupo == "admin" ]]
			then
				mv /etc/sudoers /etc/sudoers2
				grep -v "$nomUsu ALL" /etc/sudoers2 > /etc/sudoers
				rm /etc/sudoers2
			fi

			if [[ $gr2 == "admin" ]]
			then
				echo "$nomUsu ALL=(ALL:ALL) ALL" >> /etc/sudoers
			fi
			
			tput cup 23 0; tput setaf 2; echo "Grupo del usuario '$nomUsu' modificado correctamente!"
			echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera2
			;;
		
		"S")

			;;
	esac


fi