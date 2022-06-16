#!/bin/bash
#Update system and clean repos
sudo yum clean all
sudo yum update -y

#Apache install
sudo yum install httpd -y

#Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

#Open for Apache in firewall
sudo firewall-cmd --permanent --zone=public --add-service=http --add-service=https
sudo firewall-cmd --reload

#Mariadb install
curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
sudo yum install MariaDB-server -y

#Start and enable Mariadb
sudo systemctl start mysql
sudo systemctl enable mysql

#Webmin install
sudo cat << EOF > /etc/yum.repos.d/webmin.repo
[Webmin]
name=Webmin Distribution Neutral
#baseurl=http://download.webmin.com
mirrorlist=http://download.webmin,com/download/yum/mirrorlist
enabled=1
EOF
sudo yum install wget -y
wget http://www.webmin.com/jcameron-key.asc
sudo rpm --import jcameron-key.asc
sudo yum install webmin -y

#Open for Webmin in firewall
sudo firewall-cmd --permanent --zone=public --add-port=10000/tcp
sudo firewall-cmd --reload

#Virtualmin install
sudo yum install perl -y
wget http://software.virtualmin.com/gpl/scripts/install.sh
sudo chmod +x install.sh
sudo ./install.sh --bundle LAMP -y

#Create virtualmin domain
domainname=linuxcloud.bounceme.net
sudo virtualmin create-domain --domain $domainname --pass "Kode1234!!!!" --hashpass --desc "Virtualmin server with wordpress and phpmyadmin" --unix --dir --webmin --web --dns --mail --mysql --ssl

#Run install scripts on domain for php and wordpress
sudo virtualmin install-script --domain $domainname --type phpmyadmin --version "latest" --path /phpmyadmin
sudo virtualmin install-script --domain $domainname --type wordpress --version "latest" --path / --db mysql wordpress --newdb
