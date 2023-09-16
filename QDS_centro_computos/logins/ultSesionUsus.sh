#!/bin/bash

clear

tput cup 1 0; tput setaf 5; echo "Ultima Sesion de los Usuarios del Sistema"

tput setaf 6; tput cup 3 0
echo "Usuario"
tput cup 3 23; echo "Terminal"
tput cup 3 39; echo "Fecha"
tput cup 3 57; echo "Hora"


x=$(lastlog | wc -l)
w=$(($x - 1))

tput cup 5 0; tput setaf 7

lastlog | tail -$w | grep -v "**Nunca ha accedido**" | awk '{printf "%-22s %-15s %-1s %-1s %-10s %-12s\n", $1, $2, $5, $4, $8, $6}'

echo ""; read espera