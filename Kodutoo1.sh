#!/bin/bash
sudo dpkg -s samba > /dev/null
echo $?
if [ $? != 0 ]
	then
	echo '2'
	sudo apt -y install samba > /dev/null
	if [$? != 0]
		then
		echo 'Viga Samba paigaldamisel!'
		exit 1
	fi
	echo '3'
fi

