#!/bin/bash

tiempo_restante=3

while [ $tiempo_restante -ge 0 ]
do
	if [ $tiempo_restante -gt 1 ] || [ $tiempo_restante -eq 0 ]
	then
		tput cup 16 0; tput setaf 1; echo "Saliendo en $tiempo_restante segundos..."
	elif [ $tiempo_restante -eq 1 ]
	then	
		tput cup 16 0; echo "                                                      "
		tput cup 16 0; tput setaf 1; echo "Saliendo en $tiempo_restante segundo..."
	fi
	sleep 1
	tiempo_restante=$(($tiempo_restante - 1))
done

tput setaf 7; clear; exit
