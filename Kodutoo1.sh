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


