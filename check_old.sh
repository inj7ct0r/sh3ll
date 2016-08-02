#!/bin/bash
#  Author:mor.inj3ct0r         
#  Date:Mon Aug  1 09:37:19 PDT 2016         
#  Function:Check backdoor scripts        
#  Version: 0.1                       

export HISTSIZE=0;export HISTFILE=/dev/null
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
if [ $UID -eq 0 ];then
	echo "" >/dev/null
else
	echo -e "\033[32mMust be root ro run this script!\033[0m"
exit
fi

rpm -fV /usr/bin/ssh
if [ $? -eq 0 ];then

	echo -e "\033[32mGod luck!openssh backdoor not found!\033[0m"
else

	echo -e "\033[32mPlese check openssh!\033[0m"
fi

#check pam

rpm -Va pam |grep pam_unix.so
if [ $? -eq 1 ];then

        echo -e "\033[32mGod luck!pam backdoor not found!\033[0m"
else

        echo -e "\033[32mPlese check pam!\033[0m"
fi

