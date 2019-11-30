#!/bin/bash

wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg|apt-key add -
sleep 2
echo "deb http://build.openvpn.net/debian/openvpn/release/2.4 stretch main" > /etc/apt/sources.list.d/openvpn-aptrepo.list
apt update
apt upgrade -y
apt install openvpn nginx php7.0-fpm stunnel4 privoxy squid3 dropbear easy-rsa vnstat ufw build-essential fail2ban zip mariadb-server -y
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";
dbhost='185.61.137.168';
dbuser='tonystar1_tonystarkvpnml';
dbpass='tonystarkvpnml';
dbname='tonystar1_tonystark-vpn.ml';
cd /root
wget "https://github.com/rafaelitel/starktony/raw/master/plugin.tgz"
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime
cd
wget "https://github.com/rafaelitel/starktony/raw/master/webmin_1.920_all.deb"
dpkg --install webmin_1.920_all.deb;
apt-get -y -f install;
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
rm /root/webmin_1.920_all.deb
service webmin restart
cd
wget -O /usr/bin/screenfetch "https://raw.githubusercontent.com/rafaelitel/starktony/master/Plugins/screenfetch"
chmod +x /usr/bin/screenfetch
echo "clear" >> .profile
echo "screenfetch" >> .profile
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbearadmin
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=442/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
cat > /etc/privoxy/config <<-END
user-manual /usr/share/doc/privoxy/user-manual
confdir /etc/privoxy
logdir /var/log/privoxy
filterfile default.filter
logfile logfile
listen-address  0.0.0.0:3356
listen-address  0.0.0.0:8086
toggle  1
enable-remote-toggle  0
enable-remote-http-toggle  0
enable-edit-actions 0
enforce-blocks 0
buffer-limit 4096
enable-proxy-authentication-forwarding 1
forwarded-connect-retries  1
accept-intercepted-requests 1
allow-cgi-request-crunching 1
split-large-forms 0
keep-alive-timeout 5
tolerate-pipelining 1
socket-timeout 300
permit-access 0.0.0.0/0 xxxxxxxxx
END
sed -i $MYIP2 /etc/privoxy/config;
wget -O /etc/squid/ads.txt https://raw.githubusercontent.com/tsunaweak/gcloud/master/ads.txt
wget -O /etc/squid/malware.txt https://raw.githubusercontent.com/tsunaweak/gcloud/master/malware.txt
cat > /etc/squid/squid.conf <<-END
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl localnet src 10.0.0.0/8
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16
acl localnet src fc00::/7
acl localnet src fe80::/10
acl ads url_regex -i "/etc/squid/ads.txt"
acl malware url_regex -i "/etc/squid/malware.txt"
http_access deny ads
http_access deny malware
acl SSL_ports port 80-8085
acl Safe_ports port 110
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 444
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst xxxxxxxxx-xxxxxxxxx/32
acl SSH dst 103.103.0.118-103.103.0.118/32
http_access allow SSH
http_access allow localnet
http_access allow manager localhost
http_access deny manager
http_access allow localhost
http_access deny all
http_port 8085
http_port 3355
coredump_dir /var/spool/squid3
refresh_pattern ^ftp: 1440 20% 10080
refresh_pattern ^gopher: 1440 0% 1440
refresh_pattern -i (/cgi-bin/|\?) 0 0% 0
refresh_pattern . 0 20% 4320
visible_hostname StarkTony
END
sed -i $MYIP2 /etc/squid/squid.conf;
cat > /etc/squid/ads.txt <<-END
END
cat > /etc/squid/ads.txt <<-END
END
rm /etc/issue.net
wget -O /etc/issue.net "https://raw.githubusercontent.com/rafaelitel/starktony/master/Files/Others/issue.net"
sed -i 's@#Banner@Banner@g' /etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear
service ssh restart
service dropbear restart
wget -O /usr/bin/badvpn-udpgw "https://github.com/rafaelitel/starktony/raw/master/badvpn-udpgw"
if [ "$OS" == "x86_64" ]; then
wget -O /usr/bin/badvpn-udpgw "https://github.com/rafaelitel/starktony/raw/master/badvpn-udpgw"
fi
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300
cat << EOF > /etc/openvpn/ca.crt
-----BEGIN CERTIFICATE-----
MIIE5TCCA82gAwIBAgIJAP0GLynOqm38MA0GCSqGSIb3DQEBCwUAMIGnMQswCQYD
VQQGEwJQSDERMA8GA1UECBMIQmF0YW5nYXMxETAPBgNVBAcTCEJhdGFuZ2FzMRIw
EAYDVQQKEwlTYXZhZ2VWUE4xEjAQBgNVBAsTCVNhdmFnZVZQTjEWMBQGA1UEAxMN
c2F2YWdlLXZwbi50azEPMA0GA1UEKRMGc2VydmVyMSEwHwYJKoZIhvcNAQkBFhJz
YXZhZ2U5OUBnbWFpbC5jb20wHhcNMTgwNDIwMDQ1MTMyWhcNMjgwNDE3MDQ1MTMy
WjCBpzELMAkGA1UEBhMCUEgxETAPBgNVBAgTCEJhdGFuZ2FzMREwDwYDVQQHEwhC
YXRhbmdhczESMBAGA1UEChMJU2F2YWdlVlBOMRIwEAYDVQQLEwlTYXZhZ2VWUE4x
FjAUBgNVBAMTDXNhdmFnZS12cG4udGsxDzANBgNVBCkTBnNlcnZlcjEhMB8GCSqG
SIb3DQEJARYSc2F2YWdlOTlAZ21haWwuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAwMNjUVNKJvcMBAx5k/doMtYwVhoSV2gnxA16rtZMnkckHRQc
ApvgSWOBc0e2OgL+rlb48BrheyQ9aSLiHrfGPvzpVQfpGCwSQxayEiNKdRmlb6wl
IIlnhfXyKYXx9x/fZNQWGmhczckrXl84ZYbLKglmnfXSEM0PUlfj7pujjXSsZTPV
2Pe92+sf/2ZyYotA2XXqnXIPjaPUo/kQYqmLTSY7weaYLisxn9TTJo6V0Qap2poY
FLpH7fjWCTun7jZ5CiWVIVARkZRXmurLlu+Z+TMlPK3DW9ASXA2gw8rctsoyLJym
V+6hkZiJ3k0X17SNIDibDG4vn8VFEFehOrqKXQIDAQABo4IBEDCCAQwwHQYDVR0O
BBYEFDC3ZJF7tPbQ9SUDMm6P0hxXmvNIMIHcBgNVHSMEgdQwgdGAFDC3ZJF7tPbQ
9SUDMm6P0hxXmvNIoYGtpIGqMIGnMQswCQYDVQQGEwJQSDERMA8GA1UECBMIQmF0
YW5nYXMxETAPBgNVBAcTCEJhdGFuZ2FzMRIwEAYDVQQKEwlTYXZhZ2VWUE4xEjAQ
BgNVBAsTCVNhdmFnZVZQTjEWMBQGA1UEAxMNc2F2YWdlLXZwbi50azEPMA0GA1UE
KRMGc2VydmVyMSEwHwYJKoZIhvcNAQkBFhJzYXZhZ2U5OUBnbWFpbC5jb22CCQD9
Bi8pzqpt/DAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQCdv9MOSR8O
b9wRw4qd681eTxUYEACFVZpY3eK3vJYyGtblYHIwfCPTWL6yXQxbMud4C1ISIwel
UFv/qnz/GZmAkN0qB5tNSvB48123F1AWfhhXWG+o+xWxUi+eqsXdUVZ1tpP5WQaH
EUtU6SZ1AXO6l6b/RTXymRrEInCPfbGsEnucnG7naOpBaNRXmpiMppOwzR42sd6I
QOvXkj2e8v9tQ05cffjexks+rfb/d80+1nfkv0HCLWxcdU8yOUqVryhdZLB6Rhw/
crldSHwrGWN+qptpFD160iJLIv3p5vWwUAgRoRai9iHuJMOHn4aDX0N8tbCfS+R5
qn8GWiHaXEu8
-----END CERTIFICATE-----
EOF
cat << EOF > /etc/openvpn/server.crt
Certificate:
Data:
Version: 3 (0x2)
Serial Number: 1 (0x1)
Signature Algorithm: sha256WithRSAEncryption
Issuer: C=PH, ST=Batangas, L=Batangas, O=SavageVPN, OU=SavageVPN, CN=savage-vpn.tk/name=server/emailAddress=savage99@gmail.com
Validity
Not Before: Apr 20 04:53:44 2018 GMT
Not After : Apr 17 04:53:44 2028 GMT
Subject: C=PH, ST=Batangas, L=Batangas, O=SavageVPN, OU=SavageVPN, CN=savage-vpn.tk/name=server/emailAddress=savage99@gmail.com
Subject Public Key Info:
Public Key Algorithm: rsaEncryption
Public-Key: (2048 bit)
Modulus:
00:b6:a9:b9:e6:f9:19:85:24:ba:6b:dc:7e:b2:d4:
2c:01:46:26:fa:3e:41:ee:0c:b9:18:27:99:34:27:
61:eb:4f:cb:83:c0:0b:43:27:05:53:a5:b9:3c:5a:
8a:c5:7e:2e:72:1d:f9:83:97:44:b5:00:21:36:d7:
51:27:be:b7:d0:0c:2c:09:38:52:a0:e0:89:6f:cb:
0e:11:37:d9:7c:43:fe:b1:25:c1:2f:78:25:c1:a0:
15:c9:1d:35:b6:1d:33:e9:e6:75:83:4b:30:54:a4:
4e:f5:01:ae:fc:0c:37:c0:c7:07:43:4c:04:50:80:
c8:13:9a:27:4c:d1:6d:c6:87:e4:38:38:67:c1:87:
e4:3a:e3:79:11:c1:23:d4:2c:72:b7:0c:60:72:c7:
29:7e:36:17:09:2d:ca:9d:b3:49:2f:2f:56:85:a9:
24:34:5a:e7:eb:4b:ee:cf:43:bb:20:ef:dc:26:95:
e6:dd:3a:8a:61:d8:33:b0:28:0f:fb:ce:d9:db:dd:
ca:2f:85:f0:ec:66:58:67:77:8e:e0:a0:21:f8:b5:
fe:e3:02:7e:3c:9c:5c:91:65:1a:bc:3c:6f:ce:3d:
b8:38:8e:b0:d4:5b:ef:a5:e1:b3:0c:f4:bf:49:95:
7b:1f:9f:41:9f:ce:fa:ae:e1:e7:68:f4:f9:a6:99:
74:95
Exponent: 65537 (0x10001)
X509v3 extensions:
X509v3 Basic Constraints:
CA:FALSE
Netscape Cert Type:
SSL Server
Netscape Comment:
Easy-RSA Generated Server Certificate
X509v3 Subject Key Identifier:
0C:4B:B3:78:75:C7:5E:C8:16:D2:A7:BC:8E:15:3F:33:E3:58:19:04
X509v3 Authority Key Identifier:
keyid:30:B7:64:91:7B:B4:F6:D0:F5:25:03:32:6E:8F:D2:1C:57:9A:F3:48
DirName:/C=PH/ST=Batangas/L=Batangas/O=SavageVPN/OU=SavageVPN/CN=savage-vpn.tk/name=server/emailAddress=savage99@gmail.com
serial:FD:06:2F:29:CE:AA:6D:FC
X509v3 Extended Key Usage:
TLS Web Server Authentication
X509v3 Key Usage:
Digital Signature, Key Encipherment
X509v3 Subject Alternative Name:
DNS:server
Signature Algorithm: sha256WithRSAEncryption
95:13:80:8a:95:42:9e:16:b6:58:5f:4a:d2:74:61:fb:25:04:
3c:77:fa:09:41:05:e3:9b:df:93:4e:65:8e:b8:05:87:35:c0:
9a:eb:62:fa:16:0d:15:28:79:b7:7f:8c:55:72:7a:31:16:3f:
ff:ba:29:70:0c:96:78:6e:1e:a9:ff:42:d7:f2:53:43:e6:f3:
a4:3a:02:7b:85:18:18:bc:b6:56:47:3b:be:ae:6f:1c:93:8b:
13:55:0d:b1:51:30:c2:f4:03:c9:a9:cf:bb:ad:60:70:ec:32:
1e:e5:74:d5:4d:2b:5e:02:73:28:b0:84:28:f4:6c:93:45:a1:
f8:3c:58:91:38:21:7b:b2:8f:fe:26:4c:18:72:a3:13:79:46:
b8:43:8c:cc:5c:03:7c:20:8a:51:25:8b:d0:80:a8:ae:33:5c:
19:20:f6:a9:02:39:47:42:1d:37:c6:ec:9f:6e:80:5b:61:0b:
53:bf:26:4b:6d:b5:a6:98:21:e0:ad:42:3a:7d:3f:c9:00:a3:
61:4c:76:e0:45:36:0b:7e:71:38:37:4f:73:a9:6f:bf:7a:77:
04:8d:27:cb:e3:d4:11:f4:c3:c5:85:c2:1d:8a:9f:3b:da:43:
97:8d:f3:3e:30:51:b4:ad:2b:65:04:58:f3:95:7f:23:b2:3a:
f8:bd:7c:f8
-----BEGIN CERTIFICATE-----
MIIFWDCCBECgAwIBAgIBATANBgkqhkiG9w0BAQsFADCBpzELMAkGA1UEBhMCUEgx
ETAPBgNVBAgTCEJhdGFuZ2FzMREwDwYDVQQHEwhCYXRhbmdhczESMBAGA1UEChMJ
U2F2YWdlVlBOMRIwEAYDVQQLEwlTYXZhZ2VWUE4xFjAUBgNVBAMTDXNhdmFnZS12
cG4udGsxDzANBgNVBCkTBnNlcnZlcjEhMB8GCSqGSIb3DQEJARYSc2F2YWdlOTlA
Z21haWwuY29tMB4XDTE4MDQyMDA0NTM0NFoXDTI4MDQxNzA0NTM0NFowgacxCzAJ
BgNVBAYTAlBIMREwDwYDVQQIEwhCYXRhbmdhczERMA8GA1UEBxMIQmF0YW5nYXMx
EjAQBgNVBAoTCVNhdmFnZVZQTjESMBAGA1UECxMJU2F2YWdlVlBOMRYwFAYDVQQD
Ew1zYXZhZ2UtdnBuLnRrMQ8wDQYDVQQpEwZzZXJ2ZXIxITAfBgkqhkiG9w0BCQEW
EnNhdmFnZTk5QGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALapueb5GYUkumvcfrLULAFGJvo+Qe4MuRgnmTQnYetPy4PAC0MnBVOluTxa
isV+LnId+YOXRLUAITbXUSe+t9AMLAk4UqDgiW/LDhE32XxD/rElwS94JcGgFckd
NbYdM+nmdYNLMFSkTvUBrvwMN8DHB0NMBFCAyBOaJ0zRbcaH5Dg4Z8GH5DrjeRHB
I9QscrcMYHLHKX42Fwktyp2zSS8vVoWpJDRa5+tL7s9DuyDv3CaV5t06imHYM7Ao
D/vO2dvdyi+F8OxmWGd3juCgIfi1/uMCfjycXJFlGrw8b849uDiOsNRb76Xhswz0
v0mVex+fQZ/O+q7h52j0+aaZdJUCAwEAAaOCAYswggGHMAkGA1UdEwQCMAAwEQYJ
YIZIAYb4QgEBBAQDAgZAMDQGCWCGSAGG+EIBDQQnFiVFYXN5LVJTQSBHZW5lcmF0
ZWQgU2VydmVyIENlcnRpZmljYXRlMB0GA1UdDgQWBBQMS7N4dcdeyBbSp7yOFT8z
41gZBDCB3AYDVR0jBIHUMIHRgBQwt2SRe7T20PUlAzJuj9IcV5rzSKGBraSBqjCB
pzELMAkGA1UEBhMCUEgxETAPBgNVBAgTCEJhdGFuZ2FzMREwDwYDVQQHEwhCYXRh
bmdhczESMBAGA1UEChMJU2F2YWdlVlBOMRIwEAYDVQQLEwlTYXZhZ2VWUE4xFjAU
BgNVBAMTDXNhdmFnZS12cG4udGsxDzANBgNVBCkTBnNlcnZlcjEhMB8GCSqGSIb3
DQEJARYSc2F2YWdlOTlAZ21haWwuY29tggkA/QYvKc6qbfwwEwYDVR0lBAwwCgYI
KwYBBQUHAwEwCwYDVR0PBAQDAgWgMBEGA1UdEQQKMAiCBnNlcnZlcjANBgkqhkiG
9w0BAQsFAAOCAQEAlROAipVCnha2WF9K0nRh+yUEPHf6CUEF45vfk05ljrgFhzXA
muti+hYNFSh5t3+MVXJ6MRY//7opcAyWeG4eqf9C1/JTQ+bzpDoCe4UYGLy2Vkc7
vq5vHJOLE1UNsVEwwvQDyanPu61gcOwyHuV01U0rXgJzKLCEKPRsk0Wh+DxYkTgh
e7KP/iZMGHKjE3lGuEOMzFwDfCCKUSWL0ICorjNcGSD2qQI5R0IdN8bsn26AW2EL
U78mS221ppgh4K1COn0/yQCjYUx24EU2C35xODdPc6lvv3p3BI0ny+PUEfTDxYXC
HYqfO9pDl43zPjBRtK0rZQRY85V/I7I6+L18+A==
-----END CERTIFICATE-----
EOF
cat << EOF > /etc/openvpn/server.key
-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC2qbnm+RmFJLpr
3H6y1CwBRib6PkHuDLkYJ5k0J2HrT8uDwAtDJwVTpbk8WorFfi5yHfmDl0S1ACE2
11EnvrfQDCwJOFKg4Ilvyw4RN9l8Q/6xJcEveCXBoBXJHTW2HTPp5nWDSzBUpE71
Aa78DDfAxwdDTARQgMgTmidM0W3Gh+Q4OGfBh+Q643kRwSPULHK3DGByxyl+NhcJ
Lcqds0kvL1aFqSQ0WufrS+7PQ7sg79wmlebdOoph2DOwKA/7ztnb3covhfDsZlhn
d47goCH4tf7jAn48nFyRZRq8PG/OPbg4jrDUW++l4bMM9L9JlXsfn0Gfzvqu4edo
9PmmmXSVAgMBAAECggEAOwhHKDpA4SKpjMpJuAmR3yeI2T7dl81M1F2XyZ8gqiez
ofSiryUhN5NLdhHc306UPBUr2jc84TIVid+0PqAIT5hfcutc6NkoEZUSCsZ95wci
fKWy9WBi81yFLeXewehWKrVsLO5TxEcFrXDJ2HMqYYbw9fLPQiUchBlBsjXMwGgG
W8R2WlQaIh0siJzg+FjwOPEbZA7jAJfyGt80HDWVOfsHxsSX80m8rq2nMppXsngF
hhosj/f/WOPJLiA+/Odkv1ZXS1rqnr5GuwdzrEnibqXOx9LCuxp9MZ8t6qWDvgUf
dy1AB2DKRi9s4NCJHPpITXek4ELawLmGxp7KEzQ/0QKBgQDoU16ZGTCVCT/kQlRz
DRZ2fFXNEvEohCTxYJ72iT6MGxZw+2fuZG6VL9fAgUVLleKKUCFUzM3GPQWEQ1ry
VKQjIqQZjyR+rzdqbHOcG4qYz93enH0FIB9cW/FiU3m5EAzU+TkagZCFq254Kb7i
IQzrWTn24jFX1fQkgcNoXbNUMwKBgQDJRtEs/4e/enVs/6iGjjTGltjyXPS3QM/k
ylZGL+Wc1gQWAsfTO6tYMMPVupyyl2JQjhUydIu3g7D2R4IRKlpprEd8S0MoJou9
Lp/JudlDDJs9Q6Z2q99JpbXdhJ2aOTmSgOKHnkFQRRP/LOxaNwuE/xuhYWubvtFW
y9u+B8uMFwKBgQCJuZqTweYWA+S3aUbs6W5OkUjACKGj9ip8WV4DIrtMjWZRVgh3
v1v63uDVAw1UUKd6fSQ1RDAce+JAVTmd/OVM2uVTLZNh8nc0hNRIT99q1Zdet4A5
wKA2vV6sfnXjaotg2dmrR/Gn/EfBvmWlYhhpkHyXSeIcgv53geGYhiugFwKBgQC3
pRmtyOh+2KjTbuDBBHc6yt/fItlVaplE0yismX8S/mJ0As13+fV4XeYQ2Feoy180
yK6mfpgMNOf9jXkrWE1uJXaD/dekhqbxUd0RHbUR7CqoV1VG6cKtW7j4CMwTryrM
dTQ7MTW+m4iHRuHP3nFwQ6NeN5kLXat7Wj2AwXQCuQKBgESdvXETE6Oy3GVeO1zd
tDlYxpA620daYaNo9MDpV49m89Lt8Maou080+gEJDrqqhyiaEQStrvz31mXIA+w7
YTX1gKAF4qCXy3IKLqN3umdpEYkV2MVEfXlUE6aZZMogta9F5cne3CNDyHzq/RvS
l9rNm+ntgV3+QioNbRWhG9fb
-----END PRIVATE KEY-----
EOF
cat << EOF > /etc/openvpn/dh1024.pem
-----BEGIN DH PARAMETERS-----
MIIBCAKCAQEAohzwXz9fsjw+G9Q14qINNOhZnTt/b30zzJYm4o2NIzAngM6E6GPm
N5USUt0grZw6h3VP9LyqQoGi/bHFz33YFG5lgDF8FAASEh07/leF7s0ohhK8pspC
JVD+mRatwBrIImXUpJvYI2pXKxtCOnDa2FFjAOHKixiAXqVcmJRwNaSklQcrpXdn
/09cr0rbFoovn+f1agly4FxYYs7P0XkvSHm3gVW/mhAUr1hvZlbBaWFSVUdgcVOi
FXQ/AVkvxYaO8pFI2Vh+CNMk7Vvi8d3DTayvoL2HTgFi+OIEbiiE/Nzryu+jDGc7
79FkBHWOa/7eD2nFrHScUJcwWiSevPQjQwIBAg==
-----END DH PARAMETERS-----
EOF

TYPE=""
echo -e "Type of your Server$RESET"
PS3='Choose or Type a Plan: '
options=("Premium" "VIP" "PRIVATE" "Quit")
select opt in "${options[@]}"; do
case "$opt,$REPLY" in
Premium,*|*,Premium)
echo "";
/bin/cat <<"EOM" >/etc/openvpn/login.sh
HOST='$dbhost'
USER='$dbuser'
PASS='$dbpass'
DB='$dbname'
PORT='3306'
PRE="users.user_name='$username' AND users.auth_vpn=md5('$password') AND users.is_validated=1 AND users.is_freeze=0 AND users.is_active=1 AND users.is_ban=0 AND users.duration > 0"
VIP="users.user_name='$username' AND users.auth_vpn=md5('$password') AND users.is_validated=1 AND users.is_freeze=0 AND users.is_active=1 AND users.is_ban=0 AND users.vip_duration > 0"
PRIV="users.user_name='$username' AND users.auth_vpn=md5('$password') AND users.is_validated=1 AND users.is_freeze=0 AND users.is_active=1 AND users.is_ban=0 AND users.private_duration > 0"
Query="SELECT users.user_name FROM users WHERE $PRE OR $VIP OR $PRIV"
user_name=`mysql -u $USER -p$PASS -D $DB -h $HOST --skip-column-name -e "$Query"`
[ "$user_name" != '' ] && [ "$user_name" = "$username" ] && echo "user : $username" && echo 'authentication ok.' && exit 0 || echo 'authentication failed.'; exit 1
EOM
echo "";
echo -e " 1) Premium Selected";
break ;;
VIP,*|*,VIP)
echo "";
/bin/cat <<"EOM" >/etc/openvpn/login.sh
HOST='$dbhost'
USER='$dbuser'
PASS='$dbpass'
DB='$dbname'
PORT='3306'
VIP="users.user_name='$username' AND users.auth_vpn=md5('$password') AND users.is_validated=1 AND users.is_freeze=0 AND users.is_active=1 AND users.is_ban=0 AND users.vip_duration > 0"
PRIV="users.user_name='$username' AND users.auth_vpn=md5('$password') AND users.is_validated=1 AND users.is_freeze=0 AND users.is_active=1 AND users.is_ban=0 AND users.private_duration > 0"
Query="SELECT users.user_name FROM users WHERE $VIP OR $PRIV"
user_name=`mysql -u $USER -p$PASS -D $DB -h $HOST --skip-column-name -e "$Query"`
[ "$user_name" != '' ] && [ "$user_name" = "$username" ] && echo "user : $username" && echo 'authentication ok.' && exit 0 || echo 'authentication failed.'; exit 1
EOM
echo "";
echo -e " 2) VIP Selected";
break ;;
PRIVATE,*|*,PRIVATE)
echo "";
/bin/cat <<"EOM" >/etc/openvpn/login.sh
HOST='$dbhost'
USER='$dbuser'
PASS='$dbpass'
DB='$dbname'
PORT='3306'
PRIVATE="users.user_name='$username' AND users.auth_vpn=md5('$password') AND users.is_validated=1 AND users.is_freeze=0 AND users.is_active=1 AND users.is_ban=0 AND users.private_duration>0"
Query="SELECT users.user_name FROM users WHERE $PRIVATE"
user_name=`mysql -u $USER -p$PASS -D $DB -h $HOST --skip-column-name -e "$Query"`
[ "$user_name" != '' ] && [ "$user_name" = "$username" ] && echo "user : $username" && echo 'authentication ok.' && exit 0 || echo 'authentication failed.'; exit 1
EOM
echo "";
echo -e " 3) PRIVATE Selected";
break ;;
Quit,*|*,Quit) echo -e "Installation Cancelled!";
echo -e " Rebuild your vps and correct the process.";
exit;
break ;; *)
echo -e " Invalid: Just choose what you want";
esac
done
tar -xzvf /root/plugin.tgz -C /usr/lib/openvpn/
chmod +x /usr/lib/openvpn/*
cat > /etc/openvpn/server.conf <<-END
port 110
proto tcp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh1024.pem
verify-client-cert none
username-as-common-name
key-direction 0
script-security 3
auth-user-pass-verify /etc/openvpn/login.sh via-env
server 192.168.10.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "route-method exe"
push "route-delay 2"
keepalive 10 120
comp-lzo
user nobody
group nogroup
persist-key
persist-tun
status openvpn-status.log
log openvpn.log
verb 3
ncp-disable
cipher none
auth none
END
systemctl start openvpn@server
mkdir -p /home/vps/public_html
cat > /home/vps/public_html/sun-tuctc.ovpn <<-END
auth-user-pass
client
dev tun
proto tcp-client
remote $MYIP 110
nobind
persist-key
persist-tun
comp-lzo
keepalive 10 120
tls-client
remote-cert-tls server
verb 3
auth-user-pass
cipher none
auth none
auth-nocache
auth-retry interact
connect-retry 0 1
nice -20
reneg-sec 0
redirect-gateway def1
dhcp-option DNS 1.1.1.1
dhcp-option DNS 1.0.0.1
http-proxy $MYIP 3356
http-proxy-option CUSTOM-HEADER ""
http-proxy-option CUSTOM-HEADER "POST https://viber.com HTTP/1.0"
END
echo '<ca>' >> /home/vps/public_html/sun-tuctc.ovpn
cat /etc/openvpn/ca.crt >> /home/vps/public_html/sun-tuctc.ovpn
echo '</ca>' >> /home/vps/public_html/sun-tuctc.ovpn
cat > /home/vps/public_html/noload.ovpn <<-END
auth-user-pass
client
dev tun
proto tcp-client
remote $MYIP 110
persist-key
persist-tun
comp-lzo
bind
float
remote-cert-tls server
verb 3
auth-user-pass
redirect-gateway def1
cipher none
auth none
auth-nocache
auth-retry interact
connect-retry 0 1
nice -20
reneg-sec 0
dhcp-option DNS 1.1.1.1
dhcp-option DNS 1.0.0.1
END
echo '<ca>' >> /home/vps/public_html/noload.ovpn
cat /etc/openvpn/ca.crt >> /home/vps/public_html/noload.ovpn
echo '</ca>' >> /home/vps/public_html/noload.ovpn
cat > /home/vps/public_html/fixplan.ovpn <<-END
auth-user-pass
client
dev tun
proto tcp-client
remote $MYIP 110
nobind
persist-key
persist-tun
comp-lzo
keepalive 10 120
tls-client
remote-cert-tls server
verb 3
auth-user-pass
cipher none
auth none
auth-nocache
auth-retry interact
connect-retry 0 1
nice -20
reneg-sec 0
redirect-gateway def1
dhcp-option DNS 1.1.1.1
dhcp-option DNS 1.0.0.1
http-proxy $MYIP 3356
http-proxy-option CUSTOM-HEADER ""
http-proxy-option CUSTOM-HEADER "POST https://viber.com HTTP/1.1"
http-proxy-option CUSTOM-HEADER "Proxy-Connection: Keep-Alive"
END
echo '<ca>' >> /home/vps/public_html/fixplan.ovpn
cat /etc/openvpn/ca.crt >> /home/vps/public_html/fixplan.ovpn
echo '</ca>' >> /home/vps/public_html/fixplan.ovpn
cat > /home/vps/public_html/default.ovpn <<-END
auth-user-pass
client
dev tun
proto tcp-client
remote $MYIP 110
nobind
persist-key
persist-tun
comp-lzo
keepalive 10 120
tls-client
remote-cert-tls server
verb 3
auth-user-pass
cipher none
auth none
auth-nocache
auth-retry interact
connect-retry 0 1
reneg-sec 0
redirect-gateway def1
dhcp-option DNS 1.1.1.1
dhcp-option DNS 1.0.0.1
END
echo '<ca>' >> /home/vps/public_html/default.ovpn
cat /etc/openvpn/ca.crt >> /home/vps/public_html/default.ovpn
echo '</ca>' >> /home/vps/public_html/default.ovpn
cat > /home/vps/public_html/tu200.ovpn <<-END
auth-user-pass
client
dev tun
proto tcp-client
remote $MYIP 110
nobind
persist-key
persist-tun
comp-lzo
keepalive 10 120
tls-client
remote-cert-tls server
verb 3
auth-user-pass
cipher none
auth none
auth-nocache
auth-retry interact
connect-retry 0 1
nice -20
reneg-sec 0
redirect-gateway def1
dhcp-option DNS 1.1.1.1
dhcp-option DNS 1.0.0.1
http-proxy $MYIP 3355
http-proxy-option CUSTOM-HEADER CONNECT HTTP/1.0
http-proxy-option CUSTOM-HEADER Host line.telegram.me
http-proxy-option CUSTOM-HEADER X-Online-Host line.telegram.me
http-proxy-option CUSTOM-HEADER X-Forward-Host line.telegram.me
http-proxy-option CUSTOM-HEADER Connection Keep-Alive
END
echo '<ca>' >> /home/vps/public_html/tu200.ovpn
cat /etc/openvpn/ca.crt >> /home/vps/public_html/tu200.ovpn
echo '</ca>' >> /home/vps/public_html/tu200.ovpn
cat > /home/vps/public_html/gtmfbig.ovpn <<-END
auth-user-pass
client
dev tun
proto tcp-client
remote $MYIP 110
nobind
persist-key
persist-tun
comp-lzo
keepalive 10 120
tls-client
remote-cert-tls server
verb 3
auth-user-pass
cipher none
auth none
auth-nocache
auth-retry interact
connect-retry 0 1
nice -20
reneg-sec 0
redirect-gateway def1
dhcp-option DNS 1.1.1.1
dhcp-option DNS 1.0.0.1
http-proxy $MYIP 3356
http-proxy-option CUSTOM-HEADER ""
http-proxy-option CUSTOM-HEADER "PUT https://s3.amazonaws.com HTTP/1.1"
http-proxy-option CUSTOM-HEADER Host s3.amazonaws.com
http-proxy-option CUSTOM-HEADER Connection Keep-Alive
http-proxy-option CUSTOM-HEADER Upgrade-Insecure-Requests: 1
END
echo '<ca>' >> /home/vps/public_html/gtmfbig.ovpn
cat /etc/openvpn/ca.crt >> /home/vps/public_html/gtmfbig.ovpn
echo '</ca>' >> /home/vps/public_html/gtmfbig.ovpn
cat > /home/vps/public_html/sunfreeyt.ovpn <<-END
auth-user-pass
client
dev tun
proto tcp
remote $MYIP 110
nobind
persist-key
persist-tun
comp-lzo
keepalive 10 120
tls-client
remote-cert-tls server
verb 3
auth-user-pass
cipher none
auth none
auth-nocache
auth-retry interact
connect-retry 0 1
nice -20
reneg-sec 0
redirect-gateway def1
dhcp-option DNS 1.1.1.1
dhcp-option DNS 1.0.0.1
http-proxy $MYIP 8085
http-proxy-option CUSTOM-HEADER CONNECT HTTP/1.0
http-proxy-option CUSTOM-HEADER Host data.iflix.com
http-proxy-option CUSTOM-HEADER X-Online-Host data.iflix.com
http-proxy-option CUSTOM-HEADER X-Forward-Host data.iflix.com
http-proxy-option CUSTOM-HEADER Connection Keep-Alive
END
echo '<ca>' >> /home/vps/public_html/sunfreeyt.ovpn
cat /etc/openvpn/ca.crt >> /home/vps/public_html/sunfreeyt.ovpn
echo '</ca>' >> /home/vps/public_html/sunfreeyt.ovpn
cat > /home/vps/public_html/OpenVPN-SSL.ovpn <<-END
auth-user-pass
client
dev tun
proto tcp
remote 127.0.0.1 110
route $MYIP 255.255.255.255 net_gateway
nobind
persist-key
persist-tun
comp-lzo
keepalive 10 120
tls-client
remote-cert-tls server
verb 3
auth-user-pass
cipher none
auth none
auth-nocache
auth-retry interact
connect-retry 0 1
nice -20
reneg-sec 0
redirect-gateway def1
dhcp-option DNS 1.1.1.1
dhcp-option DNS 1.0.0.1
END
echo '<ca>' >> /home/vps/public_html/OpenVPN-SSL.ovpn
cat /etc/openvpn/ca.crt >> /home/vps/public_html/OpenVPN-SSL.ovpn
echo '</ca>' >> /home/vps/public_html/OpenVPN-SSL.ovpn
cat > /home/vps/public_html/JFTV-WG.conf <<-END
[Interface]
PrivateKey = mP0EfgBeD0vcbx91bNamvsZF8EZkBIasYE3FvuJUw2I=
DNS = 9.9.9.9, 149.112.112.112
Address = 172.16.0.2
[Peer]
PublicKey = bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=
AllowedIPs = 0.0.0.0/0
AllowedIPs = ::/0
Endpoint = engage.tonystark-vpn.ml:2408
END
echo '<ca>' >> /home/vps/public_html/JFTV-WG.conf
cat /etc/openvpn/ca.crt >> /home/vps/public_html/JFTV-WG.conf
echo '</ca>' >> /home/vps/public_html/JFTV-WG.conf
cat > /home/vps/public_html/stunnel.conf <<-END
client = yes
debug = 6
[openvpn]
accept = 127.0.0.1:110
connect = $MYIP:587
TIMEOUTclose = 0
verify = 0
sni = www.viber.com.edgekey.net
END
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 -sha256 -subj '/CN=127.0.0.1/O=localhost/C=PH' -keyout /etc/stunnel/stunnel.pem -out /etc/stunnel/stunnel.pem
cat > /etc/stunnel/stunnel.conf <<-END
sslVersion = all
pid = /stunnel.pid
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1
client = no
[openvpn]
accept = 587
connect = 127.0.0.1:110
cert = /etc/stunnel/stunnel.pem
[dropbear]
accept = 444
connect = 127.0.0.1:442
cert = /etc/stunnel/stunnel.pem
END
ufw allow ssh
ufw allow 110/tcp
sed -i 's|DEFAULT_INPUT_POLICY="DROP"|DEFAULT_INPUT_POLICY="ACCEPT"|' /etc/default/ufw
sed -i 's|DEFAULT_FORWARD_POLICY="DROP"|DEFAULT_FORWARD_POLICY="ACCEPT"|' /etc/default/ufw
echo 1 > /proc/sys/net/ipv4/ip_forward
sed -i 's|#net.ipv4.ip_forward=1|net.ipv4.ip_forward=1|' /etc/sysctl.conf
cat > /etc/iptables.up.rules <<-END
*nat
:PREROUTING ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]
-A POSTROUTING -j SNAT --to-source xxxxxxxxx
-A POSTROUTING -o eth0 -j MASQUERADE
-A POSTROUTING -s 192.168.10.0/24 -o eth0 -j MASQUERADE
COMMIT
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:fail2ban-ssh - [0:0]
-A INPUT -p tcp -m multiport --dports 22 -j fail2ban-ssh
-A INPUT -p ICMP --icmp-type 8 -j ACCEPT
-A INPUT -i eth0 -p tcp -m tcp --dport 110 -j ACCEPT
-A INPUT -i tun0 -j ACCEPT
-A INPUT -p tcp --dport 22  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 80  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 143  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 442  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 443  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 444  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 587  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 110  -m state --state NEW -j ACCEPT
-A INPUT -p udp --dport 110  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 3355  -m state --state NEW -j ACCEPT
-A INPUT -p udp --dport 3355  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 8085  -m state --state NEW -j ACCEPT
-A INPUT -p udp --dport 8085  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 3356  -m state --state NEW -j ACCEPT
-A INPUT -p udp --dport 3356  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 8086  -m state --state NEW -j ACCEPT
-A INPUT -p udp --dport 8086  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 10000  -m state --state NEW -j ACCEPT
-A fail2ban-ssh -j RETURN
-A OUTPUT -p icmp --icmp-type echo-request -j DROP
-A INPUT -p tcp --tcp-flags ALL NONE -j DROP
-A INPUT -p tcp --tcp-flags ALL ALL -j DROP
-A INPUT -f -j DROP
-A INPUT -p tcp ! --syn -m state --state NEW -j DROP
-A INPUT -m string --string "BitTorrent" --algo bm --to 65535 -j DROP
-A INPUT -m string --string "BitTorrent protocol" --algo bm --to 65535 -j DROP
-A INPUT -m string --string "peer_id=" --algo bm --to 65535 -j DROP
-A INPUT -m string --string ".torrent" --algo bm --to 65535 -j DROP
-A INPUT -m string --string "announce.php?passkey=" --algo bm --to 65535 -j DROP
-A INPUT -m string --string "torrent" --algo bm --to 65535 -j DROP
-A INPUT -m string --string "announce" --algo bm --to 65535 -j DROP
-A INPUT -m string --string "info_hash" --algo bm --to 65535 -j DROP
-A INPUT -m string --string "peer_id" --algo kmp --to 65535 -j DROP
-A INPUT -m string --string "BitTorrent" --algo kmp --to 65535 -j DROP
-A INPUT -m string --string "BitTorrent protocol" --algo kmp --to 65535 -j DROP
-A INPUT -m string --string "bittorrent-announce" --algo kmp --to 65535 -j DROP
-A INPUT -m string --string "announce.php?passkey=" --algo kmp --to 65535 -j DROP
-A INPUT -m string --string "find_node" --algo kmp --to 65535 -j DROP
-A INPUT -m string --string "info_hash" --algo kmp --to 65535 -j DROP
-A INPUT -m string --string "get_peers" --algo kmp --to 65535 -j DROP
-A INPUT -m string --string "announce" --algo kmp --to 65535 -j DROP
-A INPUT -m string --string "announce_peers" --algo kmp --to 65535 -j DROP
-t nat -A POSTROUTING -o eth0 -j MASQUERADE
-I OUTPUT -p tcp --dport 1723 -j ACCEPT
-A OUTPUT -p tcp --dport 6881:6889 -j DROP
-A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
-A FORWARD -p tcp --dport 6881:6889 -j DROP
-D FORWARD -m string --algo bm --string "BitTorrent" -j LOGDROP
-D FORWARD -m string --algo bm --string "BitTorrent protocol" -j LOGDROP
-D FORWARD -m string --algo bm --string "peer_id=" -j LOGDROP
-D FORWARD -m string --algo bm --string ".torrent" -j LOGDROP
-D FORWARD -m string --algo bm --string "announce.php?passkey=" -j LOGDROP
-D FORWARD -m string --algo bm --string "torrent" -j LOGDROP
-D FORWARD -m string --algo bm --string "announce" -j LOGDROP
-D FORWARD -m string --algo bm --string "info_hash" -j LOGDROP
-A FORWARD -m string --string "get_peers" --algo bm -j DROP
-A FORWARD -m string --string "announce_peer" --algo bm -j LOGDROP
-A FORWARD -m string --string "find_node" --algo bm -j LOGDROP
-A FORWARD -p udp -m string --algo bm --string "BitTorrent" -j DROP
-A FORWARD -p udp -m string --algo bm --string "BitTorrent protocol" -j DROP
-A FORWARD -p udp -m string --algo bm --string "peer_id=" -j DROP
-A FORWARD -p udp -m string --algo bm --string ".torrent" -j DROP
-A FORWARD -p udp -m string --algo bm --string "announce.php?passkey=" -j DROP
-A FORWARD -p udp -m string --algo bm --string "torrent" -j DROP
-A FORWARD -p udp -m string --algo bm --string "announce" -j DROP
-A FORWARD -p udp -m string --algo bm --string "info_hash" -j DROP
-A FORWARD -p udp -m string --algo bm --string "tracker" -j DROP
-A INPUT -p udp -m string --algo bm --string "BitTorrent" -j DROP
-A INPUT -p udp -m string --algo bm --string "BitTorrent protocol" -j DROP iptables -A INPUT -p udp -m string --algo bm --string "peer_id=" -j DROP
-A INPUT -p udp -m string --algo bm --string ".torrent" -j DROP
-A INPUT -p udp -m string --algo bm --string "announce.php?passkey=" -j DROP iptables -A INPUT -p udp -m string --algo bm --string "torrent" -j DROP
-A INPUT -p udp -m string --algo bm --string "announce" -j DROP
-A INPUT -p udp -m string --algo bm --string "info_hash" -j DROP
-A INPUT -p udp -m string --algo bm --string "tracker" -j DROP
-I INPUT -p udp -m string --algo bm --string "BitTorrent" -j DROP
-I INPUT -p udp -m string --algo bm --string "BitTorrent protocol" -j DROP iptables -I INPUT -p udp -m string --algo bm --string "peer_id=" -j DROP
-I INPUT -p udp -m string --algo bm --string ".torrent" -j DROP
-I INPUT -p udp -m string --algo bm --string "announce.php?passkey=" -j DROP iptables -I INPUT -p udp -m string --algo bm --string "torrent" -j DROP
-I INPUT -p udp -m string --algo bm --string "announce" -j DROP
-I INPUT -p udp -m string --algo bm --string "info_hash" -j DROP
-I INPUT -p udp -m string --algo bm --string "tracker" -j DROP
-D INPUT -p udp -m string --algo bm --string "BitTorrent" -j DROP
-D INPUT -p udp -m string --algo bm --string "BitTorrent protocol" -j DROP iptables -D INPUT -p udp -m string --algo bm --string "peer_id=" -j DROP
-D INPUT -p udp -m string --algo bm --string ".torrent" -j DROP
-D INPUT -p udp -m string --algo bm --string "announce.php?passkey=" -j DROP iptables -D INPUT -p udp -m string --algo bm --string "torrent" -j DROP
-D INPUT -p udp -m string --algo bm --string "announce" -j DROP
-D INPUT -p udp -m string --algo bm --string "info_hash" -j DROP
-D INPUT -p udp -m string --algo bm --string "tracker" -j DROP
-I OUTPUT -p udp -m string --algo bm --string "BitTorrent" -j DROP
-I OUTPUT -p udp -m string --algo bm --string "BitTorrent protocol" -j DROP iptables -I OUTPUT -p udp -m string --algo bm --string "peer_id=" -j DROP
-I OUTPUT -p udp -m string --algo bm --string ".torrent" -j DROP
-I OUTPUT -p udp -m string --algo bm --string "announce.php?passkey=" -j DROP iptables -I OUTPUT -p udp -m string --algo bm --string "torrent" -j DROP
-I OUTPUT -p udp -m string --algo bm --string "announce" -j DROP
-I OUTPUT -p udp -m string --algo bm --string "info_hash" -j DROP
-I OUTPUT -p udp -m string --algo bm --string "tracker" -j DROP
-D INPUT -m string --algo bm --string "BitTorrent" -j DROP
-D INPUT -m string --algo bm --string "BitTorrent protocol" -j DROP
-D INPUT -m string --algo bm --string "peer_id=" -j DROP
-D INPUT -m string --algo bm --string ".torrent" -j DROP
-D INPUT -m string --algo bm --string "announce.php?passkey=" -j DROP
-D INPUT -m string --algo bm --string "torrent" -j DROP
-D INPUT -m string --algo bm --string "announce" -j DROP
-D INPUT -m string --algo bm --string "info_hash" -j DROP
-D INPUT -m string --algo bm --string "tracker" -j DROP
-D OUTPUT -m string --algo bm --string "BitTorrent" -j DROP
-D OUTPUT -m string --algo bm --string "BitTorrent protocol" -j DROP
-D OUTPUT -m string --algo bm --string "peer_id=" -j DROP
-D OUTPUT -m string --algo bm --string ".torrent" -j DROP
-D OUTPUT -m string --algo bm --string "announce.php?passkey=" -j DROP
-D OUTPUT -m string --algo bm --string "torrent" -j DROP
-D OUTPUT -m string --algo bm --string "announce" -j DROP
-D OUTPUT -m string --algo bm --string "info_hash" -j DROP
-D OUTPUT -m string --algo bm --string "tracker" -j DROP
-D FORWARD -m string --algo bm --string "BitTorrent" -j DROP
-D FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
-D FORWARD -m string --algo bm --string "peer_id=" -j DROP
-D FORWARD -m string --algo bm --string ".torrent" -j DROP
-D FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
-D FORWARD -m string --algo bm --string "torrent" -j DROP
-D FORWARD -m string --algo bm --string "announce" -j DROP
-D FORWARD -m string --algo bm --string "info_hash" -j DROP
-D FORWARD -m string --algo bm --string "tracker" -j DROP
COMMIT
*raw
:PREROUTING ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
COMMIT
*mangle
:PREROUTING ACCEPT [0:0]
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]
COMMIT
END
sed -i $MYIP2 /etc/iptables.up.rules;
iptables-restore < /etc/iptables.up.rules
sed -i 's/\/var\/www\/html;/\/home\/vps\/public_html\/;/g' /etc/nginx/sites-enabled/default
cp /var/www/html/index.nginx-debian.html /home/vps/public_html/index.html
useradd admin
echo "admin:itangsagli" | chpasswd

cat > /etc/rc.local <<-END
exit 0
END
chmod +x /etc/rc.local
sed -i '$ i\echo "nameserver 8.8.8.8" > /etc/resolv.conf' /etc/rc.local
sed -i '$ i\echo "nameserver 8.8.4.4" >> /etc/resolv.conf' /etc/rc.local
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
apt-get install unzip
cd /usr/local/bin/
wget "https://github.com/rafaelitel/starktony/raw/master/bashmenu.zip"
unzip bashmenu.zip
chmod +x /usr/local/bin/*
vnstat -u -i eth0
cd /home/vps/public_html
zip configs.zip sun-tuctc.ovpn OpenVPN-SSL.ovpn stunnel.conf fixplan.ovpn noload.ovpn sunfreeyt.ovpn default.ovpn gtmfbig.ovpn tu200.ovpn JFTV-WG.conf
apt-get install libxml-parser-perl -y -f
vnstat -u -i eth0
apt-get -y autoremove
chown -R www-data:www-data /home/vps/public_html
service nginx start
service php7.0-fpm start
service vnstat restart
service openvpn restart
service dropbear restart
service fail2ban restart
service squid restart
service privoxy restart
history -c
rm -rf /root/*
cd /root
clear
echo " "
echo "Installation has been completed!!"
echo " Please Reboot your VPS"
echo "--------------------------- Configuration Setup Server -------------------------"
echo "                            Debian Premium Script                               "
echo "                                 -StarkTony-                                   "
echo "--------------------------------------------------------------------------------"
echo ""  | tee -a log-install.txt
echo "Server Information"  | tee -a log-install.txt
echo "   - Timezone    : Asia/Manila (GMT +8)"  | tee -a log-install.txt
echo "   - Fail2Ban    : [ON]"  | tee -a log-install.txt
echo "   - IPtables    : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot : [OFF]"  | tee -a log-install.txt
echo "   - IPv6        : [OFF]"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Application & Port Information"  | tee -a log-install.txt
echo "   - OpenVPN		: TCP 110 "  | tee -a log-install.txt
echo "   - OpenVPN-SSL	: 587 "  | tee -a log-install.txt
echo "   - Dropbear		: 442"  | tee -a log-install.txt
echo "   - Stunnel  	: 444"  | tee -a log-install.txt
echo "   - Squid Proxy	: 3355, 8085 (limit to IP Server)"  | tee -a log-install.txt
echo "   - Privoxy		: 3356, 8086 (limit to IP Server)"  | tee -a log-install.txt
echo "   - BadVPN		: 7300"  | tee -a log-install.txt
echo "   - Nginx		: 80"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Premium Script Information"  | tee -a log-install.txt
echo "   To display list of commands: menu"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Important Information"  | tee -a log-install.txt
echo "   - Download Config OpenVPN : http://$MYIP/configs.zip"  | tee -a log-install.txt
echo "   - Installation Log        : cat /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   - Webmin                  : http://$MYIP:10000/"  | tee -a log-install.txt
echo ""
echo "------------------------------ Script by StarkTony -----------------------------"
echo "-----Please Reboot your VPS -----"
sleep 5
