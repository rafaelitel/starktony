#!/bin/bash
# Automation Script For Centos 6 64bit 
# Features: OpenVPN/SSL/Dropbear/Squid Proxy
# Date Modified: 10/26/19
# Made by: STARKDEVTEAM 
ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config &> /dev/null
#change this according to your database details
dbhost='185.61.137.168';
dbuser='tonystar1_tonystarkvpnml';
dbpass='tonystarkvpnml';
dbname='tonystar1_tonystark-vpn.ml';
dbport='3306';


##certificates
cacert='-----BEGIN CERTIFICATE-----
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
-----END CERTIFICATE-----';
servercert='Certificate:
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
-----END CERTIFICATE-----';
serverkey='-----BEGIN PRIVATE KEY-----
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
-----END PRIVATE KEY-----';
dh='-----BEGIN DH PARAMETERS-----
MIIBCAKCAQEAohzwXz9fsjw+G9Q14qINNOhZnTt/b30zzJYm4o2NIzAngM6E6GPm
N5USUt0grZw6h3VP9LyqQoGi/bHFz33YFG5lgDF8FAASEh07/leF7s0ohhK8pspC
JVD+mRatwBrIImXUpJvYI2pXKxtCOnDa2FFjAOHKixiAXqVcmJRwNaSklQcrpXdn
/09cr0rbFoovn+f1agly4FxYYs7P0XkvSHm3gVW/mhAUr1hvZlbBaWFSVUdgcVOi
FXQ/AVkvxYaO8pFI2Vh+CNMk7Vvi8d3DTayvoL2HTgFi+OIEbiiE/Nzryu+jDGc7
79FkBHWOa/7eD2nFrHScUJcwWiSevPQjQwIBAg==
-----END DH PARAMETERS-----';

# Terminal Color

RED='\033[01;31m';
RESET='\033[0m';
GREEN='\033[01;32m';
WHITE='\033[01;37m';
YELLOW='\033[00;33m';

echo -e "$GREEN                Please Wait... $RESET"
sleep 3s
echo -e "$GREEN                Installing Updates $RESET"
yum update -y &> /dev/null
clear
echo -e "$GREEN                Updates Done  $RESET"
sleep 3s
echo -e "$GREEN                Lets install the required packages. $RESET"
sleep 3s
clear
echo -e "$GREEN                Please Wait... $RESET"
yum install httpd nano squid -y &> /dev/null
yum install mysql-server epel-release -y &> /dev/null
yum install openvpn sudo curl -y &> /dev/null
MYIP=$(curl -4 icanhazip.com); &> /dev/null
echo -e "$GREEN                Installation Complete $RESET"
echo -e "$GREEN                Lets configure the settings and routing $RESET"
sleep 4s
clear
echo -e "$GREEN                Please wait while we are fighting with your firewall $RESET"
sleep 4s
## making script and keys
mkdir /etc/openvpn/script
mkdir /etc/openvpn/log
mkdir /etc/openvpn/keys
mkdir /var/www/html/status
touch /var/www/html/status/tcp2.txt
ethernet=""



echo "************************************************************************************"
echo -e " Note: Your Network Interface is followed by the word \e[1;31m' dev '\e[0m"
echo " If the interface doesnt match openvpn will be connected but no internet access."
echo " Please choose or type properly"
echo "************************************************************************************"
echo ""
echo "Your Network Interface is:"
ip route | grep default
echo ""
echo "Ethernet:"
read ethernet
echo ""
echo ""
clear



cat << EOF > /etc/openvpn/keys/ca.crt
$cacert
EOF

cat << EOF > /etc/openvpn/keys/server.crt
$servercert
EOF

cat << EOF > /etc/openvpn/keys/server.key
$serverkey
EOF

cat << EOF > /etc/openvpn/keys/dh2048.pem
$dh
EOF

cat << EOF > /etc/openvpn/script/config.sh
#!/bin/bash
##Dababase Server
HOST='$dbhost'
USER='$dbuser'
PASS='$dbpass'
DB='$dbname'
PORT='$dbport'
EOF


cat << EOF > /etc/openvpn/server.conf
local $MYIP
mode server 
tls-server 
port 443
proto tcp
dev tun
tun-mtu-extra 32 
tun-mtu 1400 
mssfix 1360
tcp-queue-limit 128
txqueuelen 2000
tcp-nodelay
sndbuf 393216
rcvbuf 393216
push "sndbuf 393216"
push "rcvbuf 393216"
server 10.8.0.0 255.255.255.0
ca /etc/openvpn/keys/ca.crt
cert /etc/openvpn/keys/server.crt
key /etc/openvpn/keys/server.key
dh /etc/openvpn/keys/dh2048.pem
persist-key
persist-tun
keepalive 1 180
comp-lzo
user nobody
client-to-client
username-as-common-name
client-cert-not-required
auth-user-pass-verify /etc/openvpn/script/login.sh via-env
push "redirect-gateway def1"
push "dhcp-option DNS 1.1.1.1"
push "dhcp-option DNS 1.0.0.1"
script-security 3
client-connect /etc/openvpn/script/connect.sh
client-disconnect /etc/openvpn/script/disconnect.sh
status /var/www/html/status/tcp2.txt
#log-append /etc/openvpn/log/openvpn.log
verb 3
connect-retry-max infinite
EOF

#denying torrent
/bin/cat <<"EOM" >/etc/squid/extensiondeny.txt
\.torrent$
EOM

echo '' > /etc/sysctl.conf &> /dev/null
echo "# Kernel sysctl configuration file for Red Hat Linux
#
# For binary values, 0 is disabled, 1 is enabled.  See sysctl(8) and
# sysctl.conf(5) for more details.
#
# Use '/sbin/sysctl -a' to list all possible parameters.
# Controls IP packet forwarding
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
net.ipv4.ip_forward = 1
fs.file-max = 65535
net.core.rmem_default = 262144
net.core.rmem_max = 262144
net.core.wmem_default = 262144
net.core.wmem_max = 262144
net.ipv4.tcp_rmem = 4096 87380 8388608
net.ipv4.tcp_wmem = 4096 65536 8388608
net.ipv4.tcp_mem = 4096 4096 4096
net.ipv4.tcp_low_latency = 1
net.core.netdev_max_backlog = 4000
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.tcp_max_syn_backlog = 16384"| sudo tee /etc/sysctl.conf &> /dev/null
sysctl -p &> /dev/null
iptables -F; iptables -X; iptables -Z
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o $ethernet -j MASQUERADE
iptables -t nat -A POSTROUTING -o $ethernet -j SNAT --to-source $MYIP
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to-source $MYIP

## changing permissions
chmod -R 755 /etc/openvpn
restorecon -r /var/www/html
cd /var/www/html/status
chmod 775 *
cd
echo '' > /etc/squid/squid.conf &> /dev/null
echo "acl extensiondeny url_regex -i "/etc/squid/extensiondeny.txt"
acl download method GET
http_access deny extensiondeny download
http_access deny extensiondeny all
cache deny all
memory_pools off
dns_nameservers 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4
half_closed_clients off
http_port 8080 transparent
http_port 8989
http_port 8000
acl leakteam dst $MYIP
http_access allow leakteam
visible_hostname Powered_By_LEAKTeam
via off
forwarded_for off
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
acl manager proto cache_object
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl localnet src 10.0.0.0/8     # RFC1918 possible internal network
acl localnet src 172.16.0.0/12  # RFC1918 possible internal network
acl localnet src 192.168.0.0/16 # RFC1918 possible internal network
acl localnet src fc00::/7       # RFC 4193 local private network range
acl localnet src fe80::/10      # RFC 4291 link-local (directly plugged) machines 
acl SSL_ports port 443
acl Safe_ports port 80          # http
acl Safe_ports port 21          # ftp
acl Safe_ports port 443         # https
acl Safe_ports port 70          # gopher
acl Safe_ports port 210         # wais
acl Safe_ports port 1025-65535  # unregistered ports
acl Safe_ports port 280         # http-mgmt
acl Safe_ports port 488         # gss-http
acl Safe_ports port 591         # filemaker
acl Safe_ports port 777         # multiling http
acl CONNECT method CONNECT
http_access allow manager localhost
http_access deny manager
http_access deny !Safe_ports
http_access deny CONNECT !SSL_ports
http_access allow localnet
http_access allow localhost
http_access deny all
hierarchy_stoplist cgi-bin ?
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320
cache_effective_user squid
cache_effective_group squid"| sudo tee /etc/squid/squid.conf &> /dev/null

clear
echo -e "$GREEN                    We are almost done $RESET"
sleep 4s
echo "Type of your Server"
PS3='Choose or Type a Plan: '
options=("Premium" "VIP" "Private" "Quit")
select opt in "${options[@]}"; do
case "$opt,$REPLY" in
Premium,*|*,Premium) 
echo "";
	/bin/cat <<"EOM" >/etc/openvpn/script/connect.sh
#!/bin/bash

tm="$(date +%s)"
dt="$(date +'%Y-%m-%d %H:%M:%S')"
timestamp="$(date +'%FT%TZ')"

. /etc/openvpn/script/config.sh

##set status online to user connected
bandwidth_check=`mysql -u $USER -p$PASS -D $DB -h $HOST --skip-column-name -e "SELECT bandwidth_logs.username FROM bandwidth_logs WHERE bandwidth_logs.username='$common_name' AND bandwidth_logs.category='premium' AND bandwidth_logs.status='online'"`
if [ "$bandwidth_check" == 1 ]; then
	mysql -u $USER -p$PASS -D $DB -h $HOST -e "UPDATE bandwith_logs SET server_ip='$local_1', server_port='$trusted_port', timestamp='$timestamp', ipaddress='$trusted_ip:$trusted_port', username='$common_name', time_in='$tm', since_connected='$time_ascii', bytes_received='$bytes_received', bytes_sent='$bytes_sent' WHERE username='$common_name' AND status='online' AND category='premium' "
else
	mysql -u $USER -p$PASS -D $DB -h $HOST -e "INSERT INTO bandwidth_logs (server_ip, server_port, timestamp, ipaddress, since_connected, username, bytes_received, bytes_sent, time_in, status, time, category) VALUES ('$local_1','$trusted_port','$timestamp','$trusted_ip:$trusted_port','$time_ascii','$common_name','$bytes_received','$bytes_sent','$dt','online','$tm','premium') "
fi

EOM

/bin/cat <<"EOM" >/etc/openvpn/script/disconnect.sh
#!/bin/bash
tm="$(date +%s)"
dt="$(date +'%Y-%m-%d %H:%M:%S')"
timestamp="$(date +'%FT%TZ')"

. /etc/openvpn/script/config.sh

mysql -u $USER -p$PASS -D $DB -h $HOST -e "UPDATE bandwidth_logs SET bytes_received='$bytes_received',bytes_sent='$bytes_sent',time_out='$dt', status='offline' WHERE username='$common_name' AND status='online' AND category='premium' "

EOM

/bin/cat <<"EOM" >/etc/openvpn/script/login.sh
#!/bin/bash
. /etc/openvpn/script/config.sh


##PREMIUM##
PRE="users.user_name='$username' AND users.auth_vpn=md5('$password') AND users.is_validated=1 AND users.is_freeze=0 AND users.is_active=1 AND users.is_ban=0 AND users.duration > 0"

##VIP##
VIP="users.user_name='$username' AND users.auth_vpn=md5('$password') AND users.is_validated=1 AND users.is_freeze=0 AND users.is_active=1 AND users.is_ban=0 AND users.vip_duration > 0"

##Private##
PRIV="users.user_name='$username' AND users.auth_vpn=md5('$password') AND users.is_validated=1 AND users.is_freeze=0 AND users.is_active=1 AND users.is_ban=0 AND users.private_duration > 0"

Query="SELECT users.user_name FROM users WHERE $PRE OR $VIP OR $PRIV"
user_name=`mysql -u $USER -p$PASS -D $DB -h $HOST --skip-column-name -e "$Query"`

[ "$user_name" != '' ] && [ "$user_name" = "$username" ] && echo "user : $username" && echo 'authentication ok.' && exit 0 || echo 'authentication failed.'; exit 1

EOM

echo "";
echo "1) Premium Selected";
break ;;
VIP,*|*,VIP) 
echo "";
/bin/cat <<"EOM" >/etc/openvpn/script/connect.sh
#!/bin/bash

tm="$(date +%s)"
dt="$(date +'%Y-%m-%d %H:%M:%S')"
timestamp="$(date +'%FT%TZ')"

. /etc/openvpn/script/config.sh

##set status online to user connected
bandwidth_check=`mysql -u $USER -p$PASS -D $DB -h $HOST --skip-column-name -e "SELECT bandwidth_logs.username FROM bandwidth_logs WHERE bandwidth_logs.username='$common_name' AND bandwidth_logs.category='vip' AND bandwidth_logs.status='online'"`
if [ "$bandwidth_check" == 1 ]; then
	mysql -u $USER -p$PASS -D $DB -h $HOST -e "UPDATE bandwith_logs SET server_ip='$local_1', server_port='$trusted_port', timestamp='$timestamp', ipaddress='$trusted_ip:$trusted_port', username='$common_name', time_in='$tm', since_connected='$time_ascii', bytes_received='$bytes_received', bytes_sent='$bytes_sent' WHERE username='$common_name' AND status='online' AND category='vip' "
else
	mysql -u $USER -p$PASS -D $DB -h $HOST -e "INSERT INTO bandwidth_logs (server_ip, server_port, timestamp, ipaddress, since_connected, username, bytes_received, bytes_sent, time_in, status, time, category) VALUES ('$local_1','$trusted_port','$timestamp','$trusted_ip:$trusted_port','$time_ascii','$common_name','$bytes_received','$bytes_sent','$dt','online','$tm','vip') "
fi

EOM

/bin/cat <<"EOM" >/etc/openvpn/script/disconnect.sh
#!/bin/bash
tm="$(date +%s)"
dt="$(date +'%Y-%m-%d %H:%M:%S')"
timestamp="$(date +'%FT%TZ')"

. /etc/openvpn/script/config.sh

mysql -u $USER -p$PASS -D $DB -h $HOST -e "UPDATE bandwidth_logs SET bytes_received='$bytes_received',bytes_sent='$bytes_sent',time_out='$dt', status='offline' WHERE username='$common_name' AND status='online' AND category='vip' "

EOM
 
 /bin/cat <<"EOM" >/etc/openvpn/script/login.sh
#!/bin/bash
. /etc/openvpn/script/config.sh


##VIP##
VIP="users.user_name='$username' AND users.auth_vpn=md5('$password') AND users.is_validated=1 AND users.is_freeze=0 AND users.is_active=1 AND users.is_ban=0 AND users.vip_duration > 0"

##Private##
PRIV="users.user_name='$username' AND users.auth_vpn=md5('$password') AND users.is_validated=1 AND users.is_freeze=0 AND users.is_active=1 AND users.is_ban=0 AND users.private_duration > 0"

Query="SELECT users.user_name FROM users WHERE $VIP OR $PRIV"
user_name=`mysql -u $USER -p$PASS -D $DB -h $HOST --skip-column-name -e "$Query"`

[ "$user_name" != '' ] && [ "$user_name" = "$username" ] && echo "user : $username" && echo 'authentication ok.' && exit 0 || echo 'authentication failed.'; exit 1

EOM

echo "";
echo "2) VIP Selected";
break ;;
Private,*|*,Private) 
echo "";
/bin/cat <<"EOM" >/etc/openvpn/script/connect.sh
#!/bin/bash

tm="$(date +%s)"
dt="$(date +'%Y-%m-%d %H:%M:%S')"
timestamp="$(date +'%FT%TZ')"

. /etc/openvpn/script/config.sh

##set status online to user connected
bandwidth_check=`mysql -u $USER -p$PASS -D $DB -h $HOST --skip-column-name -e "SELECT bandwidth_logs.username FROM bandwidth_logs WHERE bandwidth_logs.username='$common_name' AND bandwidth_logs.category='private' AND bandwidth_logs.status='online'"`
if [ "$bandwidth_check" == 1 ]; then
	mysql -u $USER -p$PASS -D $DB -h $HOST -e "UPDATE bandwith_logs SET server_ip='$local_1', server_port='$trusted_port', timestamp='$timestamp', ipaddress='$trusted_ip:$trusted_port', username='$common_name', time_in='$tm', since_connected='$time_ascii', bytes_received='$bytes_received', bytes_sent='$bytes_sent' WHERE username='$common_name' AND status='online' AND category='private' "
else
	mysql -u $USER -p$PASS -D $DB -h $HOST -e "INSERT INTO bandwidth_logs (server_ip, server_port, timestamp, ipaddress, since_connected, username, bytes_received, bytes_sent, time_in, status, time, category) VALUES ('$local_1','$trusted_port','$timestamp','$trusted_ip:$trusted_port','$time_ascii','$common_name','$bytes_received','$bytes_sent','$dt','online','$tm','private') "
fi

EOM

/bin/cat <<"EOM" >/etc/openvpn/script/disconnect.sh
#!/bin/bash
tm="$(date +%s)"
dt="$(date +'%Y-%m-%d %H:%M:%S')"
timestamp="$(date +'%FT%TZ')"

. /etc/openvpn/script/config.sh

mysql -u $USER -p$PASS -D $DB -h $HOST -e "UPDATE bandwidth_logs SET bytes_received='$bytes_received',bytes_sent='$bytes_sent',time_out='$dt', status='offline' WHERE username='$common_name' AND status='online' AND category='private' "

EOM

/bin/cat <<"EOM" >/etc/openvpn/script/login.sh
#!/bin/bash
. /etc/openvpn/script/config.sh

##Private##
PRIV="users.user_name='$username' AND users.auth_vpn=md5('$password') AND users.is_validated=1 AND users.is_freeze=0 AND users.is_active=1 AND users.is_ban=0 AND users.private_duration > 0"

Query="SELECT users.user_name FROM users WHERE $PRIV"
user_name=`mysql -u $USER -p$PASS -D $DB -h $HOST --skip-column-name -e "$Query"`

[ "$user_name" != '' ] && [ "$user_name" = "$username" ] && echo "user : $username" && echo 'authentication ok.' && exit 0 || echo 'authentication failed.'; exit 1

EOM
echo "";
echo "3) Private Selected";
sleep 3s
break ;;
Quit,*|*,Quit) echo "Installation Cancelled!!";
echo -e "\e[1;31mRebuild your vps and correct the process.\e[0m";
exit;
break ;; *)
echo Invalid: Choose a proper Plan;;
esac
done

sleep 4s
clear
#echo '*/5 * * * * /etc/openvpn/script/onlineuser.php >/dev/null 2>&1' | crontab -
echo "VPS Boot Time"
PS3='Choose Boot Time: '
options=("5am" "Weekdays" "Monthly" "Quit")
select opt in "${options[@]}"; do
case "$opt,$REPLY" in
5am,*|*,5am) 
echo "";
echo "0 5 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "";
echo "1) Every 5:00 am Your VPS will reboot ";
break ;;
Weekdays,*|*,Weekdays) 
echo "";
echo "0 4 * * 0 root /sbin/reboot" > /etc/cron.d/reboot
echo "";
echo "2) Every 4:00 am Sunday Your VPS will reboot";
break ;;
Monthly,*|*,Monthly) 
echo "";
echo "0 0 1 * * root /sbin/reboot" > /etc/cron.d/reboot
echo "";
echo "2) Every 12mn Next Month Your VPS will reboot";
break ;;
Quit,*|*,Quit) echo "Installation Cancelled!!";
echo -e "\e[1;31mRebuild your vps and correct the process.\e[0m";
exit;
break ;; *)
echo Invalid: Just choose what you want;;
esac
done

echo -e "$GREEN                   Installing Stunnel for SSL Support $RESET"
# Stunnel w/ Init.d Support for ssh and openvpn adds on
# Made w/ love by LEAKTeam
# Powered by PisoVPN
# Script Auth Key dont modify
USER="leakteam"
PASS="leakteam"
yum -y install stunnel dropbear &> /dev/null
mkdir /var/run/stunnel &> /dev/null
chown nobody:nobody /var/run/stunnel &> /dev/null
cat <<EOF >/etc/stunnel/stunnel.pem
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAwdnzMLirSgoDvxSffs71C9Esqc3vVfXoXalWSgLjjD3XlEKA
IvRPbf7XUMrVnJK+jt63WZmHSm/n3i9g6WSskvJB9XVsl91FK8yLfhw7zGbkA+Ee
6kkMxAI19XiEwDwFh/Bgm0nbIMIdezgluqetnu2VpABiW2OohFt3D5JjILG5wCFh
Lpd8FmOYHKDXYn5pkzyS2ieFolBpLClU+lbwClnb3FFGkLQGnmauhoao6bv+i8iF
D2Tgm61PZG6kbzdNdGwACv0iO+Tx2PS05zm/vm/vgMhgofBc8HYmLE9/5UdYj3Kq
8Di0NxZtnnf+4KU2Y+wz4MJwOEtHoWRwy37OjQIDAQABAoIBAQCJ+UzkoqwYGKSt
/km/giJb9NfrTE5LSqnG8F4gc4nuKZ4lQmfdeTKHwdkTAiukM7Y6Dj9GIMZwrtHE
DMjXlfZW6OMViCxwsucm04F9ky7kv18Pe837R180q7YoL02dXZs6NFcucBTtbfx5
1W7VOb+T3NqjTjqzfW1WN5u4k6LGgznkMMdomGmmuoIirPi9w9F8qngcGrTzlxNE
/i9yqhS0qIRzb1ujg/jWGgRYgkkdOv0zLEpF7MQP/4WrdZnstVRX1ayWl30cDxey
Db7nj0f1XRsVftlgczaPAqlCR/4oLvjIaoxderBYa0WoV0ESOGSRUE5BfUx67SYu
jFJJCuupAoGBAPlo+dCPc47PWUsKkgGVbcEZGMdMoC1CkUuuiiPnh7W5zJ/oMh/b
tjiNARaCnJj/xJoRYta4iFD+PGGzc7mxaaa1UE3Sz90P5VbFFdw3BP6CwJRoa1t3
F3PR7EC4bnasHEwJv+hURq13qRKvfRW8UwmrM5VyahClGhNXSEvWftbLAoGBAMb5
LABliaosVYROxdAnueUH2A3x/Xz6cjuITgUFXbm2XzzJvkeQsem3geCTn5cRUNjN
zw5yTryGmgwn95VjWhC0ibWOBaAftwKLeKFF2EVwYyUfF5nxn+qLg/qFnu81YtjZ
aDoV/vfm2FoGTLsv4ci9eubMgJRkQnbAqX4Q5+0HAoGBAKV0MmVdBLf0bbQOaxWJ
36l90KZF+uyLgH/IZfOzoJ+5hjl+e+IOiy+wuswIEYKeCfp7FiqDeErinYPi3B6P
xxrEpWU7OJHZ/bY2QG46QaHlc4QAUVf4BSLcW/IDZ6RqQMtgnGKvpcNl4k93A2/r
4tpDLJEzuZEZNdcmy9sjjDlJAoGBALjYuzwTGHVzgm7MD5F1loljZCBwc6IruPv9
gR3BAnWJK6j5c0Bg+Ce8R3gvLM/XUlhXusgdAXC7S1mHt8ac6gsi7dww+KDtVcOT
dpm8nVLFOhY+cFqf0oS+3/lZMXHhEteKAf4UeS4s00mvGJG9xfALt6W6zqkNC4Hv
Mobfhdb5AoGARN6aNhdMQjval17da/XkDEt/dlaLdMehKTTIeP6EzHIVj7v+TUbD
SVZ24wTyzMrJP5Bzb/MV+TZ6FDMrm54XRfpB2vzBt7TTOyZh60CA8YUnZK0U+1aY
CIfOVDdOhrawVkyoJGGoMW9vXp51731tadnUR1lJOaonHZpLWW7FDxo=
-----END RSA PRIVATE KEY-----
-----BEGIN CERTIFICATE-----
MIID8TCCAtmgAwIBAgIJAOGZPlgRlnI1MA0GCSqGSIb3DQEBBQUAMIGOMQswCQYD
VQQGEwJmcjERMA8GA1UECAwIYmF0YW5nYXMxETAPBgNVBAcMCGJhdGFuZ2FzMREw
DwYDVQQKDAhsZWFrdGVhbTERMA8GA1UECwwIbGVha3RlYW0xETAPBgNVBAMMCGxl
YWt0ZWFtMSAwHgYJKoZIhvcNAQkBFhFqaG9leGlpQGdtYWlsLmNvbTAeFw0xODA4
MTUwODMzNTVaFw0yMTA4MTQwODMzNTVaMIGOMQswCQYDVQQGEwJmcjERMA8GA1UE
CAwIYmF0YW5nYXMxETAPBgNVBAcMCGJhdGFuZ2FzMREwDwYDVQQKDAhsZWFrdGVh
bTERMA8GA1UECwwIbGVha3RlYW0xETAPBgNVBAMMCGxlYWt0ZWFtMSAwHgYJKoZI
hvcNAQkBFhFqaG9leGlpQGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAMHZ8zC4q0oKA78Un37O9QvRLKnN71X16F2pVkoC44w915RCgCL0
T23+11DK1ZySvo7et1mZh0pv594vYOlkrJLyQfV1bJfdRSvMi34cO8xm5APhHupJ
DMQCNfV4hMA8BYfwYJtJ2yDCHXs4JbqnrZ7tlaQAYltjqIRbdw+SYyCxucAhYS6X
fBZjmByg12J+aZM8ktonhaJQaSwpVPpW8ApZ29xRRpC0Bp5mroaGqOm7/ovIhQ9k
4JutT2RupG83TXRsAAr9Ijvk8dj0tOc5v75v74DIYKHwXPB2JixPf+VHWI9yqvA4
tDcWbZ53/uClNmPsM+DCcDhLR6FkcMt+zo0CAwEAAaNQME4wHQYDVR0OBBYEFIU7
tUhNMh8H3ZFObgb45gVXN0CiMB8GA1UdIwQYMBaAFIU7tUhNMh8H3ZFObgb45gVX
N0CiMAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEFBQADggEBALRi4Vl5VuPGmWQv
QfOSR5AlRfyU/rj4jZyuqYQhpQlr+MILzj/1IEcit9mE7f6p84Vt0QMeqA4L63lQ
L4fHVeWVneGmGBD2bOmU6L863SrhKKU03do6EsiQgqv/cz3Nywz1TibM4i/0razS
V6INeodpRyncmn0aIoEEa6Uozd6jCY5RL4MXSAebo10DHFaS1uX9fgsC4DHYFgRM
8u7tJcWpnZEKoxlval357Zw1PAhgdOMH4PFrEwj6QX+7mtRBkwQZG0dYp/c6ugoR
oZcQApHv3d6eFwWNIXB8wOW/1kuxvRVpVoklxJEkBPEWj3v+Cg27eGNelfR/aw91
V5j7UNA=
-----END CERTIFICATE-----
EOF

/bin/cat <<"EOM" >/etc/rc.d/init.d/stunnel
#!/bin/bash
#
# Init Script to run stunnel in daemon mode at boot time.
#
# Author: Riccardo Riva - RPM S.r.l.
# Revision 1.0 - 2010 November, 11

#====================================================================
# Run level information:
#
# chkconfig: 2345 99 99
# description: Secure Tunnel
# processname: stunnel
#
# Run "/sbin/chkconfig --add stunnel" to add the Run levels.
# This will setup the symlinks and set the process to run at boot.
#====================================================================

#====================================================================
# Paths and variables and system checks.

# Source function library
. /etc/rc.d/init.d/functions

# Check that networking is up.
#
[ ${NETWORKING} ="yes" ] || exit 0

# Path to the executable.
#
SEXE=/usr/bin/stunnel

# Path to the configuration file.
#
CONF=/etc/stunnel/stunnel.conf

# Check the configuration file exists.
#
if [ ! -f $CONF ] ; then
echo "The configuration file cannot be found!"
exit 0
fi

# Path to the lock file.
#
LOCK_FILE=/var/lock/subsys/stunnel

#====================================================================

# Run controls:

prog=$"stunnel"

RETVAL=0

# Start stunnel as daemon.
#
start() {
if [ -f $LOCK_FILE ]; then
echo "stunnel is already running!"
exit 0
else
echo -n $"Starting $prog: "
$SEXE $CONF
fi

RETVAL=$?
[ $RETVAL -eq 0 ] && success
echo
[ $RETVAL -eq 0 ] && touch $LOCK_FILE
return $RETVAL
}

# Stop stunnel.
#
stop() {
if [ ! -f $LOCK_FILE ]; then
echo "stunnel is not running!"
exit 0

else

echo -n $"Shutting down $prog: "
killproc stunnel
RETVAL=$?
[ $RETVAL -eq 0 ]
rm -f $LOCK_FILE
echo
return $RETVAL

fi
}

# See how we were called.
case "$1" in
start)
start
;;
stop)
stop
;;
restart)
stop
start
;;
condrestart)
if [ -f $LOCK_FILE ]; then
stop
start
RETVAL=$?
fi
;;
status)
status stunnel
RETVAL=$?
;;
*)
echo $"Usage: $0 {start|stop|restart|condrestart|status}"
RETVAL=1
esac

exit $RETVAL

#--- End of file ---

EOM

cat <<EOF >/etc/stunnel/stunnel.conf
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1


client = no

[dropbear]
accept = 0.0.0.0:445
connect = 127.0.0.1:444

cert = /etc/stunnel/stunnel.pem
EOF

echo '' > /etc/init.d/dropbear
/bin/cat <<"EOM" >/etc/init.d/dropbear
#!/bin/bash
#
# Init file for dropbear SSH server daemon
#
# chkconfig: - 55 25
# description: dropbear SSH server daemon
#
# processname: dropbear
# config: /etc/dropbear/dropbear_dss_host_key
# config: /etc/dropbear/dropbear_rsa_host_key
# pidfile: /var/run/dropbear.pid

# source function library
. /etc/rc.d/init.d/functions

# pull in sysconfig settings
[ -f /etc/sysconfig/dropbear ] && . /etc/sysconfig/dropbear

RETVAL=0
prog="dropbear"
OPTIONS="-p 444"
# Some functions to make the below more readable
KEYGEN=/usr/bin/dropbearkey
DROPBEAR=/usr/sbin/dropbear
RSA_KEY=/etc/dropbear/dropbear_rsa_host_key
DSS_KEY=/etc/dropbear/dropbear_dss_host_key
PID_FILE=/var/run/dropbear.pid

runlevel=$(set -- $(runlevel); eval "echo \$$#" )

do_rsa_keygen() {
	if [ ! -s $RSA_KEY ]; then
		echo -n $"Generating dropbear RSA host key: "
		if $KEYGEN -t rsa -f $RSA_KEY >&/dev/null; then
			chmod 600 $RSA_KEY
			success $"RSA key generation"
			echo
		else
			failure $"RSA key generation"
			echo
			exit 1
		fi
	fi
}

do_dss_keygen() {
	if [ ! -s $DSS_KEY ]; then
		echo -n $"Generating dropbear DSS host key: "
		if $KEYGEN -t dss -f $DSS_KEY >&/dev/null; then
			chmod 600 $DSS_KEY
			success $"DSS key generation"
			echo
		else
			failure $"DSS key generation"
			echo
			exit 1
		fi
	fi
}

start()
{
	# Create keys if necessary
	if [ "x${AUTOCREATE_SERVER_KEYS}" != xNO ]; then
		do_rsa_keygen
		do_dss_keygen
	fi

	echo -n $"Starting $prog: "
	$DROPBEAR $OPTIONS && success || failure
	RETVAL=$?
	[ "$RETVAL" = 0 ] && touch /var/lock/subsys/dropbear
	echo
}

stop()
{
	echo -n $"Stopping $prog: "
	if [ -n "`pidfileofproc $DROPBEAR`" ] ; then
	    killproc $DROPBEAR
	else
	    failure $"Stopping $prog"
	fi
	RETVAL=$?
	# if we are in halt or reboot runlevel kill all running sessions
	# so the TCP connections are closed cleanly
	if [ "x$runlevel" = x0 -o "x$runlevel" = x6 ] ; then
	    killall $prog 2>/dev/null
	fi
	[ "$RETVAL" = 0 ] && rm -f /var/lock/subsys/dropbear
	echo
}

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	restart)
		stop
		start
		;;
	reload)
		stop
		start
		;;
	condrestart)
		if [ -f /var/lock/subsys/dropbear ] ; then
			stop
			# avoid race
			sleep 3
			start
		fi
		;;
	status)
		status $DROPBEAR
		RETVAL=$?
		;;
	*)
		echo $"Usage: $0 {start|stop|restart|reload|condrestart|status}"
		RETVAL=1
esac
exit $RETVAL
EOM


echo -e "$YELLOW                        SUCCESS!
                                                   
            SSH SSL PORT         : 444
            OpenVPN PORT         : 443
            Squid PORT           : 8080/8989/8000"
#ps ax | grep stunnel
#netstat -antup
#nano /etc/sysconfig/network-scripts/ifcfg-eth0
rm -rf *sh &> /dev/null

echo ''
echo ''
echo -e "$GREEN                                          ALL DONE
                              Sytem to make the settings take effect,
                              And serves you a better performance $RESET"
echo ''
cd
#set localtime
ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime

# installing 
yum update -y &> /dev/null
yum install vixie-cron crontabs httpd git zip unzip epel-release -y &> /dev/null
yum install php php-pdo php-mysqli php-mysql php-gd php-mbstring.x86_64 -y &> /dev/null
yum install php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap curl curl-devel -y &> /dev/null




echo -e "                $GREEN Type of your Server to be read in ssh $RESET"
PS3='Choose or Type a Plan: '
options=("Premium" "VIP" "PRIVATE" "Quit")
select opt in "${options[@]}"; do
  case "$opt,$REPLY" in
    Premium,*|*,Premium) 
	echo "";
crontab -r
echo "* * * * * /usr/bin/php /usr/sbin/david/code.php >/dev/null 2>&1
*/2 * * * * /bin/bash /usr/sbin/david/premium.sh >/dev/null 2>&1" | tee -a /var/spool/cron/root




echo "";
echo -e "                $GREEN 1) Premium Selected$RESET";
break ;;
VIP,*|*,VIP) 
echo "";
crontab -r
echo "*/2 * * * * /usr/bin/php /usr/sbin/david/code.php >/dev/null 2>&1
* * * * * /bin/bash /usr/sbin/david/vip.sh >/dev/null 2>&1" | tee -a /var/spool/cron/root


echo "";
echo -e "                $GREEN 2) VIP Selected$RESET";
break ;;
PRIVATE,*|*,PRIVATE) 
echo "";
crontab -r
echo "* * * * * /usr/bin/php /usr/sbin/david/code.php >/dev/null 2>&1
*/2 * * * * /bin/bash /usr/sbin/david/private.sh >/dev/null 2>&1" | tee -a /var/spool/cron/root



echo "";
echo -e "                $GREEN 3) PRIVATE Selected$RESET";
break ;;
Quit,*|*,Quit) echo -e " $RED   Installation Cancelled!$RESET";
echo -e "                $RED   Rebuild your vps and correct the process.$RESET";
exit;
break ;; *)
echo -e "                $RED   Invalid: Just choose what you want$RESET";
esac
done

chmod 600 /etc/stunnel/stunnel.pem
chmod +x /etc/rc.d/init.d/stunnel
sed -i "s/#ServerName www.example.com:80/ServerName localhost:80/g" /etc/httpd/conf/httpd.conf
clear
service iptables save &> /dev/null
/sbin/chkconfig --add stunnel
chkconfig httpd on
chkconfig iptables on
chkconfig openvpn on
chkconfig squid on
chkconfig dropbear on
echo -e "$GREEN                Starting services we need $RESET"
service iptables restart &> /dev/null
service dropbear start
service httpd start
service stunnel start &> /dev/null
service stunnel stop &> /dev/null
service stunnel start
#start service
/sbin/chkconfig crond on
/sbin/service crond start
/etc/init.d/crond start
service crond restart
service dropbear restart
service stunnel restart
#remove installer 
rm *.sh

echo '#############################################
#      CENTOS 6 Setup openvpn with ssl/ssh  #
#         Authentication file system        #
#       Setup by: Anthony Stark             #
#          Server System: STARK VPN         #
#            owner: STARKDEV VPN TEAM      #
#############################################';
