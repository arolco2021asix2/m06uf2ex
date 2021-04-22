#!/bin/bash
clear
if (( EUID != 0 ))
then
  echo "Aquest script s'ha d'executar amb prilegis de l'usuari root"
  exit 1
fi
ip addr show enp0s3 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1
function valid_ip()
{
local  ip=ip addr show enp0s3 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1
local  stat=1

if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    OIFS=$IFS
    IFS='.'
    ip=($ip)
    IFS=$OIFS
    [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
        && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
    stat=$?
fi
return $stat
}
if valid_ip;
then echo "No, eso NO es una IP";
else
nmap -v $ip;
fi
