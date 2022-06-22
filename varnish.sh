#!/bin/bash
#Install Varnish

#Add the EPEL erposiroty
sudo yum install epel-release -y

#Install the dependency packages
sudo yum install pygame yum-utils -y

#Add the Varnish Cache repository
sudo cat << EOF > /etc/yum.repos.d/varnish60lts.repo
[varnish60lts]
name=varnishcache_varnish60lts
baseurl=https://packagecloud.io/varnishcache/varnish60lts/el/7/x86_64
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/varnishcache/varnish60lts/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
EOF

#Update the yum cachce for the Varnish repo
sudo yum -q makecache -y --disablerepo='*' --enabledrepo'varnish60lts'

#Install Varnish
sudo yum install varnish -y

#Verify Varnish is installed with correct version
#sudo varnishd -V

#Enable Varnish at the system boot
sudo systemctl enable --now varnish

#Change from port 6081 to port 80
sed -i 's/ExecStart=/usr/sbin/varnishd -a :6081 -f /etc/varnish/default.vcl -s malloc,256m/ExecStart=/usr/sbin/varnishd -a :80 -f /etc/varnish/default.vcl -s malloc,256m/' /usr/lib/systemd/system/varnish.service

sudo systemctl daemon-reload
sudo systemctl restart varnish