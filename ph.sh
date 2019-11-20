#!/bin/bash
##
## Centos6 Installer
## By StarkTeam
##

## Set Local Time
ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime

## Preparation
clear
echo ""
echo "##"
echo "##"
echo "## Server Installer (Centos6)"
echo "## Powered by StarkTEAM"
echo "##"
echo "##"
echo ""
echo "Please choose server type"
echo "1) Premium"
echo "2) VIP"
echo "3) Private"
echo ""
read -p "> " -e type

if [  $type = "1"  ]; then
      wget -qO ~/dependencies.zip "https://www.dropbox.com/s/9iyz5eljuadxawg/premium.zip?dl=0"
elif [  $type = "2"  ]; then
      wget -qO ~/dependencies.zip "https://www.dropbox.com/s/oxpfyqf6yjzlsp8/vip.zip?dl=0"
elif [  $type = "3"  ]; then
      wget -qO ~/dependencies.zip "https://www.dropbox.com/s/8331mr0nt1ml0q8/private.zip?dl=0"
elif [  $type = ""  ]; then
      exit
fi

## Prepare Server
clear
echo ""
echo "##"
echo "##"
echo "## Server Installer (Centos6)"
echo "## Powered by StarkTEAM"
echo "##"
echo "##"
echo ""
echo "Status: Preparing Server"
echo ""
sleep 5
wget -q http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
rpm -Uvh epel-release-6-8.noarch.rpm
yum install unzip -y -q
yum update -y -q -e 0

## Download Required Files
clear
echo ""
echo "##"
echo "##"
echo "## Server Installer (Centos6)"
echo "## Powered by StarkTEAM"
echo "##"
echo "##"
echo ""
echo "Status: Downloading Required Files"
echo ""
sleep 5
unzip ~/dependencies.zip
rm dependencies.zip

## Install Applications
clear
echo ""
echo "##"
echo "##"
echo "## Server Installer (Centos6)"
echo "## Powered by StarkTEAM"
echo "##"
echo "##"
echo ""
echo "Status: Installing Applications"
echo ""
sleep 5
yum install mysql dos2unix dropbear nano squid openvpn stunnel httpd -y -q
mkdir /var/www/html/stat

## Unpacking Files
clear
echo ""
echo "##"
echo "##"
echo "## Server Installer (Centos6)"
echo "## Powered by StarkTEAM"
echo "##"
echo "##"
echo ""
echo "Status: Unpacking Files"
echo ""
sleep 5
rm /etc/sysctl.conf
mv ~/sysctl.conf /etc/
rm -rf /etc/openvpn
mv ~/openvpn /etc/
touch /var/www/html/stat/status.log.txt

## Configure Squid Proxy
clear
echo ""
echo "##"
echo "##"
echo "## Server Installer (Centos6)"
echo "## Powered by StarkTEAM"
echo "##"
echo "##"
echo ""
echo "Status: Setting up Squid Proxy"
echo ""
sleep 5
echo "http_port 8080 transparent
http_port 3128 transparent
acl inbound src all
acl outbound dst `curl ipinfo.io/ip`/32
http_access allow inbound outbound
visible_hostname `curl ipinfo.io/ip`
http_access deny all
request_header_access Allow allow all
request_header_access Authorization allow all
request_header_access WWW-Authenticate allow all
request_header_access Proxy-Authorization allow all
request_header_access Proxy-Authenticate allow all
request_header_access Cache-Control allow all
request_header_access Content-Encoding allow all
request_header_access Content-Length allow all
request_header_access Content-Type allow all
request_header_access Date allow all
request_header_access Expires allow all
request_header_access Host allow all
request_header_access If-Modified-Since allow all
request_header_access Last-Modified allow all
request_header_access Location allow all
request_header_access Pragma allow all
request_header_access Accept allow all
request_header_access Accept-Charset allow all
request_header_access Accept-Encoding allow all
request_header_access Accept-Language allow all
request_header_access Content-Language allow all
request_header_access Mime-Version allow all
request_header_access Retry-After allow all
request_header_access Title allow all
request_header_access Connection allow all
request_header_access Proxy-Connection allow all
request_header_access User-Agent allow all
request_header_access Cookie allow all
request_header_access All deny all
"| sudo tee /etc/squid/squid.conf

## Configure Firewall
clear
echo ""
echo "##"
echo "##"
echo "## Server Installer (Centos6)"
echo "## Powered by StarkTEAM"
echo "##"
echo "##"
echo ""
echo "Status: Configuring Firewall"
echo ""
sleep 5
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
service iptables save
sysctl -p

## Configure STunnel
clear
echo ""
echo "##"
echo "##"
echo "## Server Installer (Centos6)"
echo "## Powered by StarkTEAM"
echo "##"
echo "##"
echo ""
echo "Status: Installing STunnel"
echo ""
sleep 5
wget -O -q /etc/pki/tls/certs/stunnel.pem "https://raw.githubusercontent.com/shigeno143/OCSPanelCentos6/master/stunnel.pem"
wget -O -q /etc/stunnel/stunnel.pem "https://raw.githubusercontent.com/shigeno143/OCSPanelCentos6/master/stunnel.pem"
wget -O -q /etc/stunnel/stunnel.conf "https://raw.githubusercontent.com/shigeno143/OCSPanelCentos6/master/stunnel.conf"
mkdir /var/run/stunnel
chown nobody:nobody /var/run/stunnel
stunnel /etc/stunnel/stunnel.conf

## Configure Dropbear
clear
echo ""
echo "##"
echo "##"
echo "## Server Installer (Centos6)"
echo "## Powered by StarkTEAM"
echo "##"
echo "##"
echo ""
echo "Status: Installing Dropbear"
echo ""
sleep 5
echo "OPTIONS=\"-p 109 -p 110 -p 442\"" > /etc/sysconfig/dropbear
echo "/bin/false" >> /etc/shell
service dropbear restart
chkconfig dropbear on

## Replace Database Information
clear
echo ""
echo "##"
echo "##"
echo "## Server Installer (Centos6)"
echo "## Powered by StarkTEAM"
echo "##"
echo "##"
echo ""
echo "Status: Setting up Database"
echo ""
sleep 5
sed -i "s/dbhost/${DBhost}/g" /etc/openvpn/login/auth_vpn
sed -i "s/dbname/${DBname}/g" /etc/openvpn/login/auth_vpn
sed -i "s/dbuser/${DBuser}/g" /etc/openvpn/login/auth_vpn
sed -i "s/dbpass/${DBpass}/g" /etc/openvpn/login/auth_vpn

## Fix Permissions
clear
echo ""
echo "##"
echo "##"
echo "## Server Installer (Centos6)"
echo "## Powered by StarkTEAM"
echo "##"
echo "##"
echo ""
echo "Status: Fixing Permissions"
echo ""
sleep 5
chmod 777 /var/www/html/stat/status.log.txt
chmod 755 /etc/openvpn/login/auth_vpn

## Convert Script to Unix
clear
echo ""
echo "##"
echo "##"
echo "## Server Installer (Centos6)"
echo "## Powered by StarkTEAM"
echo "##"
echo "##"
echo ""
echo "Status: Converting Scripts to Unix"
echo ""
sleep 5
cd /etc/openvpn/login
dos2unix auth_vpn

## Start Service
clear
echo ""
echo "##"
echo "##"
echo "## Server Installer (Centos6)"
echo "## Powered by StarkTEAM"
echo "##"
echo "##"
echo ""
echo "Status: Starting Services"
echo ""
sleep 5
service httpd restart
service dropbear restart
service openvpn restart
service squid restart

## Done
clear
echo ""
echo "##"
echo "##"
echo "## Server Installer (Centos6)"
echo "## Powered by StarkTEAM"
echo "##"
echo "##"
echo ""
echo "Status: Success"
echo ""
read -n1 -r -p "Press any key to exit..."
