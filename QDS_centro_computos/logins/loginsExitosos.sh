#!/bin/bash

clear

tput cup 1 0; tput setaf 5; echo "Logins al Sistema Exitosos"

tput cup 3 0; tput setaf 3; echo "Cantidad de sesiones a mostrar: "

tput cup 3 32; tput setaf 7; read cantPedida; echo ""

tput setaf 5; tput cup 5 0
echo "Usuario"
tput cup 5 23; echo "Fecha"
tput cup 5 39; echo "Horario"


tput cup 7 0; tput setaf 7
last -R | grep -v "reboot" | awk '{printf "%-22s %-1s %-12s %-1s %-1s %-12s\n", $1, $5, $4, $6, " - ", $8}' | head -n $cantPedida

echo ""; tput setaf 7; read espera