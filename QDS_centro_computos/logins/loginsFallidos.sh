#!/bin/bash

clear

tput cup 1 0; tput setaf 5; echo "Logins al Sistema Fallidos"

tput setaf 6; tput cup 3 0
echo "Usuario"
tput cup 3 23; echo "Terminal"
tput cup 3 39; echo "Fecha"
tput cup 3 56; echo "Horario"


tput cup 5 0; tput setaf 7
lastb -R | grep -v "reboot" | grep -v "btmp" | awk '{printf "%-22s %-15s %-1s %-1s %-9s %-1s %-1s %-12s\n", $1, $2, $3, $5, $4, $6, $7, $8}'

echo " "; echo " "; tput setaf 2; echo "Presione cualquier tecla para volver..."; tput setaf 7; read espera