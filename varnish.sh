#!/bin/bash

#change apache listening port to 8080 from 80
sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf

#Install Varnish
#Add the EPEL erposiroty
sudo yum install epel-release -y

#Install the dependency packages
sudo yum install pygame yum-utils -y

#Add the Varnish Cache repository
curl -s https://packagecloud.io/install/repositories/varnishcache/varnish62/script.rpm.sh | sudo bash

#Install Varnish
sudo yum install varnish -y

#Verify Varnish is installed with correct version
#sudo varnishd -V

#Enable Varnish at the system boot
sudo systemctl enable --now varnish

#Change from port 6081 to port 80
sudo sed -i 's+ExecStart=/usr/sbin/varnishd -a :6081 -f /etc/varnish/default.vcl -s malloc,256m+ExecStart=/usr/sbin/varnishd -a :80 -f /etc/varnish/default.vcl -s malloc,256m+' /usr/lib/systemd/system/varnish.service

#Restarts varnish
sudo systemctl daemon-reload
sudo systemctl restart varnish

#Restart apache
sudo systemctl restart httpd

#TESTING IKKE FINAL!!!!
#-----------------------
#Sets varnish listen port to 80 instead of 6081
#sudo sed -i 's||VARNISH_LISTEN_PORT=80|' /etc/varnish/varnish.params

#Edit Virtualmin Apache template to use port 8080
#sudo virtualmin modify-template --name "template name" | --id "template-id" [--setting name "http port" --value "8080"]+
#-----------------------