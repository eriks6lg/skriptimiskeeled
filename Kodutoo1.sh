#!/bin/bash

# kõikide järgnevate käskude stdout ja stderr saadetakse /dev/nulli

# kontrollib, kas samba on installitud
sudo dpkg -s samba > /dev/null 2>&1

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
test -d $1

# juhul, kui eelneva käsu veakood pole 0 (kausta pole olemas)
if [ $? != 0 ]
	then
	sudo mkdir -p $1
	
	# kui kausta loomisel esines tõrge
	if [ $? != 0 ]
		then
		echo 'Viga kausta loomisel!'
		exit 1
	fi
fi
