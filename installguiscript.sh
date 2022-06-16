#!/bin/bash
#Update system and clean repos
sudo yum clean all
sudo yum update -y

#Install groups for desktop enviroment and administation tools
yum groupinstall "GNOME Desktop" "Graphical Administration Tools"

#Set interface to graphical
systemctl set-default graphical.target

#reboots system
reboot
