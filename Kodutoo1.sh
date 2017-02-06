#!/bin/bash

# kõikide järgnevate käskude stdout ja stderr saadetakse /dev/nulli

# kontrollib, kas samba on installitud
dpkg -s samba > /dev/null 2>&1

# kui eelneva käsu veakood pole 0 (samba pole installitud)
if [ $? != 0 ]
	then
	sudo apt -y install samba > /dev/null 2>&1
	
	# kui samba installimisel esines tõrge
	if [ $? != 0 ]
		then
		echo 'Viga Samba paigaldamisel!'
		exit 1
	fi
fi

# kontrollib, kas kaust on juba olemas
test -d $1 > /dev/null 2>&1

# juhul, kui eelneva käsu veakood pole 0 (kausta pole olemas)
if [ $? != 0 ]
	then
	sudo mkdir -p $1 > /dev/null 2>&1
	
	# kui kausta loomisel esines tõrge
	if [ $? != 0 ]
		then
		echo 'Viga kausta loomisel!'
		exit 1
	fi
fi

# loome kausta jaoks absolute pathi
if [[ "$1" == /* ]]
	then
	abs_path=$1
else
	this_path=$(pwd) > /dev/null 2>&1
	abs_path=$this_path'/'$1
fi

# kontrollib, kas grupp on juba olemas
getent group | cut -d: -f1 | grep $2 > /dev/null 2>&1

# juhul, kui eelneva käsu veakood pole 0 (gruppi pole olemas)
if [ $? != 0 ]
	then
	sudo addgroup $2 > /dev/null 2>&1
	
	# kui grupi loomisel esines tõrge
	if [ $? != 0 ]
		then
		echo 'Viga grupi loomisel!'
		exit 1
	fi
fi

# kontrollime, kas grupil on share olemas Samba konfiguratsioonifailis
grep -F "[$2]" /etc/samba/smb.conf > /dev/null 2>&1

# juhul, kui eelneva käsu exit code pole 0 (share pole olemas)
if [ $? != 0 ]
	then
	sudo bash -c "echo -e '[$2]\npath = $abs_path\nvalid users = @$2\nread only = no' >> /etc/samba/smb.conf"
fi
