#!/bin/bash

clear

tput cup 1 0; tput setaf 5; echo "Usuarios Conectados en Este Momento"

tput cup 3 0; echo "Usuario"
tput cup 3 23; echo "Terminal"
tput cup 3 37; echo "Ingreso"
tput cup 3 50; echo "Accion"

tput cup 5 0; tput setaf 7
w | grep -v "LOGIN@" | grep -v "load average" | awk '{printf "%-22s %-13s %-12s %-1s %-1s %-12s\n", $1, $2, $3, $7, $8, $9}'


echo ""; tput setaf 7; read espera