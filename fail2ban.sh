#!/bin/bash

#Install epel-release
sudo yum install -y epel-release

#Install fail2ban
sudo yum install -y fail2ban

#Start fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

#Write jail.local file

sudo cat << EOF > /etc/fail2ban/jail.local
[DEFAULT]
# Ban hosts for one hour:
bantime = 3600

# Override /etc/fail2ban/jail.d/00-firewalld.conf:
banaction = iptables-multiport

[sshd]
enabled = true
EOF

#Restart fail2ban
sudo systemctl restart fail2ban