#!/bin/bash
#chmod +x /etc/profile.d/tiaoban.sh
#[ $UID -ne 0 ] && . /scripts/tiaoban.sh
function trapper () {

	trap ':' INT EXIT TSTP TERM HUP
	
}
while :
do trapper 
	clear
		cat <<menu
		1)web1
		2)web2
		3)web3
		4)exit
menu
		read -p "plses select:" num
		case "$num" in
		1)
		echo 1
		echo $UID
		;;
		2)
		echo $PWD
		;;
		3)
		echo "web 3"
		;;
		4|*)
		exit
		esac
done
