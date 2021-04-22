#!/bin/bash
#

function most_serv {
	clear
	echo "SERVEIS A DESHABILITAR:"
	echo "a) cups"
	echo "b) ssh"
	echo "c) apache2"
	echo -n "Selecciona una opció: "
	read opc	
	return 0
}

function ctl_serv {
	case $opc in
		a) systemctl stop cups > /dev/null
			systemctl disable ssh > /dev/null
			systemctl status ssh 
		   ;;
		b) systemctl stop ssh > /dev/null
			systemctl disable ssh > /dev/null
			systemctl status ssh 
		   ;;
		c)systemctl stop apache2 > /dev/null
			systemctl disable ssh > /dev/null
			systemctl status ssh 
		   ;;
		*) echo "Opció incorrecta";;
	esac
}

if (( EUID != 0 ))
then
  echo "Aquest script s'ha d'executar amb prilegis de l'usuari root"
  exit 10 
fi

most_serv
ctl_serv


exit 10
return 10
