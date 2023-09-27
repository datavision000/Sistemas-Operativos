#!/bin/bash

clear
fechaActual=$(date +%d/%m/%Y)
horaActual=$(date +%H.%M)
comentario=$(echo "$fechaActual-$horaActual")

echo ""
tput setaf 5; echo "Ingresar un Usuario"

tput setaf 3
tput cup 3 0; echo "Nombre de usuario: "
tput cup 4 0; echo "Nombre del grupo: "
tput cup 5 0; echo "Mail: "
tput setaf 7

tput cup 3 19; read usu

usuLetras=$(echo "${#usu}")

while [ $usuLetras -lt 3 ]
do
	tput setaf 1; tput cup 8 0; echo "El nombre de usuario debe contener al menos 3 caracteres..."
	tput setaf 7
        tput cup 3 19; echo "                                              "
	tput cup 3 19; read usu
	usuLetras=$(echo "${#usu}")
done

tput cup 8 0; echo "                                                                                 "

while [[ $usu =~ ^[0-9]+$ ]]
do
	tput setaf 1; tput cup 8 0; echo "El nombre de usuario no puede contener numeros..."
	tput setaf 7
	tput cup 3 19; echo "                                          "
	tput cup 3 19; read usu
done

tput cup 8 0; echo "                                                                                 "

usu2=$(cut -d: -f1 /etc/passwd | grep -w "$usu")

while [[ $usu2 != "" ]]
do
	tput cup 8 0; echo "                                                               "
        tput setaf 1; tput cup 8 0; echo "El usuario '$usu' ya existe en el sistema..."
	tput setaf 7
        tput cup 3 19; echo "                                                   "
	tput cup 3 19; read usu
	usu2=$(cut -d: -f1 /etc/passwd | grep -w "$usu")
done

tput cup 8 0; echo "                                                                      "

tput cup 4 18; read grupo

grupo2=$(cut -d: -f1 /etc/group | grep -w "$grupo")

while [ -z $grupo2 ]
do
	tput cup 8 0; echo "                                                             "
        tput setaf 1; tput cup 8 0; echo "El grupo '$grupo' no existe en el sistema..."
	tput cup 9 0; echo "Intente ingresando uno existente o regrese luego de crearlo."
	tput setaf 7
        tput cup 4 18; echo "                                                              "
	tput cup 4 18; read grupo
	grupo2=$(cut -d: -f1 /etc/group | grep -w "$grupo")
done

tput cup 8 0; echo "                                                             "
tput cup 9 0; echo "                                                           "

tput cup 5 6; read mail

mail2=$(grep -w ":$mail" /etc/mails)

while [ $mail2 ]
do
	tput setaf 1; tput cup 8 0; echo "Ese correo ya esta registrado en el sistema..."
	tput cup 9 0; echo "Ingrese uno diferente."
	tput setaf 7; tput cup 5 6; echo "                                        "
	tput cup 5 6; read mail
	mail2=$(grep -w ":$mail" /etc/mails)
done

tput cup 8 0; echo "                                                                 "
tput cup 9 0; echo "                                                  "

if [[ $grupo == "admin" ]]
then
	echo "$usu ALL=(ALL:ALL) ALL" >> /etc/sudoers
fi

useradd -g $grupo -c $comentario $usu
echo "$usu:$usu" | sudo chpasswd
echo "$usu:$mail" >> /etc/mails

tput setaf 2; tput cup 8 0
echo "El usuario '$usu' (grupo: '$grupo') fue ingresado correctamente al sistema!"
tput cup 9 0; echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera
