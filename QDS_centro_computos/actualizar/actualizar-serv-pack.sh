#!/bin/bash

clear
tput setaf 5; tput cup 1 0; echo "Actualizar servicios y paquetes"
tput setaf 7; echo ""

sh /home/admin/scripts-backups/update-serv-pack.sh

echo ""

tput setaf 2; echo "Servicios y paquetes actualizados correctamente!"
echo "Toque cualquier tecla para volver..."; tput setaf 7; read espera