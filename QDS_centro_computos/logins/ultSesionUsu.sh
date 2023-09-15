#!/bin/bash

clear

tput cup 1 0; tput setaf 5; echo "Ultima Sesion de un Usuario en el Sistema"

tput setaf 3; tput cup 3 0; echo "Ingrese el nombre de usuario a buscar: "
tput cup 3 39; tput setaf 7; read usu

tput setaf 5; tput cup 5 0
echo "Usuario"
tput cup 5 23; echo "Terminal"
tput cup 5 39; echo "Fecha"
tput cup 5 57; echo "Hora"

tput cup 7 0; tput setaf 7

lastlog -u $usu | tail -1 | awk '{printf "%-22s %-15s %-1s %-1s %-10s %-12s\n", $1, $2, $5, $4, $8, $6}'


echo ""; read espera