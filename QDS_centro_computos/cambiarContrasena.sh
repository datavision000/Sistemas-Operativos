#!/bin/bash
clear

tput setaf 5; tput cup 1 0; echo "Cambiar Mi Contrasena"
tput setaf 3; tput cup 3 0; echo "Ingrese su usuario: "
tput setaf 3; tput cup 4 0; echo "Ingrese la nueva contrasena: "
tput setaf 3; tput cup 5 0; echo "Ingrese nuevamente la nueva contrasena: "
tput setaf 2; tput cup 7 0; echo "(Ingrese 0 para regresar...)"

while [ true ]
do
	tput cup 4 29; echo "                                                            "
	tput cup 5 40; echo "                                                            "
	tput setaf 7
	tput cup 3 20; read usu
	tput cup 4 29; read contrasenaNueva1
	tput cup 5 40; read contrasenaNueva2

	usuLetras=$(echo "${#usu}")
	usu2=$(cut -d: -f1 /etc/passwd | grep -w "$usu")

	if [[ $usu == 0 ]]
	then
		break
	elif [ -z $usu ]
	then
		tput cup 7 0; echo "                                                            "
		tput setaf 1; tput cup 7 0; echo "No existe un usuario llamado '$usu' en el sistema..."
		tput cup 8 0; echo "Intente nuevamente."
	else
		tput cup 7 0; echo "                                                                          "
		tput cup 8 0; echo "                        "
        
        if [[ $contrasenaNueva1 == 0 ]] || [[ $contrasenaNueva2 == 0 ]]
        then
            break
        elif [[ $contrasenaNueva1 != $contrasenaNueva2 ]]
        then
            tput cup 7 0; echo "                                                                                "
            tput cup 8 0; echo "                                                                                            "
            tput cup 7 0; tput setaf 1; echo "Las contrasenas no coinciden..."
            tput cup 8 0; echo "Pruebe nuevamente."
        elif [ -z $contrasenaNueva1 ] || [ -z $contrasenaNueva2 ]
        then
            tput cup 7 0; echo "                                                                                "
            tput cup 8 0; echo "                                                                                            "
            tput setaf 1; tput cup 7 0; echo "Ingrese datos validos."
        else
            tput setaf 3; tput cup 7 0
            echo "Esta seguro que desea modificar su contrasena?"
            echo "Pulse A para aceptar"
            echo "Pulse S para salir sin aceptar"
            tput setaf 7; tput cup 11 0; read opcion

            while [[ $opcion != "A" ]] && [[ $opcion != "S" ]] && [[ $opcion != "s" ]] && [[ $opcion != "a" ]]
            do
                tput cup 11 0; echo "                                          "
                tput setaf 1; tput cup 13 0; echo "Opcion incorrecta!"
                echo "Debe ingresar <A> o <S>."
                tput cup 11 0; tput setaf 7; read opcion
            done

            tput cup 13 0; echo "                                 "
            tput cup 14 0; echo "                               "
            
            if [[ $opcion == "a" ]]
            then
                opcion="A"
            fi

            if [[ $opcion == "s" ]]
            then
                opcion="S"
            fi

            case $opcion in

                "A")
                
                    echo "$contrasenaNueva1" | passwd --stdin $usu > /dev/null
                    tput cup 13 0; tput setaf 2; echo "Tu contrasena fue modificada correctamente!"
                    echo "Presione cualquier tecla para volver..."; read espera; break ;;
                    
                "S")
                    break
                    ;;

            esac
    
        fi

    fi

done