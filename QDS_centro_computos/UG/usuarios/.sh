clear
tput setaf 5
echo "UID"
tput cup 0 15
echo "Usuario"
tput cup 0 34
echo "GID"
tput cup 0 49
echo "Grupo"

lineas=$(wc -l /etc/passwd | cut -d" " -f1)
w=2

for i in $(seq 1 $lineas)
do

	usu=$(grep "$i:" /root/passwd | cut -d: -f1)
	uid=$(grep "$i:" /root/passwd | cut -d: -f3)
	gid=$(grep "$i:" /root/passwd | cut -d: -f4)
	grupo=$(grep "$gid" /root/group | cut -d: -f1)
	tput setaf 7
	tput cup $w 0; echo "$uid"
	tput cup $w 15; echo "$usu"
	tput cup $w 34; echo "$gid"
	tput cup $w 49; echo "$grupo"
	let w=$w+1

done

read espera
