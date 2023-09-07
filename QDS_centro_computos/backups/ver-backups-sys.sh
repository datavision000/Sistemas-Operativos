#!/bin/bash

clear

tput cup 1 0; tput setaf 5; echo "Backups de las config. del sistema"
tput cup 3 0; tput setaf 3; ls /home/admin/backups/copias-etc -1
echo ""; tput setaf 7; read espera
