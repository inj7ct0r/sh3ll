#!/bin/bash
#auto mor.inj3ct0r 
#date:2016-05-02
#install lamp (nginx+php+mysql)
if [ $UID -eq 0 ];then
        echo -e "\033[31mGood lucck!you are root,Pless next!\033[0m"
else
        echo -e "\033[31m sorry!you need to root running,Pless check!\033[0m"
        exit

fi

if [ -z "$1" ];then
	echo -e "\033[32m请选择如下菜单进行配置!\033[0m"
	echo -e "\033[32m(0)安装依赖库和开发环境\033[0m"
	echo -e "\033[32m(1)安装mysql server!\033[0m"
	echo -e "\033[32m(2)安装php server!\033[0m"
	echo -e "\033[32m(3)安装nginx server!\033[0m"
	echo -e "\033[32m(4)配置lamp环境!\033[0m"
	echo -e "\033[32mcommand:{/bin/bash or sh $0 0|1|2|3|4|5\033[0m"
	exit
fi
#安装依赖库和开发环境

if [[ "$1" -eq "0" ]];then
	yum install cmake make apr* autoconf automake curl-devel gcc 	gcc-c++ zlib-devel openssl openssl-devel pcre-devel gd kernel keyu	tils patch perl kernel-headers compat* mpfr cpp glibc libgomp l	ibstdc++-devel ppl cloog-ppl keyutils-libs-devel libcom_err-devel li	bsepol-devel  libselinux-devel krb5-devel zlib-devel libXpm* free	type libjpeg* libpng* php-common php-gd ncurses* libtool* libx	ml2 libxml2-devel patch -y
	echo "安装成功"
	exit
fi
#make install mysql server
M_FILES=mysql-5.6.29.tar.gz
M_FILES_DIR=mysql-5.6.29
M_URL=http://mirrors.sohu.com/mysql/MySQL-5.6/
M_PREFIX=/usr/local/mysql/
	echo -e "\033[32m正在添加mysql组!\033[0m"
	groupadd mysql
	useradd -g mysql mysql -s /bin/false
        chown -R mysql:mysql /data/mysql
	mkdir -p $M_PREFIX
	echo -e "\033[32m添加mysql组成功!\033[0m"
MYSQL_DIR=/data/mysql/

if [ ! -d $MYSQL_DIR ];then
        echo -e "\033[32m$MYSQL_DIR目录不存在,正在创建中....\033[0m"
        mkdir -p $MYSQL_DIR
        echo -e "\033[32mMYSQL_DIR目录创建成功\033[0m"
else
        echo -e "\033[32m$MYSQL_DIR目录已经存在,不需要创建!\033[0m"

fi

if [[ "$1" -eq "1" ]];then

	wget -c $M_URL/$M_FILES &&tar -zxvf $M_FILES &&cd $M_FILES_DIR &&yum install cmake libncurses5-dev ncurses-devel -y; rm -rf CMakeCache.txt &&cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/data/mysql -DSYSCONFDIR=/etc
	
	if [ $? -eq 0 ];then
		make && make install
		cd /usr/local/mysql　　
		mv /etc/my.cnf /etc/my.cnf.bak
		cp ./support-files/my-huge.cnf /etc/my.cnf　　
		datadir = /data/mysql #添加MySQL数据库路径　　
		./scripts/mysql_install_db --user=mysql #生成mysql系统数据库　　
		cp ./support-files/mysql.server /etc/rc.d/init.d/mysqld #把Mysql加入系统启动　　
		chmod 755 /etc/init.d/mysqld #增加执行权限　　
		chkconfig mysqld on #加入开机启动　
		#basedir = /usr/local/mysql #MySQL程序安装路径　　
		#datadir = /data/mysql #MySQl数据库存放目录　　
		service mysqld start #启动
		export PATH=$PATH:/usr/local/mysql/bin
		#下面这两行把myslq的库文件链接到系统默认的位置，这样你在编译类似PHP等软件时可以不用指定mysql的库文件地址。　　
		ln -s /usr/local/mysql/lib/mysql /usr/lib/mysql　　
		ln -s /usr/local/mysql/include/mysql /usr/include/mysql	
			echo -e "\033[32m $M_FILES_DIR make install successfully!\033[0m"
	else
			echo -e "\033[32m $M_FILES_DIR make install failed,please check!\033[0m" 
			exit
	fi

fi
#make install php server
P_FILES=php-5.6.7.tar.gz
P_FILES_DIR=php-5.6.7
P_URL=http://mirrors.sohu.com/php/
P_PREFIX=/usr/local/php5/

L_FILES=libmcrypt-2.5.8.tar.gz
L_FILES_DIR=libmcrypt-2.5.8
L_URL=http://nchc.dl.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/

if [[ "$1" -eq "2" ]];then
	wget -c $L_URL/$L_FILES &&tar zxvf $L_FILES &&cd $L_FILES_DIR;./configure && make && make install
	wget -c $P_URL/$P_FILES &&tar zxvf $P_FILES &&cd $P_FILES_DIR;mkdir -p $P_PREFIX;yum install libxml2 libxml2-devel -y  &&./configure --prefix=$P_PREFIX --with-config-file-path=$P_PREFIX/etc --with-mysql=$M_PREFIX --with-mysqli=$M_PREFIX/bin/mysql_config --with-mysql-sock=/tmp/mysql.sock --with-gd --with-iconv --with-zlib --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curlwrappers --enable-mbregex --enable-fpm --enable-mbstring --enable-ftp --enable-gd-native-ttf --with-openssl --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-pear --with-gettext --enable-session --with-mcrypt --with-curl
	if [ $? -eq 0 ];then
		make && make install
		echo -e "\033[32mphp安装成功!\033[0m"
	else
		echo -e "\033[32mphp安装失败,请检查!\033[0m"
		exit
	fi
fi
#make install nginx server
PC_FILES=pcre-8.38.tar.gz
PC_FILES_DIR=pcre-8.38
PC_URL=ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/
PC_PREFIX=/usr/local/pcre/

N_FILES=nginx-1.10.0.tar.gz
N_FILES_DIR=nginx-1.10.0
N_URL=http://nginx.org/download/
N_PREFIX=/usr/local/nginx-1.10.0/

if [[ "$1" -eq "3" ]];then
	wget -c $PC_URL/$PC_FILES &&tar zxvf $PC_FILES ;cd $PC_FILES_DIR
	if [ ! -d $PC_PREFIX];then
		echo "目录不存在,正在创建中"
		mkdir -p $PC_PREFIX
	else
		echo "目录已经存在,不需要创建!"
	fi
		./configure --prefix=$PC_PREFIX
		make && make install
#开始创建安装nginx进程
	wget -c $N_URL/$N_FILES &&tar zxvf $N_FILES ;cd $N_FILES_DIR
	if [ ! -d $N_PREFIX];then
		echo "目录不存在,正在创建!"
		mkdir -p $N_PREFIX
		echo "创建成功"
	else
		echo "目录存在,不需要创建"
		groupadd www
		useradd -g www www -s /bin/false
		./configure --prefix=$N_PREFIX --without-http_memcached_module --user=www --group=www --with-http_stub_status_module --with-openssl=/usr/ --with-pcre=/usr/local/src/$PC_FILES_DIR
		make && make install
		echo "恭喜你,nginx安装成功了!"
		echo "正在重启nginx服务器,请骚等......"
		$N_PREFIX/sbin/nginx
		$N_PREFIX/sbin/nginx -s reload
		echo "nginx启动成功"
	fi
fi

