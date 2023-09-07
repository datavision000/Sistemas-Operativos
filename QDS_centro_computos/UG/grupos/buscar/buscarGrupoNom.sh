clear

tput setaf 3; tput cup 1 0; echo "Ingrese el nombre del grupo a buscar: "
tput setaf 7; tput cup 1 38; read nomGr

nomGr2=$(cut -d: -f1 /etc/group | grep -w "$nomGr")

while [ -z $nomGr2 ]
do
	tput cup 4 0; echo "                                                            "
        tput setaf 1; tput cup 4 0; echo "No existe un grupo llamado '$nomGr' en el sistema..."
	tput cup 5 0; echo "Intente nuevamente."
	tput setaf 7
        tput cup 1 38; echo "                                                              "
	tput cup 1 38; read nomGr
	nomGr2=$(cut -d: -f1 /etc/group | grep -w "$nomGr")
done

tput cup 4 0; echo "                                              "
tput cup 5 0; echo "                              "

gid=$(grep -w "$nomGr:x" /etc/group | cut -d: -f3)

tput cup 3 0; tput setaf 6; echo "Nombre de Grupo:"; tput cup 3 17; tput setaf 7; echo "$nomGr"
tput cup 4 0; tput setaf 6; echo "GID:"; tput cup 4 5; tput setaf 7; echo "$gid"

tput cup 7 0; tput setaf 2; echo "Presione cualquier tecla para volver..."; tput setaf 7
read espera