#!/bin/bash
#Update system and clean repos
sudo yum clean all
sudo yum update -y

#Install groups
yum groupinstall "GNOME Desktop" "Graphical Administration Tools"

#Set interface to graphical
systemctl set-default graphical

#reboots system
reboot