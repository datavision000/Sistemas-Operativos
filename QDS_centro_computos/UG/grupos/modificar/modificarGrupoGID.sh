#!/bin/bash

clear

tput setaf 3; tput cup 1 0; echo "Ingrese el GID del grupo a modificar: "
tput setaf 7; tput cup 1 48; read gid

gid2=$(cut -d: -f3 /etc/group | grep -w "$gid")

while [ -z $gid2 ]
do
	tput cup 4 0; echo "                                                            "
        tput setaf 1; tput cup 4 0; echo "No existe un grupo con GID '$gid' en el sistema..."
	tput cup 5 0; echo "Intente nuevamente."
	tput setaf 7
        tput cup 1 35; echo "                                                              "
	tput cup 1 35; read gid
	gid2=$(cut -d: -f3 /etc/group | grep -w "$gid")
done

tput cup 4 0; echo "                                                             "
tput cup 5 0; echo "                              "

nomGr=$(grep -w "$gid" /etc/group | cut -d: -f1)

tput cup 3 0; tput setaf 6; echo "Nombre de Grupo:"; tput cup 3 17; tput setaf 7; echo "$nomGr"
tput cup 4 0; tput setaf 6; echo "GID:"; tput cup 4 5; tput setaf 7; echo "$gid"

tput cup 6 0; tput setaf 3; echo "Ingrese el nuevo nombre para el grupo: "
tput cup 6 39; tput setaf 7; read nuevoNom

while [[ $nuevoNom =~ ^[0-9]+$ ]]
do
	tput setaf 1; tput cup 9 0; echo "El nombre del grupo no puede contener numeros..."
	tput setaf 7
	tput cup 6 39; echo "                                            "
	tput cup 6 39; read nuevoNom
done

while [[ $nuevoNom == $nomGr ]]
do
	tput cup 6 39; echo "                                        "
	tput setaf 1; tput cup 9 0; echo "Ingrese un nombre diferente al original..."
	tput cup 6 39; tput setaf 7; read nuevoNom
done

tput cup 9 0; echo "                                                "

nuevoNom2=$(cut -d: -f1 /etc/group | grep -w "$nuevoNom")

while [[ $nuevoNom2 != "" ]]
do
        tput setaf 1; tput cup 9 0; echo "El grupo '$nuevoNom' ya existe en el sistema..."
	tput setaf 7
        tput cup 6 39; echo "                                         "
	tput cup 6 39; read nuevoNom
	nuevoNom2=$(cut -d: -f1 /etc/group | grep -w "$nuevoNom")
done

tput cup 9 0; echo "                                                                       "

nomGrLetras=$(echo "${#nomGr}")
nuevoNomLetras=$(echo "${#nuevoNom}")
x=$((58 + $nomGrLetras))
y=$(($x + 2))
z=$(($y + $nuevoNomLetras + 2))

tput setaf 3; tput cup 8 0; echo "Esta seguro que desea modificar el nombre del grupo de"; tput cup 8 55; tput setaf 5; echo "'$nomGr'"
tput cup 8 $x; tput setaf 3; echo "a"; tput cup 8 $y; tput setaf 5; echo "'$nuevoNom'"; tput cup 8 $z; tput setaf 3; echo "?"
echo "Pulse M para modificar"
echo "Pulse S para salir sin modificar"
tput cup 12 0; tput setaf 7; read opcion

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
		sudo groupmod -n $nuevoNom $nomGr
		tput cup 14 0; tput setaf 2; echo "Nombre del grupo modificado correctamente!"
		echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera
		;;
		
	"S")

		;;
esac