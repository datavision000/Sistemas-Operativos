#!/bin/bash

ip=$(ip addr show enp0s3 | grep -w inet | cut -d' ' -f6 | cut -d/ -f1)

tput cup 19 0; tput setaf 6; echo "IP para aplicacion:"
tput cup 19 20; tput setaf 7; echo "$ip"

tput cup 21 0; tput setaf 2
echo "Debe ingresar '$ip:8000/QDS' en su navegador"
echo "para utilizar la aplicacion."
tput setaf 7

echo " "; read espera