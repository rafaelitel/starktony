#!/bin/sh

# Script Created by STARKDEVTEAM <https://www.facebook.com/richel.ma.asawako>

# extract ip address
if [ -z "$1" ]; then
clear
echo
echo "Error: Payload not found! Please execute again with payload."
echo
echo "Example: $0<space><payloadhere>"
echo
echo "or execute the command like this."
echo
echo "$0 m.facebook.com"
echo
echo "Note: m.facebook.com payload is example."
echo
else
IPADDRESS=`ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{print $1}' | head -1`
IPADD="s/ipaddresxxx/$IPADDRESS/g";
# clean repo
apt-get clean
# update repo
apt-get update
# install needs
apt-get -y install stunnel4 apache2 openvpn easy-rsa ufw mysql-client

# stunnel
cd /etc/stunnel/
openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 -sha256 -subj '/CN=127.0.0.1/O=localhost/C=US' -keyout /etc/stunnel/stunnel.pem -out /etc/stunnel/stunnel.pem
sudo touch stunnel.conf
echo "client = no" > /etc/stunnel/stunnel.conf
echo "pid = /var/run/stunnel.pid" >> /etc/stunnel/stunnel.conf
echo "[openvpn]" >> /etc/stunnel/stunnel.conf
echo "accept = 8020" >> /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:1194" >> /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:1147" >> /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:8081" >> /etc/stunnel/stunnel.conf
echo "cert = /etc/stunnel/stunnel.pem" >> /etc/stunnel/stunnel.conf
sudo sed -i -e 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 8020 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp -m tcp --dport 3306 -j ACCEPT
sudo cp /etc/stunnel/stunnel.pem ~
echo "client = yes\ndebug = 6\n[openvpn]\naccept = 127.0.0.1:1194\nconnect = $IPADDRESS:8020\nTIMEOUTclose = 0\nverify = 0\nsni = $1" > /var/www/html/stunnel.conf
# openvpn
ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime
#change this according to your database details
#Note: Password w/ Special Characters are not allowed.
dbhost='185.61.137.168';
dbuser='tonystar1_tonystarkvpnml';
dbpass='tonystarkvpnml';
dbname='tonystar1_tonystark-vpn.ml';
dbport='3306';
#ethernet cable openvz default ethernet is venet0
ethernet='eth0';
#squid multi ports
squidport='8080';
squidport1='8989';
squidport2='8000';
##certificates
cacert='-----BEGIN CERTIFICATE-----
MIIDXDCCAsWgAwIBAgIJAIeyMb72wnZ5MA0GCSqGSIb3DQEBBQUAMH0xCzAJBgNV
BAYTAlBIMRAwDgYDVQQIEwdaZWRkVlBOMQ8wDQYDVQQHEwZNQU5JTEExEDAOBgNV
BAoTB1plZGRWUE4xEzARBgNVBAMTClplZGRWUE4gQ0ExJDAiBgkqhkiG9w0BCQEW
FVplZGRWUE4yMDE3QGdtYWlsLmNvbTAeFw0xNzEwMjQxNTA3NDhaFw0yNzEwMjIx
NTA3NDhaMH0xCzAJBgNVBAYTAlBIMRAwDgYDVQQIEwdaZWRkVlBOMQ8wDQYDVQQH
EwZNQU5JTEExEDAOBgNVBAoTB1plZGRWUE4xEzARBgNVBAMTClplZGRWUE4gQ0Ex
JDAiBgkqhkiG9w0BCQEWFVplZGRWUE4yMDE3QGdtYWlsLmNvbTCBnzANBgkqhkiG
9w0BAQEFAAOBjQAwgYkCgYEAucyfZTELp1YY2fW1nxpjkYkplzJkWoqfEWQ2YUef
ZLIyY7pXGsnAKq+oN8kw4pJks4quC3mM7wTRC45VanKdkvSM5tgTwFFS8fA2s6Sg
5Nr9NoILlRK6K0tVb8g6KsXW+kzWgMUREWVHtQ+0pLK9b1K4tZx0/nHOpsigO11/
4lkCAwEAAaOB4zCB4DAdBgNVHQ4EFgQUpdCYQGiszZrdphE3R17mtIyybMwwgbAG
A1UdIwSBqDCBpYAUpdCYQGiszZrdphE3R17mtIyybMyhgYGkfzB9MQswCQYDVQQG
EwJQSDEQMA4GA1UECBMHWmVkZFZQTjEPMA0GA1UEBxMGTUFOSUxBMRAwDgYDVQQK
EwdaZWRkVlBOMRMwEQYDVQQDEwpaZWRkVlBOIENBMSQwIgYJKoZIhvcNAQkBFhVa
ZWRkVlBOMjAxN0BnbWFpbC5jb22CCQCHsjG+9sJ2eTAMBgNVHRMEBTADAQH/MA0G
CSqGSIb3DQEBBQUAA4GBAC0QvhRhIBCTRPZ7EDgAujMVZW5iIYZYfGfC7JMZJv6j
3nwt1EDea1rYkuphSiX1G04o1ZDLFt3JuIFrs4N+NIVdVt06x7M75Re6ZYu3gTFS
XPA2jNn5vBm+Fi6x4kgFQPigngq3G44fvMJwTUubViWJ2EAb5FmgPG6zJdSLG+g5
-----END CERTIFICATE-----';
servercert='Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 1 (0x1)
    Signature Algorithm: sha1WithRSAEncryption
        Issuer: C=PH, ST=ZeddVPN, L=MANILA, O=ZeddVPN, CN=ZeddVPN CA/emailAddress=ZeddVPN2017@gmail.com
        Validity
            Not Before: Oct 24 15:08:07 2017 GMT
            Not After : Oct 22 15:08:07 2027 GMT
        Subject: C=PH, ST=ZeddVPN, L=MANILA, O=ZeddVPN, CN=server/emailAddress=ZeddVPN2017@gmail.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (1024 bit)
                Modulus:
                    00:d8:4f:bb:85:7c:d0:31:9c:b2:78:20:c7:8f:54:
                    28:54:da:89:f9:59:3c:40:ef:2d:ef:05:95:5d:c8:
                    c8:63:db:fa:e9:c0:b8:40:6e:84:11:60:3c:69:f4:
                    eb:32:a9:30:ce:fa:8e:11:7c:cc:79:4a:66:1d:c3:
                    25:63:21:76:4e:83:2b:7e:95:90:88:fa:94:91:16:
                    f3:47:a0:4f:e0:b2:45:d1:f4:92:16:43:81:95:fe:
                    fe:f1:61:b8:d7:35:bb:cc:14:c7:1c:78:4d:54:09:
                    92:d2:b0:8a:f0:9f:bc:e3:c8:52:56:ff:9f:73:4a:
                    8e:34:3a:8c:40:28:4d:0e:6b
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Basic Constraints: 
                CA:FALSE
            Netscape Cert Type: 
                SSL Server
            Netscape Comment: 
                Easy-RSA Generated Server Certificate
            X509v3 Subject Key Identifier: 
                D2:75:59:CF:0E:1F:65:F2:04:7E:2F:B5:B2:F3:FE:16:B3:94:4F:CA
            X509v3 Authority Key Identifier: 
                keyid:A5:D0:98:40:68:AC:CD:9A:DD:A6:11:37:47:5E:E6:B4:8C:B2:6C:CC
                DirName:/C=PH/ST=ZeddVPN/L=MANILA/O=ZeddVPN/CN=ZeddVPN CA/emailAddress=ZeddVPN2017@gmail.com
                serial:87:B2:31:BE:F6:C2:76:79

            X509v3 Extended Key Usage: 
                TLS Web Server Authentication
            X509v3 Key Usage: 
                Digital Signature, Key Encipherment
    Signature Algorithm: sha1WithRSAEncryption
         17:b9:23:84:8e:96:47:d0:5e:7f:bd:38:c3:77:93:21:a7:a9:
         12:f6:7f:c7:c7:0c:02:a0:72:53:b7:d5:82:6f:d4:3c:94:3d:
         79:2d:69:e1:20:a6:11:09:3f:c7:d0:ef:e6:51:48:e8:81:39:
         e4:58:7c:d7:12:89:79:64:e3:3f:2d:46:2e:d3:c2:29:cf:ed:
         13:70:81:d2:fe:18:ee:c2:8a:fd:6c:63:9a:d2:81:65:9c:9d:
         c4:20:28:bc:d3:15:c2:80:80:d9:42:ae:9f:19:80:70:48:5e:
         f6:6c:92:46:84:d2:ec:4e:ae:bb:60:46:40:fb:58:39:35:0e:
         b0:bd
-----BEGIN CERTIFICATE-----
MIIDujCCAyOgAwIBAgIBATANBgkqhkiG9w0BAQUFADB9MQswCQYDVQQGEwJQSDEQ
MA4GA1UECBMHWmVkZFZQTjEPMA0GA1UEBxMGTUFOSUxBMRAwDgYDVQQKEwdaZWRk
VlBOMRMwEQYDVQQDEwpaZWRkVlBOIENBMSQwIgYJKoZIhvcNAQkBFhVaZWRkVlBO
MjAxN0BnbWFpbC5jb20wHhcNMTcxMDI0MTUwODA3WhcNMjcxMDIyMTUwODA3WjB5
MQswCQYDVQQGEwJQSDEQMA4GA1UECBMHWmVkZFZQTjEPMA0GA1UEBxMGTUFOSUxB
MRAwDgYDVQQKEwdaZWRkVlBOMQ8wDQYDVQQDEwZzZXJ2ZXIxJDAiBgkqhkiG9w0B
CQEWFVplZGRWUE4yMDE3QGdtYWlsLmNvbTCBnzANBgkqhkiG9w0BAQEFAAOBjQAw
gYkCgYEA2E+7hXzQMZyyeCDHj1QoVNqJ+Vk8QO8t7wWVXcjIY9v66cC4QG6EEWA8
afTrMqkwzvqOEXzMeUpmHcMlYyF2ToMrfpWQiPqUkRbzR6BP4LJF0fSSFkOBlf7+
8WG41zW7zBTHHHhNVAmS0rCK8J+848hSVv+fc0qONDqMQChNDmsCAwEAAaOCAUww
ggFIMAkGA1UdEwQCMAAwEQYJYIZIAYb4QgEBBAQDAgZAMDQGCWCGSAGG+EIBDQQn
FiVFYXN5LVJTQSBHZW5lcmF0ZWQgU2VydmVyIENlcnRpZmljYXRlMB0GA1UdDgQW
BBTSdVnPDh9l8gR+L7Wy8/4Ws5RPyjCBsAYDVR0jBIGoMIGlgBSl0JhAaKzNmt2m
ETdHXua0jLJszKGBgaR/MH0xCzAJBgNVBAYTAlBIMRAwDgYDVQQIEwdaZWRkVlBO
MQ8wDQYDVQQHEwZNQU5JTEExEDAOBgNVBAoTB1plZGRWUE4xEzARBgNVBAMTClpl
ZGRWUE4gQ0ExJDAiBgkqhkiG9w0BCQEWFVplZGRWUE4yMDE3QGdtYWlsLmNvbYIJ
AIeyMb72wnZ5MBMGA1UdJQQMMAoGCCsGAQUFBwMBMAsGA1UdDwQEAwIFoDANBgkq
hkiG9w0BAQUFAAOBgQAXuSOEjpZH0F5/vTjDd5Mhp6kS9n/HxwwCoHJTt9WCb9Q8
lD15LWnhIKYRCT/H0O/mUUjogTnkWHzXEol5ZOM/LUYu08Ipz+0TcIHS/hjuwor9
bGOa0oFlnJ3EICi80xXCgIDZQq6fGYBwSF72bJJGhNLsTq67YEZA+1g5NQ6wvQ==
-----END CERTIFICATE-----';
serverkey='-----BEGIN PRIVATE KEY-----
MIICeQIBADANBgkqhkiG9w0BAQEFAASCAmMwggJfAgEAAoGBANhPu4V80DGcsngg
x49UKFTaiflZPEDvLe8FlV3IyGPb+unAuEBuhBFgPGn06zKpMM76jhF8zHlKZh3D
JWMhdk6DK36VkIj6lJEW80egT+CyRdH0khZDgZX+/vFhuNc1u8wUxxx4TVQJktKw
ivCfvOPIUlb/n3NKjjQ6jEAoTQ5rAgMBAAECgYEAyEVB4/xEMbrXjdsjiHMtiCpx
1helbqVDjOpJeXQ8/B+edq+Ep7rqsb+9D4i//b6hvvBBerVmBuI4G1QjGF3RznlO
zXrVP3I15/cLl/J3CN5vYesGqfyzoXdWiDBxhXcgq9Q7Ya8G0rGQWQXUVkv0ZOpg
rwzoLY8uwOETDHaW2PECQQDwmVXWS5zPCe0ePgiFfbSFf8SmznbXxxsSUOXTJmzg
jP0q5WYf/YywuZjCKQu9FTK6rF2en6fHj+J5HSw73hiZAkEA5ihmnfPTp8hy81BN
H9zjN4bnXlNjH+ncCf1cfLBFE2CoGlUe8CDSXITZ3MZVIMgzNUaEHJ/GjYKe1IRb
Q+StowJBAMO2FyrQKugHTQiysT/VN0j428BMZkOzxIOrpqeRtDMcvLtuCxqupwkC
kA4wUUonujI7D5R+jn44vqKCZn70dNECQQDkFfeT4tXG+aPJMrQrtmhKV9ukI7kh
IE3abIYiX0ElMe2FowN07uHppBKPctFcGmp9CnPUNha7mE20x7H2N4JHAkEA05W5
hW8kL5ux7r/sn5qpaB4sM3VI/IzcQdYJrEQIvkO/Q/wExT+1ajBoRwr5OC6FBo24
7zA0lrXYYg30B0RAbw==
-----END PRIVATE KEY-----';
dh='-----BEGIN DH PARAMETERS-----
MIGHAoGBAKmcS1oOzeAt8IVdnQ0GttU2vBADXzJKud0x8X/+d/1K3f83+K2Z9qi8
2ZaYo8nJsCXCQvoU7oFxYA9A9WQ291UNvLOdDCVo0u6NsCbfF7s9Nk+Yxh40kPmA
zByKIgWIy/KKWpH7p8HTGL6yWBFHbR77uZghUNXDhEoCant0J+HzAgEC
-----END DH PARAMETERS-----';

echo 'Initializing please wait..'

## making script and keys
mkdir /etc/openvpn/script
mkdir /etc/openvpn/log
mkdir /etc/openvpn/keys
mkdir /var/www/html/status
touch /var/www/html/status/tcp2.txt
cat << EOF > /etc/openvpn/keys/ca.crt
$cacert
EOF

cat << EOF > /etc/openvpn/keys/server.crt
$servercert
EOF

cat << EOF > /etc/openvpn/keys/server.key
$serverkey
EOF

cat << EOF > /etc/openvpn/keys/dh1024.pem
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

/bin/cat <<"EOM" >/etc/openvpn/script/connect.sh
#!/bin/bash
. /etc/openvpn/script/config.sh
##insert data connection to table log
mysql -h$HOST -P$PORT -u$USER -p$PASS $DB -e "INSERT INTO log (log_id,user_id,log_trusted_ip,log_trusted_port,log_remote_ip,log_remote_port,log_start_time,log_end_time,log_received,log_send) VALUES(NULL,'$common_name','$trusted_ip','$trusted_port','$ifconfig_pool_remote_ip','$remote_port_1',now(),'0000-00-00 00:00:00','$bytes_received','$bytes_sent')"
##set status online to user connected
mysql -h$HOST -P$PORT -u$USER -p$PASS $DB -e "UPDATE tbl_user SET user_online=1, connected_at='$trusted_ip' WHERE username='$common_name'"

EOM

/bin/cat <<"EOM" >/etc/openvpn/script/disconnect.sh
#!/bin/bash
. /etc/openvpn/script/config.sh
##set status offline to user disconnected
mysql -h$HOST -P$PORT -u$USER -p$PASS $DB -e "UPDATE tbl_user SET user_online=0 WHERE username='$common_name'"
##insert data disconnected to table log
mysql -h$HOST -P$PORT -u$USER -p$PASS $DB -e "UPDATE log SET log_end_time=now(),log_received='$bytes_received',log_send='$bytes_sent' WHERE log_trusted_ip='$trusted_ip' AND log_trusted_port='$trusted_port' AND user_id='$common_name' AND log_end_time='0000-00-00 00:00:00'"

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
# setting server
cat << EOF > /etc/openvpn/server.conf
##protocol port
port 443
proto tcp
dev tun0
 
##ip server client
server 10.8.0.0 255.255.255.0
 
##key
ca /etc/openvpn/keys/ca.crt
cert /etc/openvpn/keys/server.crt
key /etc/openvpn/keys/server.key
dh /etc/openvpn/keys/dh1024.pem
cipher AES-128-CBC 
auth SHA256
tun-mtu 1470
tun-mtu-extra 32
mssfix 1430
 
##option
persist-key
persist-tun
keepalive 10 120 
reneg-sec 432000
 
##option authen.
comp-lzo
user nobody
#group nogroup
client-to-client
username-as-common-name
client-cert-not-required
auth-user-pass-verify /etc/openvpn/script/login.sh via-env
 
##push to client
max-clients 50
push "persist-key"
push "persist-tun"
push "redirect-gateway def1"
#push "explicit-exit-notify 1"
 
##DNS-Server
push "dhcp-option DNS 1.1.1.1"
push "dhcp-option DNS 1.0.0.1"
 
##script connect-disconnect
script-security 3
client-connect /etc/openvpn/script/connect.sh
client-disconnect /etc/openvpn/script/disconnect.sh
 
##log-status
status /etc/openvpn/log/tcp_443.log
log-append /etc/openvpn/log/openvpn.log
verb 3
EOF

cat << EOF > /etc/openvpn/server2.conf
##protocol port
port 1194
proto tcp
dev tun1
 
##ip server client
server 10.4.0.0 255.255.255.0
 
##key
ca /etc/openvpn/keys/ca.crt
cert /etc/openvpn/keys/server.crt
key /etc/openvpn/keys/server.key
dh /etc/openvpn/keys/dh1024.pem
cipher AES-128-CBC 
auth SHA256
tun-mtu 1470
tun-mtu-extra 32
mssfix 1430
 
##option
persist-key
persist-tun
keepalive 10 120 
reneg-sec 432000
 
##option authen.
comp-lzo
user nobody
#group nogroup
client-to-client
username-as-common-name
client-cert-not-required
auth-user-pass-verify /etc/openvpn/script/login.sh via-env
 
##push to client
max-clients 50
push "persist-key"
push "persist-tun"
push "redirect-gateway def1"
#push "explicit-exit-notify 1"
 
##DNS-Server
push "dhcp-option DNS 1.1.1.1"
push "dhcp-option DNS 1.0.0.1"
 
##script connect-disconnect
script-security 3
client-connect /etc/openvpn/script/connect.sh
client-disconnect /etc/openvpn/script/disconnect.sh
 
##log-status
status /etc/openvpn/log/tcp_1194.log
log-append /etc/openvpn/log/openvpn.log
verb 3
EOF

cat << EOF > /etc/openvpn/server3.conf
##protocol port
port 1147
proto tcp
dev tun2
 
##ip server client
server 10.5.0.0 255.255.255.0
 
##key
ca /etc/openvpn/keys/ca.crt
cert /etc/openvpn/keys/server.crt
key /etc/openvpn/keys/server.key
dh /etc/openvpn/keys/dh1024.pem
cipher AES-128-CBC 
auth SHA256
tun-mtu 1470
tun-mtu-extra 32
mssfix 1430
 
##option
persist-key
persist-tun
keepalive 10 120 
reneg-sec 432000
 
##option authen.
comp-lzo
user nobody
#group nogroup
client-to-client
username-as-common-name
client-cert-not-required
auth-user-pass-verify /etc/openvpn/script/login.sh via-env
 
##push to client
max-clients 50
push "persist-key"
push "persist-tun"
push "redirect-gateway def1"
#push "explicit-exit-notify 1"
 
##DNS-Server
push "dhcp-option DNS 1.1.1.1"
push "dhcp-option DNS 1.0.0.1"
 
##script connect-disconnect
script-security 3
client-connect /etc/openvpn/script/connect.sh
client-disconnect /etc/openvpn/script/disconnect.sh
 
##log-status
status /etc/openvpn/log/tcp_1147.log
log-append /etc/openvpn/log/openvpn.log
verb 3
EOF

cat << EOF > /etc/openvpn/server4.conf
##protocol port
port 8081
proto tcp
dev tun3
 
##ip server client
server 192.168.0.0 255.255.255.0
 
##key
ca /etc/openvpn/keys/ca.crt
cert /etc/openvpn/keys/server.crt
key /etc/openvpn/keys/server.key
dh /etc/openvpn/keys/dh1024.pem
cipher AES-128-CBC 
auth SHA256
tun-mtu 1470
tun-mtu-extra 32
mssfix 1430
 
##option
persist-key
persist-tun
keepalive 10 120 
reneg-sec 432000
 
##option authen.
comp-lzo
user nobody
#group nogroup
client-to-client
username-as-common-name
client-cert-not-required
auth-user-pass-verify /etc/openvpn/script/login.sh via-env
 
##push to client
max-clients 50
push "persist-key"
push "persist-tun"
push "redirect-gateway def1"
#push "explicit-exit-notify 1"
 
##DNS-Server
push "dhcp-option DNS 1.1.1.1"
push "dhcp-option DNS 1.0.0.1"
 
##script connect-disconnect
script-security 3
client-connect /etc/openvpn/script/connect.sh
client-disconnect /etc/openvpn/script/disconnect.sh
 
##log-status
status /etc/openvpn/log/tcp_8081.log
log-append /etc/openvpn/log/openvpn.log
verb 3
EOF

# create openvpn config
cat > /var/www/html/openvpn.ovpn <<-END
client
dev tun
proto tcp
remote $IPADDRESS:1194@$1 1194
cipher AES-128-CBC 
auth SHA256
tun-mtu 1470
tun-mtu-extra 32
mssfix 1430
nobind
verb 3
auth-user-pass
reneg-sec 432000
resolv-retry infinite
comp-lzo
keepalive 5 60
http-proxy $IPADDRESS 8080
http-proxy-option CUSTOM-HEADER CONNECT HTTP/1.0
http-proxy-option CUSTOM-HEADER Host $1
http-proxy-option CUSTOM-HEADER X-Online-Host $1
http-proxy-option CUSTOM-HEADER X-Forward-Host $1
http-proxy-option CUSTOM-HEADER Connection keep-alive
http-proxy-option CUSTOM-HEADER Proxy-Connection keep-alive
http-proxy-retry

END
echo '<ca>' >> /var/www/html/openvpn.ovpn
cat /etc/openvpn/ca.crt >> /var/www/html/openvpn.ovpn
echo '</ca>' >> /var/www/html/openvpn.ovpn
# create openvpn config with stunnel
cat > /var/www/html/openvpnssl.ovpn <<-END
client
dev tun
proto tcp
remote 127.0.0.1 1194
cipher AES-128-CBC 
auth SHA256
tun-mtu 1470
tun-mtu-extra 32
mssfix 1430
nobind
verb 3
auth-user-pass
reneg-sec 432000
resolv-retry infinite
comp-lzo
keepalive 5 60
route $IPADDRESS 255.255.255.255 net_gateway
route-method exe
route-delay 2

END
echo '<ca>' >> /var/www/html/openvpnssl.ovpn
cat /etc/openvpn/ca.crt >> /var/www/html/openvpnssl.ovpn
echo '</ca>' >> /var/www/html/openvpnssl.ovpn
# compress config
cd /var/www/html/
tar -zcvf /var/www/html/openvpn.tgz openvpn.ovpn openvpnssl.ovpn stunnel.conf
# install squid3
apt-get -y install squid3
cat > /etc/squid3/squid.conf <<-END

acl localnet src 10.0.0.0/8	# RFC1918 possible internal network
acl localnet src 172.16.0.0/12	# RFC1918 possible internal network
acl localnet src 192.168.0.0/16	# RFC1918 possible internal network
acl localnet src fc00::/7       # RFC 4193 local private network range
acl localnet src fe80::/10      # RFC 4291 link-local (directly plugged) machines

acl extensiondeny dstdomain -i "/etc/squid/extensiondeny.txt"
acl download method GET
http_access deny extensiondeny download
http_access deny extensiondeny
acl ads dstdomain -i "/etc/squid/ads.txt"
acl malware dstdomain -i "/etc/squid/malware.txt"
http_access deny ads
http_access deny malware

acl phnet src 1.37.0.0-1.37.255.255
acl phnet src 27.108.0.0-27.108.255.255
acl phnet src 27.109.64.0-27.109.95.255
acl phnet src 27.110.128.0-27.110.255.255
acl phnet src 27.123.224.0-27.123.255.255
acl phnet src 27.124.64.0-27.124.79.255
acl phnet src 49.144.0.0-49.151.255.255
acl phnet src 49.157.0.0-49.157.255.255
acl phnet src 58.69.0.0-58.69.255.255
acl phnet src 58.71.0.0-58.71.127.255
acl phnet src 61.9.0.0-61.9.127.255
acl phnet src 61.28.128.0-61.28.191.255
acl phnet src 101.78.16.0-101.78.31.255
acl phnet src 110.44.96.0-110.44.111.255
acl phnet src 110.44.128.0-110.44.143.255
acl phnet src 110.50.224.0-110.50.239.255
acl phnet src 110.54.128.0-110.54.255.255
acl phnet src 110.55.0.0-110.55.255.255
acl phnet src 110.93.64.0-110.93.95.255
acl phnet src 110.232.160.0-110.232.175.255
acl phnet src 111.68.32.0-111.68.63.255
acl phnet src 111.125.64.0-111.125.127.255
acl phnet src 111.235.80.0-111.235.95.255
acl phnet src 112.78.48.0-112.78.63.255
acl phnet src 112.109.0.0-112.109.15.255
acl phnet src 112.196.224.0-112.196.255.255
acl phnet src 112.198.0.0-112.198.255.255
acl phnet src 112.199.0.0-112.199.127.255
acl phnet src 112.200.0.0-112.207.255.255
acl phnet src 112.208.0.0-112.211.255.255
acl phnet src 113.20.160.0-113.20.191.255
acl phnet src 113.61.32.0-113.61.63.255
acl phnet src 114.108.192.0-114.108.255.255
acl phnet src 114.198.128.0-114.198.159.255
acl phnet src 115.84.224.0-115.84.255.255
acl phnet src 115.85.0.0-115.85.63.255
acl phnet src 115.146.128.0-115.146.255.255
acl phnet src 115.147.0.0-115.147.255.255
acl phnet src 116.50.128.0-116.50.255.255
acl phnet src 116.93.0.0-116.93.127.255
acl phnet src 117.58.192.0-117.58.223.255
acl phnet src 117.104.240.0-117.104.255.255
acl phnet src 119.63.0.0-119.63.15.255
acl phnet src 119.92.0.0-119.95.255.255
acl phnet src 119.111.0.0-119.111.255.255
acl phnet src 120.28.0.0-120.28.255.255
acl phnet src 120.29.64.0-120.29.127.255
acl phnet src 120.72.16.0-120.72.31.255
acl phnet src 120.89.0.0-120.89.63.255
acl phnet src 121.1.0.0-121.1.63.255
acl phnet src 121.54.0.0-121.54.127.255
acl phnet src 121.58.192.0-121.58.255.255
acl phnet src 121.96.0.0-121.97.255.255
acl phnet src 121.127.0.0-121.127.31.255
acl phnet src 122.2.0.0-122.3.255.255
acl phnet src 122.49.208.0-122.49.223.255
acl phnet src 122.52.0.0-122.55.255.255
acl phnet src 122.144.64.0-122.144.127.255
acl phnet src 122.202.96.0-122.202.127.255
acl phnet src 123.108.112.0-123.108.127.255
acl phnet src 124.6.128.0-124.6.191.255
acl phnet src 124.19.128.0-124.19.255.255
acl phnet src 124.83.0.0-124.83.127.255
acl phnet src 124.104.0.0-124.107.255.255
acl phnet src 124.158.32.0-124.158.63.255
acl phnet src 124.217.0.0-124.217.127.255
acl phnet src 125.5.0.0-125.5.255.255
acl phnet src 125.60.128.0-125.60.255.255
acl phnet src 125.212.0.0-125.212.127.255
acl phnet src 130.105.0.0-130.105.255.255
acl phnet src 146.88.64.0-146.88.79.255
acl phnet src 165.220.0.0-165.220.255.255
acl phnet src 175.158.192.0-175.158.255.255
acl phnet src 175.176.0.0-175.176.127.255
acl phnet src 180.94.0.0-180.94.31.255
acl phnet src 180.190.0.0-180.191.255.255
acl phnet src 180.192.0.0-180.195.255.255
acl phnet src 180.232.0.0-180.232.255.255
acl phnet src 182.18.192.0-182.18.255.255
acl phnet src 182.54.128.0-182.54.159.255
acl phnet src 183.182.64.0-183.182.79.255
acl phnet src 202.0.16.0-202.0.31.255
acl phnet src 202.4.0.0-202.4.15.255
acl phnet src 202.5.16.0-202.5.31.255
acl phnet src 202.8.224.0-202.8.255.255
acl phnet src 202.52.160.0-202.52.175.255
acl phnet src 202.57.32.0-202.57.63.255
acl phnet src 202.57.64.0-202.57.95.255
acl phnet src 202.57.96.0-202.57.127.255
acl phnet src 202.65.176.0-202.65.191.255
acl phnet src 202.69.160.0-202.69.175.255
acl phnet src 202.69.176.0-202.69.191.255
acl phnet src 202.71.176.0-202.71.191.255
acl phnet src 202.73.160.0-202.73.175.255
acl phnet src 202.78.64.0-202.78.95.255
acl phnet src 202.78.96.0-202.78.127.255
acl phnet src 202.81.160.0-202.81.175.255
acl phnet src 202.84.96.0-202.84.111.255
acl phnet src 202.84.112.0-202.84.127.255
acl phnet src 202.86.192.0-202.86.207.255
acl phnet src 202.89.192.0-202.89.207.255
acl phnet src 202.90.128.0-202.90.159.255
acl phnet src 202.91.160.0-202.91.175.255
acl phnet src 202.92.128.0-202.92.159.255
acl phnet src 202.95.224.0-202.95.239.255
acl phnet src 202.123.48.0-202.123.63.255
acl phnet src 202.124.128.0-202.124.143.255
acl phnet src 202.124.144.0-202.124.159.255
acl phnet src 202.126.32.0-202.126.47.255
acl phnet src 202.128.32.0-202.128.63.255
acl phnet src 202.133.192.0-202.133.207.255
acl phnet src 202.133.208.0-202.133.223.255
acl phnet src 202.137.112.0-202.137.127.255
acl phnet src 202.138.128.0-202.138.159.255
acl phnet src 202.138.160.0-202.138.191.255
acl phnet src 202.162.160.0-202.162.175.255
acl phnet src 202.163.192.0-202.163.207.255
acl phnet src 202.163.208.0-202.163.223.255
acl phnet src 202.163.224.0-202.163.255.255
acl phnet src 202.164.160.0-202.164.191.255
acl phnet src 202.175.192.0-202.175.223.255
acl phnet src 202.175.224.0-202.175.255.255
acl phnet src 202.183.32.0-202.183.47.255
acl phnet src 203.76.192.0-203.76.207.255
acl phnet src 203.82.32.0-203.82.47.255
acl phnet src 203.84.160.0-203.84.191.255
acl phnet src 203.87.128.0-203.87.159.255
acl phnet src 203.87.160.0-203.87.191.255
acl phnet src 203.87.192.0-203.87.255.255
acl phnet src 203.104.64.0-203.104.95.255
acl phnet src 203.111.224.0-203.111.239.255
acl phnet src 203.115.128.0-203.115.191.255
acl phnet src 203.131.64.0-203.131.79.255
acl phnet src 203.131.80.0-203.131.95.255
acl phnet src 203.131.96.0-203.131.127.255
acl phnet src 203.131.128.0-203.131.191.255
acl phnet src 203.160.160.0-203.160.191.255
acl phnet src 203.167.64.0-203.167.95.255
acl phnet src 203.167.96.0-203.167.127.255
acl phnet src 203.172.16.0-203.172.31.255
acl phnet src 203.177.16.0-203.177.31.255
acl phnet src 203.177.48.0-203.177.63.255
acl phnet src 203.177.64.0-203.177.79.255
acl phnet src 203.177.96.0-203.177.127.255
acl phnet src 203.177.128.0-203.177.191.255
acl phnet src 203.177.192.0-203.177.223.255
acl phnet src 203.177.224.0-203.177.239.255
acl phnet src 203.213.192.0-203.213.223.255
acl phnet src 203.215.64.0-203.215.95.255
acl phnet src 203.215.96.0-203.215.127.255
acl phnet src 206.131.192.0-206.131.207.255
acl phnet src 210.1.64.0-210.1.95.255
acl phnet src 210.1.96.0-210.1.127.255
acl phnet src 210.1.128.0-210.1.143.255
acl phnet src 210.4.0.0-210.4.63.255
acl phnet src 210.4.96.0-210.4.127.255
acl phnet src 210.5.64.0-210.5.127.255
acl phnet src 210.14.0.0-210.14.31.255
acl phnet src 210.14.32.0-210.14.47.255
acl phnet src 210.16.0.0-210.16.63.255
acl phnet src 210.23.96.0-210.23.127.255
acl phnet src 210.23.160.0-210.23.175.255
acl phnet src 210.23.176.0-210.23.191.255
acl phnet src 210.23.192.0-210.23.223.255
acl phnet src 210.23.224.0-210.23.255.255
acl phnet src 210.185.160.0-210.185.191.255
acl phnet src 210.213.64.0-210.213.127.255
acl phnet src 210.213.128.0-210.213.191.255
acl phnet src 210.213.192.0-210.213.255.255
acl phnet src 219.90.80.0-219.90.95.255
acl phnet src 221.121.96.0-221.121.127.255
acl phnet src 222.126.0.0-222.126.127.255
acl phnet src 222.127.0.0-222.127.127.255
acl phnet src 222.127.128.0-222.127.255.255
acl phnet src 223.25.0.0-223.25.63.255

acl SSL_ports port 443
acl SSL_ports port 992
acl SSL_ports port 995
acl SSL_ports port 5555
acl SSL_ports port 80
acl Safe_ports port 80		# http
acl Safe_ports port 21		# ftp
acl Safe_ports port 443		# https
acl Safe_ports port 70		# gopher
acl Safe_ports port 210		# wais
acl Safe_ports port 1025-65535	# unregistered ports
acl Safe_ports port 280		# http-mgmt
acl Safe_ports port 488		# gss-http
acl Safe_ports port 591		# filemaker
acl Safe_ports port 777		# multiling http
acl Safe_ports port 992		# mail
acl Safe_ports port 995		# mail
acl CONNECT method CONNECT

acl vpnservers dst ipaddresxxx
acl vpnservers dst 127.0.0.1
acl vpnserv dstdomain ipaddresxxx

acl sonyshit dstdomain account.sonyentertainmentnetwork.com
acl sonyshit dstdomain auth.np.ac.playstation.net
acl sonyshit dstdomain auth.api.sonyentertainmentnetwork.com
acl sonyshit dstdomain auth.api.np.ac.playstation.net
acl sonyshit dstdomain playstation.net
acl sonyshit dstdomain sonyentertainmentnetwork.com

http_access allow !Safe_ports
http_access allow CONNECT !SSL_ports
http_access allow localhost manager
http_access allow localnet
http_access allow localhost
http_access allow phnet
http_access allow vpnserv
http_access allow vpnservers
http_access deny sonyshit
http_access deny !vpnserv
http_access deny !vpnservers
http_access deny manager
http_access deny all

http_port 0.0.0.0:8080
http_port 0.0.0.0:8000
http_port 0.0.0.0:8888
http_port 0.0.0.0:9999
http_port 0.0.0.0:8989
http_port 0.0.0.0:3128
END
sed -i $IPADD /etc/squid3/squid.conf;

#denying ads
cat << EOF > /etc/squid3/ads.txt
101com.com
101order.com
123found.com
180hits.de
180searchassistant.com
207.net
247media.com
24log.com
24log.de
24pm-affiliation.com
2mdn.net
2o7.net
360yield.com
4affiliate.net
4d5.net
50websads.com
518ad.com
51yes.com
600z.com
777partner.com
77tracking.com
7bpeople.com
7search.com
99count.com
a-ads.com
a-counter.kiev.ua
a.0day.kiev.ua
a.aproductmsg.com
a.collective-media.net
a.consumer.net
a.mktw.net
a.sakh.com
a.ucoz.net
a.ucoz.ru
a.xanga.com
a32.g.a.yimg.com
aaddzz.com
abacho.net
abc-ads.com
absoluteclickscom.com
abz.com
ac.rnm.ca
accounts.pkr.com.invalid
acsseo.com
actionsplash.com
actualdeals.com
acuityads.com
ad-balancer.at
ad-balancer.net
ad-center.com
ad-pay.de
ad-rotator.com
ad-server.gulasidorna.se
ad-serverparc.nl
ad-souk.com
ad-space.net
ad-tech.com
ad-up.com
ad.100.tbn.ru
ad.71i.de
ad.a8.net
ad.abcnews.com
ad.abctv.com
ad.aboutwebservices.com
ad.abum.com
ad.afy11.net
ad.allstar.cz
ad.altervista.org
ad.amgdgt.com
ad.anuntis.com
ad.auditude.com
ad.bizo.com
ad.bnmla.com
ad.bondage.com
ad.caradisiac.com
ad.centrum.cz
ad.cgi.cz
ad.choiceradio.com
ad.clix.pt
ad.cooks.com
ad.crwdcntrl.net
ad.digitallook.com
ad.directrev.com
ad.doctissimo.fr
ad.domainfactory.de
ad.e-kolay.net
ad.eurosport.com
ad.f1cd.ru
ad.flurry.com
ad.foxnetworks.com
ad.freecity.de
ad.gate24.ch
ad.globe7.com
ad.grafika.cz
ad.hbv.de
ad.hodomobile.com
ad.httpool.com
ad.hyena.cz
ad.iinfo.cz
ad.ilove.ch
ad.infoseek.com
ad.jamba.net
ad.jamster.co.uk
ad.jetsoftware.com
ad.keenspace.com
ad.leadbolt.net
ad.liveinternet.ru
ad.lupa.cz
ad.media-servers.net
ad.mediastorm.hu
ad.mgd.de
ad.musicmatch.com
ad.nachtagenten.de
ad.nozonedata.com
ad.nttnavi.co.jp
ad.nwt.cz
ad.onad.eu
ad.pandora.tv
ad.preferances.com
ad.profiwin.de
ad.prv.pl
ad.rambler.ru
ad.reunion.com
ad.scanmedios.com
ad.sensismediasmart.com.au
ad.seznam.cz
ad.simgames.net
ad.slutload.com
ad.smartclip.net
ad.tbn.ru
ad.technoratimedia.com
ad.thewheelof.com
ad.turn.com
ad.tv2.no
ad.twitchguru.com
ad.usatoday.com
ad.virtual-nights.com
ad.wavu.hu
ad.way.cz
ad.weatherbug.com
ad.wsod.com
ad.wz.cz
ad.yadro.ru
ad.yourmedia.com
ad.zanox.com
ad0.bigmir.net
ad01.mediacorpsingapore.com
ad1.emediate.dk
ad1.emule-project.org
ad1.kde.cz
ad1.pamedia.com.au
ad2.iinfo.cz
ad2.linxcz.cz
ad2.lupa.cz
ad2flash.com
ad2games.com
ad3.iinfo.cz
ad3.pamedia.com.au
ad4game.com
adaction.de
adadvisor.net
adap.tv
adapt.tv
adbanner.ro
adbard.net
adbers.com
adblade.com
adblockanalytics.com
adboost.de.vu
adboost.net
adbooth.net
adbot.com
adbrite.com
adbroker.de
adbunker.com
adbutler.com
adbutler.de
adbuyer.com
adbuyer3.lycos.com
adcash.com
adcast.deviantart.com
adcell.de
adcenter.mdf.se
adcenter.net
adcentriconline.com
adcept.net
adclick.com
adclient.uimserv.net
adclient1.tucows.com
adcomplete.com
adconion.com
adcontent.gamespy.com
adcycle.com
add.newmedia.cz
addealing.com
addfreestats.com
addme.com
adecn.com
ademails.com
adengage.com
adexpose.com
adext.inkclub.com
adf.ly
adfactor.nl
adfarm.mediaplex.com
adflight.com
adforce.com
adform.com
adgardener.com
adgoto.com
adgridwork.com
adhese.be
adhese.com
adimage.asiaone.com.sg
adimage.guardian.co.uk
adimages.been.com
adimages.carsoup.com
adimages.go.com
adimages.homestore.com
adimages.omroepzeeland.nl
adimages.sanomawsoy.fi
adimg.cnet.com
adimg.com.com
adimg.uimserv.net
adimg1.chosun.com
adimgs.sapo.pt
adimpact.com
adinjector.net
adinterax.com
adisfy.com
adition.com
adition.de
adition.net
adizio.com
adjix.com
adjug.com
adjuggler.com
adjuggler.yourdictionary.com
adjustnetwork.com
adk2.com
adk2ads.tictacti.com
adland.ru
adlantic.nl
adledge.com
adlegend.com
adlog.com.com
adloox.com
adlooxtracking.com
adlure.net
admagnet.net
admailtiser.com
adman.gr
adman.in.gr
adman.otenet.gr
admanagement.ch
admanager.btopenworld.com
admanager.carsoup.com
admarketplace.net
admarvel.com
admax.nexage.com
admedia.com
admedia.ro
admeld.com
admerize.be
admeta.com
admex.com
adminder.com
adminshop.com
admized.com
admob.com
admonitor.com
admotion.com.ar
adnet-media.net
adnet.asahi.com
adnet.biz
adnet.de
adnet.ru
adnet.worldreviewer.com
adnetinteractive.com
adnetwork.net
adnetworkperformance.com
adnews.maddog2000.de
adnotch.com
adnxs.com
adocean.pl
adonspot.com
adoperator.com
adorigin.com
adpepper.dk
adpepper.nl
adperium.com
adpia.vn
adplus.co.id
adplxmd.com
adprofile.net
adprojekt.pl
adq.nextag.com
adrazzi.com
adreactor.com
adrecreate.com
adremedy.com
adreporting.com
adres.internet.com
adrevolver.com
adriver.ru
adrolays.de
adrotate.de
adrotator.se
adrta.com
ads-click.com
ads.4tube.com
ads.5ci.lt
ads.abovetopsecret.com
ads.aceweb.net
ads.activestate.com
ads.adfox.ru
ads.administrator.de
ads.adshareware.net
ads.adultfriendfinder.com
ads.adultswim.com
ads.advance.net
ads.adverline.com
ads.affiliates.match.com
ads.ak.facebook.com.edgesuite.net
ads.allvatar.com
ads.alt.com
ads.amdmb.com
ads.amigos.com
ads.aol.co.uk
ads.aol.com
ads.apn.co.nz
ads.appsgeyser.com
ads.as4x.tmcs.net
ads.as4x.tmcs.ticketmaster.com
ads.asia1.com.sg
ads.asiafriendfinder.com
ads.ask.com
ads.aspalliance.com
ads.avazu.net
ads.batpmturner.com
ads.beenetworks.net
ads.belointeractive.com
ads.berlinonline.de
ads.betanews.com
ads.betfair.com
ads.betfair.com.au
ads.bigchurch.com
ads.bigfoot.com
ads.bing.com
ads.bittorrent.com
ads.blog.com
ads.bloomberg.com
ads.bluelithium.com
ads.bluemountain.com
ads.bluesq.com
ads.bonniercorp.com
ads.boylesports.com
ads.brabys.com
ads.brazzers.com
ads.bumq.com
ads.businessweek.com
ads.canalblog.com
ads.canoe.ca
ads.casinocity.com
ads.cbc.ca
ads.cc
ads.cc-dt.com
ads.centraliprom.com
ads.cgnetworks.com
ads.channel4.com
ads.clearchannel.com
ads.co.com
ads.com.com
ads.contactmusic.com
ads.contentabc.com
ads.contextweb.com
ads.crakmedia.com
ads.creative-serving.com
ads.creativematch.com
ads.cricbuzz.com
ads.cybersales.cz
ads.dada.it
ads.datinggold.com
ads.datingyes.com
ads.dazoot.ro
ads.deltha.hu
ads.dennisnet.co.uk
ads.desmoinesregister.com
ads.detelefoongids.nl
ads.deviantart.com
ads.digital-digest.com
ads.digitalmedianet.com
ads.digitalpoint.com
ads.directionsmag.com
ads.domeus.com
ads.eagletribune.com
ads.easy-forex.com
ads.eatinparis.com
ads.economist.com
ads.edbindex.dk
ads.egrana.com.br
ads.einmedia.com
ads.electrocelt.com
ads.elitetrader.com
ads.emirates.net.ae
ads.epltalk.com
ads.eu.msn.com
ads.exactdrive.com
ads.expat-blog.biz
ads.expedia.com
ads.ezboard.com
ads.factorymedia.com
ads.fairfax.com.au
ads.faxo.com
ads.ferianc.com
ads.filmup.com
ads.financialcontent.com
ads.flooble.com
ads.fool.com
ads.footymad.net
ads.forbes.com
ads.forbes.net
ads.forium.de
ads.fortunecity.com
ads.fotosidan.se
ads.foxkidseurope.net
ads.foxnetworks.com
ads.foxnews.com
ads.freecity.de
ads.friendfinder.com
ads.ft.com
ads.futurenet.com
ads.gamecity.net
ads.gamershell.com
ads.gamespyid.com
ads.gamigo.de
ads.gaming-universe.de
ads.gawker.com
ads.geekswithblogs.net
ads.glispa.com
ads.gmodules.com
ads.godlikeproductions.com
ads.goyk.com
ads.gplusmedia.com
ads.gradfinder.com
ads.grindinggears.com
ads.groundspeak.com
ads.gsm-exchange.com
ads.gsmexchange.com
ads.guardian.co.uk
ads.guardianunlimited.co.uk
ads.guru3d.com
ads.hardwaresecrets.com
ads.harpers.org
ads.hbv.de
ads.hearstmags.com
ads.heartlight.org
ads.heias.com
ads.hideyourarms.com
ads.hollywood.com
ads.horsehero.com
ads.horyzon-media.com
ads.iafrica.com
ads.ibest.com.br
ads.ibryte.com
ads.icq.com
ads.ign.com
ads.img.co.za
ads.imgur.com
ads.indiatimes.com
ads.infi.net
ads.internic.co.il
ads.ipowerweb.com
ads.isoftmarketing.com
ads.itv.com
ads.iwon.com
ads.jewishfriendfinder.com
ads.jiwire.com
ads.jobsite.co.uk
ads.jpost.com
ads.jubii.dk
ads.justhungry.com
ads.kaktuz.net
ads.kelbymediagroup.com
ads.kinobox.cz
ads.kinxxx.com
ads.kompass.com
ads.krawall.de
ads.lesbianpersonals.com
ads.linuxfoundation.org
ads.linuxjournal.com
ads.linuxsecurity.com
ads.livenation.com
ads.mariuana.it
ads.massinfra.nl
ads.mcafee.com
ads.mediaodyssey.com
ads.medienhaus.de
ads.mgnetwork.com
ads.mmania.com
ads.moceanads.com
ads.motor-forum.nl
ads.motormedia.nl
ads.msn.com
ads.multimania.lycos.fr
ads.nationalgeographic.com
ads.ncm.com
ads.netclusive.de
ads.netmechanic.com
ads.networksolutions.com
ads.newdream.net
ads.newgrounds.com
ads.newmedia.cz
ads.newsint.co.uk
ads.newsquest.co.uk
ads.ninemsn.com.au
ads.nj.com
ads.nola.com
ads.nordichardware.com
ads.nordichardware.se
ads.nwsource.com
ads.nyi.net
ads.nytimes.com
ads.nyx.cz
ads.nzcity.co.nz
ads.o2.pl
ads.oddschecker.com
ads.okcimg.com
ads.ole.com
ads.olivebrandresponse.com
ads.oneplace.com
ads.ookla.com
ads.optusnet.com.au
ads.outpersonals.com
ads.passion.com
ads.pennet.com
ads.penny-arcade.com
ads.pheedo.com
ads.phpclasses.org
ads.pickmeup-ltd.com
ads.planet.nl
ads.pni.com
ads.pof.com
ads.powweb.com
ads.primissima.it
ads.printscr.com
ads.prisacom.com
ads.program3.com
ads.psd2html.com
ads.pushplay.com
ads.quoka.de
ads.rcs.it
ads.recoletos.es
ads.rediff.com
ads.redlightcenter.com
ads.redtube.com
ads.resoom.de
ads.returnpath.net
ads.s3.sitepoint.com
ads.satyamonline.com
ads.savannahnow.com
ads.saymedia.com
ads.scifi.com
ads.seniorfriendfinder.com
ads.servebom.com
ads.sexinyourcity.com
ads.shizmoo.com
ads.shopstyle.com
ads.sift.co.uk
ads.silverdisc.co.uk
ads.slim.com
ads.smartclick.com
ads.soft32.com
ads.space.com
ads.sptimes.com
ads.stackoverflow.com
ads.sun.com
ads.supplyframe.com
ads.t-online.de
ads.tahono.com
ads.techtv.com
ads.telegraph.co.uk
ads.themovienation.com
ads.thestar.com
ads.tmcs.net
ads.totallyfreestuff.com
ads.townhall.com
ads.trinitymirror.co.uk
ads.tripod.com
ads.tripod.lycos.co.uk
ads.tripod.lycos.de
ads.tripod.lycos.es
ads.tripod.lycos.it
ads.tripod.lycos.nl
ads.tripod.spray.se
ads.tso.dennisnet.co.uk
ads.uknetguide.co.uk
ads.ultimate-guitar.com
ads.uncrate.com
ads.undertone.com
ads.usatoday.com
ads.v3.com
ads.verticalresponse.com
ads.vgchartz.com
ads.videosz.com
ads.virtual-nights.com
ads.virtualcountries.com
ads.vnumedia.com
ads.waps.cn
ads.wapx.cn
ads.weather.ca
ads.web.aol.com
ads.web.cs.com
ads.web.de
ads.webmasterpoint.org
ads.websiteservices.com
ads.whi.co.nz
ads.whoishostingthis.com
ads.wiezoekje.nl
ads.wikia.nocookie.net
ads.wineenthusiast.com
ads.wwe.biz
ads.xhamster.com
ads.xtra.co.nz
ads.y-0.net
ads.yahoo.com
ads.yimg.com
ads.yldmgrimg.net
ads.yourfreedvds.com
ads.youtube.com
ads.zdnet.com
ads.ztod.com
ads03.redtube.com
ads1.canoe.ca
ads1.mediacapital.pt
ads1.msn.com
ads1.rne.com
ads1.virtual-nights.com
ads10.speedbit.com
ads180.com
ads2.brazzers.com
ads2.clearchannel.com
ads2.contentabc.com
ads2.gamecity.net
ads2.jubii.dk
ads2.net-communities.co.uk
ads2.oneplace.com
ads2.rne.com
ads2.virtual-nights.com
ads2.xnet.cz
ads2004.treiberupdate.de
ads3.contentabc.com
ads3.gamecity.net
ads3.virtual-nights.com
ads4.clearchannel.com
ads4.gamecity.net
ads4.virtual-nights.com
ads4homes.com
ads5.canoe.ca
ads5.virtual-nights.com
ads6.gamecity.net
ads7.gamecity.net
ads8.com
adsatt.abc.starwave.com
Adsatt.ABCNews.starwave.com
adsatt.espn.go.com
adsatt.espn.starwave.com
Adsatt.go.starwave.com
adsby.bidtheatre.com
adscale.de
adscholar.com
adscience.nl
adscpm.com
adsdaq.com
adsdk.com
adsend.de
adserv.evo-x.de
adserv.gamezone.de
adserv.iafrica.com
adserv.qconline.com
adserve.ams.rhythmxchange.com
adserver-live.yoc.mobi
adserver.43plc.com
adserver.71i.de
adserver.adultfriendfinder.com
adserver.aidameter.com
adserver.aol.fr
adserver.beggarspromo.com
adserver.betandwin.de
adserver.bing.com
adserver.bizhat.com
adserver.break-even.it
adserver.cams.com
adserver.com
adserver.digitoday.com
adserver.dotcommedia.de
adserver.finditquick.com
adserver.flossiemediagroup.com
adserver.freecity.de
adserver.freenet.de
adserver.friendfinder.com
adserver.hardsextube.com
adserver.hardwareanalysis.com
adserver.html.it
adserver.irishwebmasterforum.com
adserver.janes.com
adserver.libero.it
adserver.news.com.au
adserver.ngz-network.de
adserver.nydailynews.com
adserver.o2.pl
adserver.oddschecker.com
adserver.omroepzeeland.nl
adserver.pl
adserver.portalofevil.com
adserver.portugalmail.net
adserver.portugalmail.pt
adserver.sanomawsoy.fi
adserver.sciflicks.com
adserver.sharewareonline.com
adserver.spankaway.com
adserver.startnow.com
adserver.theonering.net
adserver.twitpic.com
adserver.viagogo.com
adserver.virginmedia.com
adserver.yahoo.com
adserver01.de
adserver1-images.backbeatmedia.com
adserver1.backbeatmedia.com
adserver1.mindshare.de
adserver1.ogilvy-interactive.de
adserver2.mindshare.de
adserverplus.com
adserversolutions.com
adservinginternational.com
adsfac.eu
adsfac.net
adsfac.us
adshost1.com
adside.com
adsk2.co
adskape.ru
adsklick.de
adsmarket.com
adsmart.co.uk
adsmart.com
adsmart.net
adsmogo.com
adsnative.com
adsoftware.com
adsoldier.com
adsonar.com
adspace.ro
adspeed.net
adspirit.de
adsponse.de
adsremote.scrippsnetworks.com
adsrevenue.net
adsrv.deviantart.com
adsrv.eacdn.com
adsrv.iol.co.za
adsrvr.org
adsstat.com
adstat.4u.pl
adstest.weather.com
adsupply.com
adsymptotic.com
adsynergy.com
adsys.townnews.com
adsystem.simplemachines.org
adtech.de
adtechus.com
adtegrity.net
adthis.com
adtiger.de
adtoll.com
adtology.com
adtoma.com
adtrace.org
adtrade.net
adtrading.de
adtrak.net
adtriplex.com
adultadvertising.com
adv-adserver.com
adv-banner.libero.it
adv.cooperhosting.net
adv.freeonline.it
adv.hwupgrade.it
adv.livedoor.com
adv.webmd.com
adv.wp.pl
adv.yo.cz
advariant.com
adventory.com
advert.bayarea.com
advert.dyna.ultraweb.hu
adverticum.com
adverticum.net
adverticus.de
advertise.com
advertiseireland.com
advertisespace.com
advertising.com
advertising.guildlaunch.net
advertisingbanners.com
advertisingbox.com
advertmarket.com
advertmedia.de
advertpro.sitepoint.com
advertpro.ya.com
adverts.carltononline.com
advertserve.com
advertstream.com
advertwizard.com
advideo.uimserv.net
adview.ppro.de
advisormedia.cz
adviva.net
advnt.com
adwareremovergold.com
adwhirl.com
adwitserver.com
adworldnetwork.com
adworx.at
adworx.be
adworx.nl
adx.allstar.cz
adx.atnext.com
adxpansion.com
adxpose.com
adxvalue.com
adyea.com
adzerk.net
adzerk.s3.amazonaws.com
adzones.com
af-ad.co.uk
affbuzzads.com
affili.net
affiliate.1800flowers.com
affiliate.doubleyourdating.com
affiliate.dtiserv.com
affiliate.gamestop.com
affiliate.mercola.com
affiliate.mogs.com
affiliate.offgamers.com
affiliate.travelnow.com
affiliate.viator.com
affiliatefuel.com
affiliatefuture.com
affiliates.allposters.com
affiliates.babylon.com
affiliates.digitalriver.com
affiliates.globat.com
affiliates.internationaljock.com
affiliates.streamray.com
affiliates.thinkhost.net
affiliates.thrixxx.com
affiliates.ultrahosting.com
affiliatetracking.com
affiliatetracking.net
affiliatewindow.com
affiliation-france.com
afftracking.justanswer.com
ah-ha.com
ahalogy.com
aidu-ads.de
aim4media.com
aistat.net
aktrack.pubmatic.com
alclick.com
alenty.com
alexa-sitestats.s3.amazonaws.com
all4spy.com
alladvantage.com
allosponsor.com
amazingcounters.com
amazon-adsystem.com
americash.com
amung.us
an.tacoda.net
anahtars.com
analytics.adpost.org
analytics.google.com
analytics.live.com
analytics.yahoo.com
anm.intelli-direct.com
annonser.dagbladet.no
apex-ad.com
api.intensifier.de
apture.com
arc1.msn.com
arcadebanners.com
ard.xxxblackbook.com
are-ter.com
as.webmd.com
as1.advfn.com
assets1.exgfnetwork.com
assoc-amazon.com
at-adserver.alltop.com
atdmt.com
athena-ads.wikia.com
atwola.com
auctionads.com
auctionads.net
audience2media.com
audit.median.hu
audit.webinform.hu
auto-bannertausch.de
autohits.dk
avenuea.com
avpa.javalobby.org
avres.net
avsads.com
awempire.com
awin1.com
azfront.com
b-1st.com
b.aol.com
b.engadget.com
ba.afl.rakuten.co.jp
babs.tv2.dk
backbeatmedia.com
banik.redigy.cz
banner-exchange-24.de
banner.ad.nu
banner.ambercoastcasino.com
banner.blogranking.net
banner.buempliz-online.ch
banner.casino.net
banner.casinodelrio.com
banner.cotedazurpalace.com
banner.coza.com
banner.cz
banner.easyspace.com
banner.elisa.net
banner.eurogrand.com
banner.featuredusers.com
banner.getgo.de
banner.goldenpalace.com
banner.img.co.za
banner.inyourpocket.com
banner.kiev.ua
banner.linux.se
banner.media-system.de
banner.mindshare.de
banner.nixnet.cz
banner.noblepoker.com
banner.northsky.com
banner.orb.net
banner.penguin.cz
banner.rbc.ru
banner.relcom.ru
banner.tanto.de
banner.titan-dsl.de
banner.vadian.net
banner.webmersion.com
banner.wirenode.com
bannerads.de
bannerboxes.com
bannercommunity.de
bannerconnect.com
bannerconnect.net
bannerexchange.cjb.net
bannerflow.com
bannergrabber.internet.gr
bannerhost.com
bannerimage.com
bannerlandia.com.ar
bannermall.com
bannermarkt.nl
bannerpower.com
banners.adultfriendfinder.com
banners.amigos.com
banners.asiafriendfinder.com
banners.audioholics.com
banners.babylon-x.com
banners.bol.com.br
banners.cams.com
banners.clubseventeen.com
banners.czi.cz
banners.dine.com
banners.direction-x.com
banners.directnic.com
banners.easydns.com
banners.freett.com
banners.friendfinder.com
banners.getiton.com
banners.iq.pl
banners.isoftmarketing.com
banners.lifeserv.com
banners.linkbuddies.com
banners.passion.com
banners.resultonline.com
banners.sexsearch.com
banners.sys-con.com
banners.thomsonlocal.com
banners.videosz.com
banners.virtuagirlhd.com
banners.wunderground.com
bannerserver.com
bannersgomlm.com
bannershotlink.perfectgonzo.com
bannersng.yell.com
bannerspace.com
bannerswap.com
bannertesting.com
bannery.cz
bannieres.acces-contenu.com
bans.adserver.co.il
bans.bride.ru
barnesandnoble.bfast.com
basebanner.com
baypops.com
bbelements.com
bbn.img.com.ua
begun.ru
belstat.com
belstat.nl
berp.com
best-pr.info
best-top.ro
bestsearch.net
bhclicks.com
bidclix.com
bidclix.net
bidswitch.net
bidtrk.com
bidvertiser.com
bigbangmedia.com
bigclicks.com
billboard.cz
bitads.net
bitmedianetwork.com
bizad.nikkeibp.co.jp
bizrate.com
blast4traffic.com
blingbucks.com
blogads.com
blogcounter.de
blogherads.com
blogrush.com
blogtoplist.se
blogtopsites.com
blueadvertise.com
bluekai.com
bluelithium.com
bluewhaleweb.com
bm.annonce.cz
bn.bfast.com
boersego-ads.de
boldchat.com
boom.ro
boomads.com
boost-my-pr.de
box.anchorfree.net
bpath.com
braincash.com
brandreachsys.com
bravenet.com.invalid
bridgetrack.com
brightinfo.com
british-banners.com
bs.yandex.ru
bttrack.com
budsinc.com
bullseye.backbeatmedia.com
buyhitscheap.com
buysellads.com
buzzonclick.com
bvalphaserver.com
bwp.download.com
c.bigmir.net
c1.nowlinux.com
c1exchange.com
campaign.bharatmatrimony.com
caniamedia.com
carbonads.com
carbonads.net
casalemedia.com
casalmedia.com
cash4members.com
cash4popup.de
cashcrate.com
cashengines.com
cashfiesta.com
cashlayer.com
cashpartner.com
casinogames.com
casinopays.com
casinorewards.com
casinotraffic.com
casinotreasure.com
cbanners.virtuagirlhd.com
cbmall.com
cdn.freefacti.com
cdn.freefarcy.com
cecash.com
centerpointmedia.com
ceskydomov.alias.ngs.modry.cz
cetrk.com
cgicounter.puretec.de
ch.questionmarket.com
chameleon.ad
channelintelligence.com
chart.dk
chartbeat.com
chartbeat.net
checkm8.com
checkstat.nl
chestionar.ro
chitika.net
cibleclick.com
cityads.telus.net
cj.com
cjbmanagement.com
cjlog.com
claria.com
class-act-clicks.com
click.absoluteagency.com
click.fool.com
click.kmindex.ru
click2freemoney.com
click2paid.com
clickability.com
clickadz.com
clickagents.com
clickbank.com
clickbank.net
clickbooth.com
clickboothlnk.com
clickbrokers.com
clickcompare.co.uk
clickdensity.com
clickedyclick.com
clickhereforcellphones.com
clickhouse.com
clickhype.com
clicklink.jp
clickmedia.ro
clickonometrics.pl
clicks.equantum.com
clicks.mods.de
clickserve.cc-dt.com
clicksor.com
clicktag.de
clickthrucash.com
clickthruserver.com
clickthrutraffic.com
clicktrace.info
clicktrack.ziyu.net
clicktracks.com
clicktrade.com
clickxchange.com
clickz.com
clickzxc.com
clicmanager.fr
clientmetrics-pa.googleapis.com
clients.tbo.com
clixgalore.com
clk.konflab.com
clkads.com
clkrev.com
cluster.adultworld.com
clustrmaps.com
cmpstar.com
cnomy.com
cnt.spbland.ru
cnt1.pocitadlo.cz
code-server.biz
colonize.com
comclick.com
commindo-media-ressourcen.de
commissionmonster.com
compactbanner.com
comprabanner.it
confirmed-profits.com
connextra.com
contaxe.de
content.acc-hd.de
content.ad
contextweb.com
conversantmedia.com
conversionruler.com
cookies.cmpnet.com
coremetrics.com
count.rbc.ru
count.rin.ru
count.west263.com
counted.com
counter.bloke.com
counter.cnw.cz
counter.cz
counter.dreamhost.com
counter.fateback.com
counter.mirohost.net
counter.mojgorod.ru
counter.nowlinux.com
counter.rambler.ru
counter.search.bg
counter.sparklit.com
counter.yadro.ru
counters.honesty.com
counting.kmindex.ru
counts.tucows.com
coupling-media.de
cpalead.com
cpays.com
cpmaffiliation.com
cpmstar.com
cpxinteractive.com
cqcounter.com
crakmedia.com
craktraffic.com
crawlability.com
crazypopups.com
creafi-online-media.com
creative.whi.co.nz
creatives.as4x.tmcs.net
creatives.livejasmin.com
crispads.com
criteo.com
crowdgravity.com
crtv.mate1.com
crwdcntrl.net
ctnetwork.hu
cubics.com
customad.cnn.com
cyberbounty.com
cybermonitor.com
d.adroll.com
dakic-ia-300.com
danban.com
dapper.net
datashreddergold.com
dbbsrv.com
dc-storm.com
de17a.com
dealdotcom.com
debtbusterloans.com
decknetwork.net
deloo.de
demandbase.com
demdex.net
di1.shopping.com
dialerporn.com
didtheyreadit.com
direct-xxx-access.com
directaclick.com
directleads.com
directorym.com
directtrack.com
discountclick.com
displayadsmedia.com
dist.belnk.com
dmtracker.com
dmtracking.alibaba.com
dmtracking2.alibaba.com
dnads.directnic.com
domaining.in
domainsponsor.com
domainsteam.de
domdex.com
doubleclick.com
doubleclick.de
doubleclick.net
doublepimp.com
drumcash.com
dynamic.fmpub.net
e-adimages.scrippsnetworks.com
e-bannerx.com
e-debtconsolidation.com
e-m.fr
e-n-t-e-r-n-e-x.com
e-planning.net
e.kde.cz
eadexchange.com
eas.almamedia.fi
easyhits4u.com
ebayadvertising.com
ebocornac.com
ebuzzing.com
ecircle-ag.com
eclick.vn
ecoupons.com
edgeio.com
effectivemeasure.com
effectivemeasure.net
eiv.baidu.com
elitedollars.com
elitetoplist.com
emarketer.com
emediate.dk
emediate.eu
engine.espace.netavenir.com
enginenetwork.com
enoratraffic.com
enquisite.com
entercasino.com
entrecard.s3.amazonaws.com
eqads.com
ero-advertising.com
esellerate.net
estat.com
etahub.com
etargetnet.com
etracker.de
eu-adcenter.net
eu1.madsone.com
eur.a1.yimg.com
eurekster.com
euro-linkindex.de
euroclick.com
euros4click.de
eusta.de
evergage.com
evidencecleanergold.com
ewebcounter.com
exchange-it.com
exchange.bg
exchangead.com
exchangeclicksonline.com
exelator.com
exit76.com
exitexchange.com
exitfuel.com
exoclick.com
exogripper.com
experteerads.com
exponential.com
express-submit.de
extractorandburner.com
extreme-dm.com
extremetracking.com
eyeblaster.com
eyereturn.com
eyeviewads.com
eyewonder.com
ezula.com
f5biz.com
fast-adv.it
fastclick.com
fastclick.com.edgesuite.net
fastclick.net
fb-promotions.com
fc.webmasterpro.de
feedbackresearch.com
feedjit.com
ffxcam.fairfax.com.au
fimc.net
fimserve.com
findcommerce.com
findyourcasino.com
fineclicks.com
first.nova.cz
firstlightera.com
flashtalking.com
fleshlightcash.com
flexbanner.com
flowgo.com
flurry.com
fonecta.leiki.com
foo.cosmocode.de
forex-affiliate.net
fpctraffic.com
fpctraffic2.com
fragmentserv.iac-online.de
free-banners.com
freebanner.com
freelogs.com
freeonlineusers.com
freepay.com
freestats.com
freestats.tv
freewebcounter.com
funklicks.com
funpageexchange.com
fusionads.net
fusionquest.com
fxstyle.net
galaxien.com
game-advertising-online.com
gamehouse.com
gamesites100.net
gamesites200.com
gamesitestop100.com
gator.com
gbanners.hornymatches.com
gemius.pl
geo.digitalpoint.com
geobanner.adultfriendfinder.com
geovisite.com
getclicky.com
globalismedia.com
globaltakeoff.net
globaltrack.com.invalid
globe7.com
globus-inter.com
gmads.net
go-clicks.de
go-rank.de
goingplatinum.com
goldstats.com
google-analytics.com
googleadservices.com
googlesyndication.com
gostats.com
gp.dejanews.com
gpr.hu
grafstat.ro
grapeshot.co.uk
greystripe.com
gtop.ro
gtop100.com
gunggo.com
harrenmedia.com
harrenmedianetwork.com
havamedia.net
heias.com
hentaicounter.com
herbalaffiliateprogram.com
hexusads.fluent.ltd.uk
heyos.com
hgads.com
hidden.gogoceleb.com
hightrafficads.com
histats.com
hit-parade.com
hit.bg
hit.ua
hit.webcentre.lycos.co.uk
hitbox.com
hitcents.com
hitfarm.com
hitiz.com
hitlist.ru
hitlounge.com
hitometer.com
hits.europuls.eu
hits.informer.com
hits.puls.lv
hits.theguardian.com
hits4me.com
hits4pay.com
hitslink.com
hittail.com
hollandbusinessadvertising.nl
homepageking.de
hostedads.realitykings.com
hotjar.com
hotkeys.com
hotlog.ru
hotrank.com.tw
hs-analytics.net
htmlhubing.xyz
httpool.com
hurricanedigitalmedia.com
hydramedia.com
hyperbanner.net
hypertracker.com
i-clicks.net
i.xx.openx.com
i1img.com
i1media.no
ia.iinfo.cz
iad.anm.co.uk
iadnet.com
iasds01.com
iconadserver.com
icptrack.com
idcounter.com
identads.com
idot.cz
idregie.com
idtargeting.com
ientrymail.com
iesnare.com
ifa.tube8live.com
ilbanner.com
ilead.itrack.it
ilovecheating.com
imageads.canoe.ca
imagecash.net
images-pw.secureserver.net
images.v3.com
imarketservices.com
img.prohardver.hu
imgpromo.easyrencontre.com
imonitor.nethost.cz
imprese.cz
impressionmedia.cz
impressionz.co.uk
imrworldwide.com
inboxdollars.com
incentaclick.com
indexstats.com
indieclick.com
industrybrains.com
inetlog.ru
infinite-ads.com
infinityads.com
infolinks.com
information.com
inringtone.com
insightexpress.com
insightexpressai.com
inspectorclick.com
instantmadness.com
intelliads.com
intellitxt.com
interactive.forthnet.gr
intergi.com
internetfuel.com
interreklame.de
interstat.hu
ip.ro
ip193.cn
iperceptions.com
ipro.com
ireklama.cz
itfarm.com
itop.cz
its-that-easy.com
itsptp.com
jcount.com
jinkads.de
joetec.net
js.users.51.la
juicyads.com
jumptap.com
justrelevant.com
justwebads.com
k.iinfo.cz
kanoodle.com
keymedia.hu
kindads.com
kissmetrics.com
kliks.nl
kniverto.com
komoona.com
kompasads.com
kontera.com
kt-g.de
ktu.sv2.biz
lakequincy.com
launchbit.com
layer-ad.de
layer-ads.de
lbn.ru
lct.salesforce.com
lead-analytics.nl
leadboltads.net
leadclick.com
leadingedgecash.com
leadzupc.com
levelrate.de
lfstmedia.com
liftdna.com
ligatus.com
ligatus.de
lightningcast.net
lightspeedcash.com
link-booster.de
link4ads.com
linkadd.de
linkbuddies.com
linkexchange.com
linkprice.com
linkrain.com
linkreferral.com
links-ranking.de
linkshighway.com
linkstorms.com
linkswaper.com
linktarget.com
liquidad.narrowcastmedia.com
liveintent.com
liverail.com
loading321.com
log.btopenworld.com
logua.com
lop.com
lucidmedia.com
lzjl.com
m.webtrends.com
m1.webstats4u.com
m4n.nl
mackeeperapp.mackeeper.com
madclient.uimserv.net
madisonavenue.com
mads.cnet.com
madvertise.de
marchex.com
market-buster.com
marketing.888.com
marketing.hearstmagazines.nl
marketing.nyi.net
marketing.osijek031.com
marketingsolutions.yahoo.com
maroonspider.com
mas.sector.sk
mastermind.com
matchcraft.com
mathtag.com
max.i12.de
maximumcash.com
mbn.com.ua
mbs.megaroticlive.com
mbuyu.nl
mdotm.com
measuremap.com
media-adrunner.mycomputer.com
media-servers.net
media.ftv-publicite.fr
media.funpic.de
media6degrees.com
mediaarea.eu
mediacharger.com
mediadvertising.ro
mediageneral.com
mediamath.com
mediamgr.ugo.com
mediaplazza.com
mediaplex.com
mediascale.de
mediatext.com
mediax.angloinfo.com
mediaz.angloinfo.com
medleyads.com
medyanetads.com
megacash.de
megago.com
megastats.com
megawerbung.de
metaffiliation.com
metanetwork.com
methodcash.com
metrics.windowsitpro.com
mgid.com
miarroba.com
microstatic.pl
microticker.com
midnightclicking.com
misstrends.com
mixpanel.com
mixtraffic.com
mjxads.internet.com
mlm.de
mmismm.com
mmtro.com
moatads.com
mobclix.com
mocean.mobi
moneyexpert.com
monsterpops.com
mopub.com
mouseflow.com
mpstat.us
mr-rank.de
mrskincash.com
mtree.com
musiccounter.ru
muwmedia.com
myaffiliateprogram.com
mybloglog.com
mycounter.ua
mymoneymakingapp.com
mypagerank.net
mypagerank.ru
mypowermall.com
mystat-in.net
mystat.pl
mytop-in.net
n69.com
naiadsystems.com.invalid
naj.sk
namimedia.com
nastydollars.com
navigator.io
navrcholu.cz
nbjmp.com
ndparking.com
nedstat.com
nedstat.nl
nedstatbasic.net
nedstatpro.net
nend.net
neocounter.neoworx-blog-tools.net
neoffic.com
net-filter.com
netaffiliation.com
netagent.cz
netclickstats.com
netcommunities.com
netdirect.nl
netincap.com
netpool.netbookia.net
netshelter.net
neudesicmediagroup.com
newads.bangbros.com
newbie.com
newnet.qsrch.com
newnudecash.com
newopenx.detik.com
newt1.adultadworld.com
newt1.adultworld.com
newtopsites.com
ng3.ads.warnerbros.com
ngs.impress.co.jp
nitroclicks.com
novem.pl
nuggad.net
numax.nu-1.com
nuseek.com
oas.benchmark.fr
oas.foxnews.com
oas.repubblica.it
oas.roanoke.com
oas.salon.com
oas.toronto.com
oas.uniontrib.com
oas.villagevoice.com
oascentral.businessweek.com
oascentral.chicagobusiness.com
oascentral.fortunecity.com
oascentral.register.com
oewa.at
oewabox.at
offerforge.com
offermatica.com
olivebrandresponse.com
omniture.com
onclasrv.com
onclickads.net
oneandonlynetwork.com
onenetworkdirect.com
onestat.com
onestatfree.com
online-metrix.net
onlinecash.com
onlinecashmethod.com
onlinerewardcenter.com
openad.tf1.fr
openad.travelnow.com
openads.friendfinder.com
openads.org
openx.angelsgroup.org.uk
openx.blindferret.com
opienetwork.com
optimost.com
optmd.com
ordingly.com
ota.cartrawler.com
otto-images.developershed.com
outbrain.com
overture.com
owebmoney.ru
oxado.com
oxcash.com
oxen.hillcountrytexas.com
p.adpdx.com
pagead.l.google.com
pagefair.com
pagerank-ranking.de
pagerank-submitter.de
pagerank-united.de
pagerank4you.com
pageranktop.com
parse.ly.invalid
parsely.com
partage-facile.com
partner-ads.com
partner.pelikan.cz
partner.topcities.com
partnerad.l.google.com
partnercash.de
partners.priceline.com
passion-4.net
pay-ads.com
paycounter.com
paypopup.com
payserve.com
pbnet.ru
pcash.imlive.com
peep-auktion.de
peer39.com
pennyweb.com
pepperjamnetwork.com
percentmobile.com
perfectaudience.com
perfiliate.com
performancerevenue.com
performancerevenues.com
performancing.com
pgmediaserve.com
pgpartner.com
pheedo.com
phoenix-adrunner.mycomputer.com
phpadsnew.new.natuurpark.nl
phpmyvisites.net
picadmedia.com
pillscash.com
pimproll.com
pixel.adsafeprotected.com
pixel.jumptap.com
pixel.redditmedia.com
play4traffic.com
playhaven.com
plista.com
plugrush.com
pointroll.com
pop-under.ru
popads.net
popub.com
popunder.ru
popup.msn.com
popupmoney.com
popupnation.com
popups.infostart.com
popuptraffic.com
porngraph.com
porntrack.com
postrelease.com
potenza.cz
pr-star.de
pr-ten.de
praddpro.de
prchecker.info
precisioncounter.com
predictad.com
premium-offers.com
primaryads.com
primetime.net
privatecash.com
pro-advertising.com
pro.i-doctor.co.kr
proext.com
profero.com
projectwonderful.com
promo.badoink.com
promo.ulust.com
promo1.webcams.nl
promobenef.com
promos.fling.com
promote.pair.com
promotion-campaigns.com
pronetadvertising.com
propellerads.com
proranktracker.com
proton-tm.com
protraffic.com
provexia.com
prsitecheck.com
psstt.com
pub.chez.com
pub.club-internet.fr
pub.hardware.fr
pub.realmedia.fr
pubdirecte.com
publicidad.elmundo.es
pubmatic.com
pubs.lemonde.fr
pulse360.com
q.azcentral.com
qctop.com
qnsr.com
quantcast.com
quantserve.com
quarterserver.de
questaffiliates.net
quigo.com
quinst.com
quisma.com
rad.msn.com
radar.cedexis.com
radarurl.com
radiate.com
rampidads.com
rank-master.com
rank-master.de
rankchamp.de
ranking-charts.de
ranking-hits.de
ranking-id.de
ranking-links.de
ranking-liste.de
ranking-street.de
rankingchart.de
rankingscout.com
rankyou.com
rapidcounter.com
rate.ru
ratings.lycos.com
rb1.design.ru
re-directme.com
reachjunction.com
reactx.com
readserver.net
realcastmedia.com
realclix.com
realmedia-a800.d4p.net
realtechnetwork.com
realtracker.com
reduxmedia.com
reduxmediagroup.com
reedbusiness.com.invalid
referralware.com
regnow.com
reinvigorate.net
reklam.rfsl.se
reklama.mironet.cz
reklama.reflektor.cz
reklamcsere.hu
reklame.unwired-i.net
reklamer.com.ua
relevanz10.de
relmaxtop.com
remotead.cnet.com
republika.onet.pl
retargeter.com
revenue.net
revenuedirect.com
revsci.net
revstats.com
richmails.com
richmedia.yimg.com
richwebmaster.com
rightstats.com
rlcdn.com
rle.ru
rmads.msn.com
rmedia.boston.com
roar.com
robotreplay.com
roia.biz
rok.com.com
rose.ixbt.com
rotabanner.com
roxr.net
rtbpop.com
rtbpopd.com
ru-traffic.com
ru4.com
rubiconproject.com
s.adroll.com
s2d6.com
sageanalyst.net
sail-horizon.com
samsungacr.com
samsungads.com
sbx.pagesjaunes.fr
scambiobanner.aruba.it
scanscout.com
scopelight.com
scorecardresearch.com
scratch2cash.com
scripte-monster.de
searchfeast.com
searchmarketing.com
searchramp.com
secure.webconnect.net
sedoparking.com
sedotracker.com
seeq.com.invalid
sensismediasmart.com.au
seo4india.com
serv0.com
servedby-buysellads.com
servedbyadbutler.com
servedbyopenx.com
services.hearstmags.com
serving-sys.com
sexaddpro.de
sexadvertentiesite.nl
sexcounter.com
sexinyourcity.com
sexlist.com
sextracker.com
sexystat.com
shareadspace.com
shareasale.com
sharepointads.com
sher.index.hu
shinystat.com
shinystat.it
shoppingads.com
siccash.com
sidebar.angelfire.com
sinoa.com
sitemeter.com
sitestat.com
sixsigmatraffic.com
skimresources.com
skylink.vn
slickaffiliate.com
slopeaota.com
smart4ads.com
smartadserver.com
smowtion.com
snapads.com
snoobi.com
socialspark.com
softclick.com.br
spacash.com
sparkstudios.com
specificmedia.co.uk
specificpop.com
spezialreporte.de
spinbox.techtracker.com
spinbox.versiontracker.com
sponsorads.de
sponsorpro.de
sponsors.thoughtsmedia.com
spot.fitness.com
spotxchange.com
spylog.com
spywarelabs.com
spywarenuker.com
spywords.com
srwww1.com
starffa.com
start.freeze.com
stat.cliche.se
stat.dealtime.com
stat.dyna.ultraweb.hu
stat.pl
stat.su
stat.tudou.com
stat.webmedia.pl
stat.zenon.net
stat24.com
stat24.meta.ua
statcounter.com
static.fmpub.net
static.itrack.it
staticads.btopenworld.com
statistik-gallup.net
statm.the-adult-company.com
stats.blogger.com
stats.cts-bv.nl
stats.directnic.com
stats.hyperinzerce.cz
stats.mirrorfootball.co.uk
stats.multiup.org
stats.olark.com
stats.suite101.com
stats.surfaid.ihost.com
stats.townnews.com
stats.unwired-i.net
stats.wordpress.com
stats.x14.eu
stats4all.com
statsie.com
statxpress.com
steelhouse.com
steelhousemedia.com
stickyadstv.com
suavalds.com
subscribe.hearstmags.com
sugoicounter.com
sumo.com
sumome.com
superclix.de
superstats.com
supertop.ru
supertop100.com
suptullog.com
surfmusik-adserver.de
swan-swan-goose.com
swissadsolutions.com
swordfishdc.com
sx.trhnt.com
t.insigit.com
t.pusk.ru
taboola.com
tacoda.net
tagular.com
tailsweep.co.uk
tailsweep.com
tailsweep.se
takru.com
tangerinenet.biz
tapad.com
targad.de
targetingnow.com
targetnet.com
targetpoint.com
tatsumi-sys.jp
tcads.net
teads.tv
techclicks.net
teenrevenue.com
teliad.de
text-link-ads.com
textad.sexsearch.com
textads.biz
textads.opera.com
textlinks.com
tfag.de
theadhost.com
theads.me
thebugs.ws
thecounter.com
therapistla.com
therichkids.com
thrnt.com
thruport.com
tinybar.com
tizers.net
tlvmedia.com
tntclix.co.uk
top-casting-termine.de
top-site-list.com
top.list.ru
top.mail.ru
top.proext.com
top100-images.rambler.ru
top100.mafia.ru
top123.ro
top20.com.invalid
top20free.com
top90.ro
topbarh.box.sk
topblogarea.se
topbucks.com
topforall.com
topgamesites.net
toplist.cz
toplist.pornhost.com
toplista.mw.hu
toplistcity.com
topmmorpgsites.com.invalid
topping.com.ua
toprebates.com
topsafelist.net
topsearcher.com
topsir.com
topsite.lv
topsites.com.br
topstats.com
totemcash.com
touchclarity.com
touchclarity.natwest.com
tour.brazzers.com
tpnads.com
track.adform.net
track.anchorfree.com
track.gawker.com
trackalyzer.com
tracker.icerocket.com
tracker.marinsm.com
tracking.crunchiemedia.com
tracking.gajmp.com
tracking.internetstores.de
tracking.yourfilehost.com
tracking101.com
trackingsoft.com
trackmysales.com
tradeadexchange.com
tradedoubler.com
traffic-exchange.com
traffic.liveuniversenetwork.com
trafficadept.com
trafficcdn.liveuniversenetwork.com
trafficfactory.biz
trafficholder.com
traffichunt.com
trafficjunky.net
trafficleader.com
trafficsecrets.com
trafficspaces.net
trafficstrategies.com
trafficswarm.com
traffictrader.net
trafficz.com
trafficz.net
traffiq.com
trafic.ro
travis.bosscasinos.com
trekblue.com
trekdata.com
trendcounter.com
trendmd.com
trhunt.com
tribalfusion.com
trix.net
truehits.net
truehits1.gits.net.th
truehits2.gits.net.th
tsms-ad.tsms.com
tubemogul.com
turn.com
tvmtracker.com
twittad.com
tyroo.com
uarating.com
ukbanners.com
ultramercial.com
unanimis.co.uk
untd.com
updated.com
urlcash.net
us.a1.yimg.com
usapromotravel.com
usmsad.tom.com
utarget.co.uk
utils.mediageneral.net
v1.cnzz.com
validclick.com
valuead.com
valueclick.com
valueclickmedia.com
valuecommerce.com
valuesponsor.com
veille-referencement.com
ventivmedia.com
vericlick.com
vertadnet.com
veruta.com
vervewireless.com
vibrantmedia.com
video-stats.video.google.com
videoegg.com
view4cash.de
viewpoint.com
visistat.com
visit.webhosting.yahoo.com
visitbox.de
visual-pagerank.fr
visualrevenue.com
voicefive.com
vpon.com
vrs.cz
vs.tucows.com
vungle.com
warlog.ru
wdads.sx.atl.publicus.com
web-stat.com
web.informer.com
web2.deja.com
webads.co.nz
webads.nl
webangel.ru
webcash.nl
webcounter.cz
webcounter.goweb.de
webgains.com
webmaster-partnerprogramme24.de
webmasterplan.com
webmasterplan.de
weborama.fr
webpower.com
webreseau.com
webseoanalytics.com
websponsors.com
webstat.channel4.com
webstat.com
webstat.net
webstats4u.com
webtrackerplus.com
webtraffic.se
webtraxx.de
webtrendslive.com
werbung.meteoxpress.com
wetrack.it
whaleads.com
whenu.com
whispa.com
whoisonline.net
wholesaletraffic.info
widespace.com
widgetbucks.com
wikia-ads.wikia.com
window.nixnet.cz
wintricksbanner.googlepages.com
witch-counter.de
wlmarketing.com
wmirk.ru
wonderlandads.com
wondoads.de
woopra.com
worldwide-cash.net
wtlive.com
www-banner.chat.ru
www-google-analytics.l.google.com
www.banner-link.com.br
www.dnps.com
www.kaplanindex.com
www.money4exit.de
www.photo-ads.co.uk
www1.gto-media.com
www8.glam.com
wwwpromoter.com
x-traceur.com
x6.yakiuchi.com
xchange.ro
xclicks.net
xertive.com
xg4ken.com
xiti.com
xplusone.com
xponsor.com
xq1.net
xrea.com
xtendmedia.com
xtremetop100.com
xxxcounter.com
xxxmyself.com
y.ibsys.com
yab-adimages.s3.amazonaws.com
yabuka.com
yadro.ru
yesads.com
yesadvertising.com
yieldads.com
yieldlab.net
yieldmanager.com
yieldmanager.net
yieldmo.com
yieldtraffic.com
yoc.mobi
yoggrt.com
z5x.net
zangocash.com
zanox-affiliate.de
zanox.com
zantracker.com
zedo.com
zencudo.co.uk
zenkreka.com
zenzuu.com
zeus.developershed.com
zeusclicks.com
zintext.com
zmedia.com
zv1.november-lax.com
EOF
#denying torrent
/bin/cat <<"EOM" >/etc/squid/extensiondeny.txt
\.torrent$
EOM
# deny malwares
cat << EOF > /etc/squid/malware.txt
0koryu0.easter.ne.jp
109-204-26-16.netconnexion.managedbroadband.co.uk
1866809.securefastserver.com
2amsports.com
4dexports.com
50efa6486f1ef.skydivesolutions.be
61kx.uk-insolvencydirect.com
6b8a953b2bf7788063d5-6e453f33ecbb90f11a62a5c376375af3.r71.cf5.rackcdn.com
97b1c56132dfcdd90f93-0c5c8388c0a5897e648f883e2c86dc72.r54.cf5.rackcdn.com
999fitness.com
a.update.51edm.net
ab.usageload32.com
abcdespanol.com
above.e-rezerwacje24.pl
absurdity.flarelight.com
achren.org
acool.csheaven.com
ad-beast.com
ad.9tv.co.il
ad.getfond.info
adgallery.whitehousedrugpolicy.gov
adlock.in
adobeflashupdate14.com
ads.wikipartes.com
adserving.favorit-network.com
adv.riza.it
advancetec.co.uk
afa15.com.ne.kr
agsteier.com
aintdoinshit.com
aippnetworks.com
aircraft.evote.cl
ajewishgift.com
akirkpatrick.com
alegroup.info
alexanderinteriorsanddesign.com
alexandria90.etcserver.com
alisat.biz
alissonluis-musico.sites.uol.com.br
allforlove.de
allxscan.tk
alsoknowsit.com
ama-alliance.com
amazingvacationhotels.com
amazon-sicherheit.kunden-ueberpruefung.xyz
ambulanciaslazaro.com
americancareconcept.com
aminev.com
amu.adduraddonhere.info
amu.boxinstallercompany.info
amu.brandnewinstall.info
amu.helpyourselfinstall.info
amu.twobox4addon.info
analxxxclipsyjh.dnset.com
anshrit.com
antalya.ru
apexgames.org
app.pho8.com
arkinsoftware.in
art-archiv.ru
artsconsortium.org
asham.tourstogo.us
associatesexports.com
atelierprincesse.web.fc2.com
atlcourier.com
atyss.barginginfrance.net
avokka.com
avppet.com
axisbuild.com
azoos.csheaven.com
b.nevadaprivateoffice.com
babos.scrapping.cc
bargainracks.co.uk
batcoroadlinescorporation.com
bbs.bjchun.com
bde.be
be-funk.com
beautysafari.com
becomedebtfree.com.au
beespace.com.ua
beldiplomcom.75.com1.ru
best100catfights.com
betterhomeandgardenideas.com
bezproudoff.cz
bilbaopisos.es
bizzibeans.net
blackfalcon5.net
blacknite.eu
blog.replacemycontacts.com
bluecutsystem.com
bnsoutlaws.co.uk
bonjo.bmbsklep.pl
boogu.barginginfrance.net
bookofkisl.com
boots.fotopyra.pl
borat.elticket.com.ar
boschetto-hotel.gr
bracbetul.com
bracewellfamily.com
bravetools.net
bride1.com
broadtech.co
buffalogoesout.com
buildviet.info
by98.com
cacl.fr
caclclo.web.fc2.com
callingcardsinstantly.com
campamento.queenscamp.com
cannabislyric.com
cannabispicture.com
catjogger.win
centralwestwater.com.au
ceskarepublika.net
chaveiro.bio.br
chsplantsales.co.uk
ciclismovalenciano.com
citymediamagazin.hu
classicallyabsurdphotography.com
classicspeedway.com
cmicapui.ce.gov.br
coaha.frenchgerlemanelectric.com
coalimpex.com
cofeb13east.com
coffeol.com
concede.fmtlib.net
conds.ru
cope.it
corroshield.estb.com.sg
cosmetice-farduri.ro
cosmos.felago.es
cosmos.furnipict.com
cqji.artidentalkurs.com
cracks.vg
crackspider.us
crackzone.net
creditbootcamp.com
crops.dunight.eu
csmail.iggcn.com
cswilliamsburg.com
cudacorp.com
customsboysint.com
cwmgaming.com
cznshuya.ivnet.ru
d1.kuai8.com
d1054130-28095.cp.blacknight.com
d1171912.cp.blacknight.com
d32k27yvyi4kmv.cloudfront.net
d4.cumshots.ws
dancecourt.com
daralasnan.com
dawnframing.com
dcanscapital.co.uk
ddd.gouwuke.cn
decografix.com
decorator.crabgrab.cl
decota.es
decrolyschool.be
deleondeos.com
deletespyware-adware.com
demo.vertexinfo.in
dent-lux.com.pl
dentairemalin.com
destre45.com
dev.wrathofshadows.net
dianepiette.co.uk
diaryofagameaddict.com
dieutribenhkhop.com
dimarsbg.com
dimenal.com.br
dimensionnail.ro
dimsnetwork.com
directxex.com
divine.lunarbreeze.com
dl.downf468.com
dl.heima8.com
dl.microsword.net
dl01.faddmr.com
dofeb.frenchgerlemanelectric.com
doktester.orgfree.com
dougmlee.com
down.feiyang163.com
down.guangsu.cn
down.mykings.pw
down.unadnet.com.cn
down2.feiyang163.com
down3.feiyang163.com
download-archiver.ru
download.56.com
download.grandcloud.cn
download.ttrili.com
download207.mediafire.com
downloads-finereader.ru
downloads-whatsapp.com
dp-medien.eu
drank.fa779.com
dujur.barginginfrance.net
e-matelco.com
e1r.net
earthcontrolsys.com
echoa.randbinternationaltravel.com
edf.fr.kfskz.com
eecky.butlerelectricsupply.com
eekro.cruisingsmallship.com
eeps.me
eeroo.frost-electric-supply.com
eetho.cruisingsmallship.com
efugl.iptvdeals.com
elew72isst.rr.nu
eliehabib.com
elmissouri.fr
elocumjobs.com
emits.iptvdeals.com
eroov.iptvdeals.com
erupt.fernetmoretti.com.ar
esoad.frost-electric-supply.com
espdesign.com.au
estoa.frost-electric-supply.com
eternitymobiles.com
euro-vertrieb.com
europe-academy.net
europol.europe.eu.france.id647744160-2176514326.h5841.com
europol.europe.eu.id214218540-7444056787.h5841.com
evans.babajilab.in
ex.technor.com
exclaim.goldenteamacademy.cl
executivecoaching.co.il
exsexytop.tk
extreembilisim.com
f.gj555.net
faiyazahmed.com
falconsafe.com.sg
fallencrafts.info
faq-candrive.tk
fbku.com
femalewrestlingnow.com
fetishfitnessbabes.com
fetishlocator.com
fgawegwr.chez.com
fgtkmcby02.eu
files.dsnetwb.com
finnhair.co.uk
firehouse651.com
fkhfgfg.tk
flashsavant.com
fo5.a1-downloader.org
fondazioneciampi.org
formessengers.com
fourthgate.org
free-crochet-pattern.com
freefblikes.phpnet.us
freeserials.spb.ru
freeserials.ws
ftp.flyfishusa.com
funchill.com
funkucck.bluerobot.cl
geil.alon3.tk
generalchemicalsupply.com
getdatanetukscan.info
giants.yourzip.co
go-quicky.com
gogetgorgeous.com
gojnox.boxtomarket.com
gosciniec-paproc.pl
gravityexp.com
gredinatib.org
greev.randbinternationaltravel.com
grendizer.biz
grosirkecantikan.com
gulf-industrial.com
gurde.tourstogo.us
guyscards.com
gyboo.cruisingsmallship.com
gylra.cruisingsmallship.com
h1666015.stratoserver.net
hana-naveh.com
hanulsms.com
hardcorepornparty.com
harshwhispers.com
headless.ebkfwd.com
healthybloodpressure.info
helesouurusa.cjb.com
hexadl.line55.net
higher.dwebsi.tk
highflyingfood.com
hinsib.com
hmora.fred-build.tk
hnskorea.co.kr
hoawy.frost-electric-supply.com
hobbat.fvds.ru
hobby-hangar.net
hobbytotaalservice.nl
hoerbird.net
holishit.in
honor.agitaattori.fi
hosting-controlid1.tk
hosting-controlnext.tk
hosting-controlpin.tk
hosting-controlpr.tk
hotfacesitting.com
hotspot.cz
hrdcvn.com.vn
hst-19-33.splius.lt
hujii.qplanner.cf
hy-brasil.mhwang.com
hydraulicpowerpack.com
iamagameaddict.com
id405441215-8305493831.h121h9.com
igagh.tourstogo.us
igoby.frost-electric-supply.com
igroo.barginginfrance.net
image-circul.tk
images.topguncustomz.com
img001.com
immediateresponseforcomputer.com
impressoras-cartoes.com.pt
inclusivediversity.co.uk
incoctel.cl
infoweb-coolinfo.tk
inlinea.co.uk
innatek.com
instruminahui.edu.ec
interactivearea.ru
internet-bb.tk
invention.festinolente.cl
ip-182-50-129-164.ip.secureserver.net
ip-182-50-129-181.ip.secureserver.net
ipl.hk
iptoo.cruisingsmallship.com
isonomia.com.ar
ithyk.frenchgerlemanelectric.com
iwgtest.co.uk
iwhab.randbinternationaltravel.com
ixoox.csheaven.com
iybasketball.info
izzy-cars.nl
japanesevehicles.us
jdfabrication.com
jeanlesigne.com
jeansvixens.com
jessisjewels.com
jktdc.in
job-companybuild.tk
job-compuse.tk
josip-stadler.org
js.tongji.linezing.com
jstaikos.com
jue0jc.lukodorsai.info
juedische-kammerphilharmonie.de
juicypussyclips.com
k.h.a.d.free.fr
kadirzerey.com
kadman.net
kalantzis.net
kapcotool.com
kassabravo.com
keemy.butlerelectricsupply.com
keyways.pt
kfc.i.illuminationes.com
kids-fashion.dk
kingskillz.ru
kipasdenim.com
kollagen4you.se
krsa2gno.congrats-sweepstakes-winner.com
krsa2gno.important-security-brower-alert.com
krsa2gno.internet-security-alert.com
krsa2gno.todays-sweepstakes-winner.com
krsa2gno.youre-todays-lucky-sweeps-winner.com
kulro.csheaven.com
kyrsu.frost-electric-supply.com
lab-cntest.tk
landisbaptist.com
lay.elticket.com.ar
lcbcad.co.uk
leagleconsulting.com
lefos.net
legendsdtv.com
lexu.goggendorf.at
lhs-mhs.org
lifescience.sysu.edu.cn
likes.gisnetwork.net
linkforme.tk
live-dir.tk
livre.wasastation.fi
loft2126.dedicatedpanel.com
losas.cabanaslanina.com.ar
losos.caliane.com.br
luchtenbergdecor.com.br
luckyblank.info
luckyclean.info
luckyclear.info
luckyeffect.info
luckyhalo.info
luckypure.info
luckyshine.info
luckysuccess.info
luckysure.info
luckytidy.info
luggage-tv.com
luggagecast.com
luggagepreview.com
lunaticjazz.com
luwyou.com
lydwood.co.uk
m2132.ehgaugysd.net
mahindrainsurance.com
mailboto.com
malest.com
manoske.com
marchen-toy.co.jp
marialorena.com.br
marx-brothers.mhwang.com
mathenea.com
maxisoft.co.uk
mbrdot.tk
mediatrade.h19.ru
mepra.blautechnology.cl
merrymilkfoods.com
metrocuadro.com.ve
mgfd1b.petrix.net
miespaciopilates.com
milf.gabriola.cl
milleniumpapelaria.com.br
mindstormstudio.ro
ministerio-publi.info
miracema.rj.gov.br
mirandolasrl.it
mlpoint.pt
mmile.com
mobatory.com
mobile.bitterstrawberry.org
mocka.frost-electric-supply.com
molla.gato1000.cl
monarchslo.com
montezuma.spb.ru
morenews3.net
ms11.net
mtldesigns.ca
mueller-holz-bau.com
murbil.hostei.com
mycleanpc.tk
mylabsrl.com
mylondon.hc0.me
myshopmarketim.com
mysmallcock.com
myvksaver.ru
nadegda-95.ru
nailbytes1.com
namso.butlerelectricsupply.com
narrow.azenergyforum.com
natural.buckeyeenergyforum.com
nbook.far.ru
nc2199.eden5.netclusive.de
nctbonline.co.uk
nefib.tourstogo.us
nerez-schodiste-zabradli.com
nestorconsulting.net
networkmedical.com.hk
neumashop.cl
nevergreen.net
new-address.tk
new-softdriver.tk
news4cars.com
njtgsd.attackthethrone.com
nkgamers.com
nlconsulateorlandoorg.siteprotect.net
nmsbaseball.com
nobodyspeakstruth.narod.ru
nonsi.csheaven.com
noobgirls.com
nordiccountry.cz
nortonfire.co.uk
notebookservisru.161.com1.ru
noveslovo.com
nowina.info
ns1.the-sinner.net
ns1.updatesdns.org
ns2ns1.tk
nt-associates.com
nudebeachgalleries.net
nugly.barginginfrance.net
nuptialimages.com
nutnet.ir
oakso.tourstogo.us
oampa.csheaven.com
oapsa.tourstogo.us
oawoo.frenchgerlemanelectric.com
obada-konstruktiwa.org
obkom.net.ua
ocick.frost-electric-supply.com
ocpersian.com
officeon.ch.ma
oilwrestlingeurope.com
okeanbg.com
oknarai.ru
omrdatacapture.com
onrio.com.br
oofuv.cruisingsmallship.com
oojee.barginginfrance.net
ooksu.frost-electric-supply.com
oolsi.frost-electric-supply.com
oosee.barginginfrance.net
oowhe.frost-electric-supply.com
oprahsearch.com
optiker-michelmann.de
optilogus.com
optimization-methods.com
orbowlada.strefa.pl
orkut.krovatka.su
oshoa.iptvdeals.com
oshoo.iptvdeals.com
otylkaaotesanek.cz
outporn.com
ozzysixsixsix.web.fc2.com
pacan.gofreedom.info
pacman.gkgar.com
paraskov.com
patrickhickey.eu
pave.elisecries.com
pb-webdesign.net
peeg.fronterarq.cl
pension-helene.cz
pepelacer.computingservices123.com
perfectionautorepairs.com
personal.editura-amsibiu.ro
pgalvaoteles.pt
pharmadeal.gr
phitenmy.com
phoaz.cruisingsmallship.com
pic.starsarabian.com
pigra.csheaven.com
pix360.co.nf
plank.duplicolor.cl
plantaardigebrandstof.nl
plengeh.wen.ru
podzemi.myotis.info
pogruz.wanyizhao.net
pokachi.net
police11.provenprotection.net
pornstarss.tk
port.bg
portablevaporizer.com
portalfiremasters.com.br
portraitphotographygroup.com
pos-kupang.com
potvaporizer.com
powershopnet.net
pradakomechanicals.com
praxisww.com
pride-u-bike.com
private.hotelcesenaticobooking.info
privatkunden.datapipe9271.com
produla.czatgg.pl
progettocrea.org
prorodeosportmed.com
psooz.tourstogo.us
ptewh.iptvdeals.com
ptool.barginginfrance.net
ptuph.barginginfrance.net
ptush.iptvdeals.com
puenteaereo.info
pulso.butlerelectricsupply.com
pumpkin.brisik.net
purethc.com
pwvita.pl
pybul.bestfrozenporn.nl
q28840.nb.host127-0-0-1.com
quotidiennokoue.com
rainbowcolours.me.uk
rallyeair.com
raneevahijab.id
rat-on-subway.mhwang.com
rawoo.barginginfrance.net
reclamus.com
reishus.de
rentfromart.com
resolvethem.com
revistaelite.com
rl8vd.kikul.com
rocksresort.com.au
roks.ua
rolemodelstreetteam.invasioncrew.com
romsigmed.ro
romvarimarton.hu
roorbong.com
ross.starvingmillionaire.org
rsiuk.co.uk
ru.theswiftones.com
rubiks.ca
rufex.ajfingenieros.cl
ruiyangcn.com
rumog.frost-electric-supply.com
rupor.info
sadiqtv.com
saemark.is
safety.amw.com
salon77.co.uk
santacruzsuspension.com
sanya.vipc2f.com
sasson-cpa.co.il
sayherbal.com
sbnc.hak.su
scaner-do.tk
scaner-figy.tk
scaner-file.tk
scaner-or.tk
scaner-sbite.tk
scaner-sboom.tk
scaner-sdee.tk
scaner-tfeed.tk
scaner-tgame.tk
scanty.colormark.cl
scdsfdfgdr12.tk
scream.garudamp3.com
sdg-translations.com
securitywebservices.com
seet10.jino.ru
semengineers.com
semiyun.com
sentrol.cl
seoholding.com
seonetwizard.com
server1.extra-web.cz
sexyoilwrestling.com
sexyster.tk
sexzoznamka.eu
sgs.us.com
shoal.grahanusareadymix.com
shovi.frost-electric-supply.com
signready.com
silurian.cn
simpi.tourstogo.us
site-checksite.tk
ska.energia.cz
skgroup.kiev.ua
skidki-yuga.ru
skiholidays4beginners.com
slightlyoffcenter.net
slimxxxtubeacn.dnset.com
slimxxxtubealn.ddns.name
slimxxxtubeanr.ddns.name
slimxxxtubeaxy.ddns.name
slimxxxtubeayv.ddns.name
slimxxxtubebej.dnset.com
slimxxxtubebgp.ddns.name
slimxxxtubebmq.dnset.com
slimxxxtubebnd.ddns.name
slimxxxtubecgl.ddns.name
slimxxxtubectk.dnset.com
slimxxxtubecty.ddns.name
slimxxxtubeczp.ddns.name
slimxxxtubedgv.dnset.com
slimxxxtubedjm.ddns.name
slimxxxtubedlb.ddns.name
slimxxxtubedvj.dnset.com
slimxxxtubedxc.ddns.name
slimxxxtubedya.ddns.name
slimxxxtubeejs.ddns.name
slimxxxtubeemz.dnset.com
slimxxxtubefdr.ddns.name
slimxxxtubefel.ddns.name
slimxxxtubeftb.dnset.com
slimxxxtubefzc.ddns.name
slimxxxtubehan.ddns.name
slimxxxtubehdn.dnset.com
slimxxxtubehli.dnset.com
slimxxxtubeidv.ddns.name
slimxxxtubeijc.dnset.com
slimxxxtubeiqb.dnset.com
slimxxxtubejie.dnset.com
slimxxxtubejlp.ddns.name
slimxxxtubejpe.ddns.name
slimxxxtubejvh.ddns.name
slimxxxtubejyk.ddns.name
slimxxxtubekad.ddns.name
slimxxxtubekgj.ddns.name
slimxxxtubekgv.ddns.name
slimxxxtubeklg.dnset.com
slimxxxtubekpn.ddns.name
slimxxxtubekrn.ddns.name
slimxxxtubelap.ddns.name
slimxxxtubelat.ddns.name
slimxxxtubelfr.ddns.name
slimxxxtubelzv.ddns.name
slimxxxtubemue.dnset.com
slimxxxtubeneg.ddns.name
slimxxxtubeneu.ddns.name
slimxxxtubengt.dnset.com
slimxxxtubenqp.ddns.name
slimxxxtubentf.dnset.com
slimxxxtubeocr.dnset.com
slimxxxtubeonf.dnset.com
slimxxxtubeopy.ddns.name
slimxxxtubeoxo.ddns.name
slimxxxtubeoxy.ddns.name
slimxxxtubeppj.dnset.com
slimxxxtubeqfo.ddns.name
slimxxxtubeqsh.ddns.name
slimxxxtubeqve.dnset.com
slimxxxtubeqwr.dnset.com
slimxxxtuberau.ddns.name
slimxxxtuberea.ddns.name
slimxxxtuberep.dnset.com
slimxxxtuberfe.dnset.com
slimxxxtuberjj.ddns.name
slimxxxtuberme.dnset.com
slimxxxtuberue.dnset.com
slimxxxtubesrs.dnset.com
slimxxxtubesrw.ddns.name
slimxxxtubesun.ddns.name
slimxxxtubetmf.ddns.name
slimxxxtubetmg.dnset.com
slimxxxtubetns.ddns.name
slimxxxtubetts.dnset.com
slimxxxtubeubp.dnset.com
slimxxxtubeujh.ddns.name
slimxxxtubeull.dnset.com
slimxxxtubeuvd.dnset.com
slimxxxtubevdn.ddns.name
slimxxxtubevih.dnset.com
slimxxxtubevjk.ddns.name
slimxxxtubewfl.ddns.name
slimxxxtubewiq.ddns.name
slimxxxtubewis.ddns.name
slimxxxtubewmt.dnset.com
slimxxxtubexei.ddns.name
slimxxxtubexiv.dnset.com
slimxxxtubexvq.ddns.name
slimxxxtubexwb.dnset.com
slimxxxtubexxq.dnset.com
slimxxxtubeyge.ddns.name
slimxxxtubeyhz.ddns.name
slimxxxtubeyza.ddns.name
smartify.org
smilll.depozit.hr
smrcek.com
sn-gzzx.com
somethingnice.hc0.me
somnoy.com
soros.departamentosejecutivos.cl
soxorok.ddospower.ro
spatsz.com
spekband.com
sportsulsan.co.kr
spread.diadanoivabh.com.br
spykit.110mb.com
srslogisticts.com
ssl-6582datamanager.de
static.retirementcommunitiesfyi.com
stock.daydreamfuze.com
stopmeagency.free.fr
stork.escortfinder.cl
strangeduckfilms.com
structured.blackswanstore.com
sudcom.org
sunlux.net
sunny99.cholerik.cz
svetyivanrilski.com
svision-online.de
sweettalk.co
sysconcalibration.com
systemscheckusa.com
szinhaz.hu
tabex.sopharma.bg
tahit.wastech2016.in
tamilcm.com
tanner.alicerosenmanmemorial.com
tatschke.net
tavuks.com
tcrwharen.homepage.t-online.de
teameda.comcastbiz.net
teameda.net
tecnocuer.com
tecslide.com
tendersource.com
teprom.it
terem.eltransbt.ro
testtralala.xorg.pl
textsex.tk
thcextractor.com
thcvaporizer.com
thefxarchive.com
theweatherspace.com
thewinesteward.com
timothycopus.aimoo.com
titon.info
tk-gregoric.si
toddscarwash.com
tomalinoalambres.com.ar
tophostbg.net
traff1.com
trafficgrowth.com
trahic.ru
treventuresonline.com
TRIANGLESERVICESLTD.COM
trifle.ernstenco.be
troytempest.com
tscl.com.bd
ttb.tbddlw.com
tube8vidsbbr.dnset.com
tube8vidsbhy.dnset.com
tube8vidsbzx.dnset.com
tube8vidscjk.ddns.name
tube8vidscqs.ddns.name
tube8vidscut.ddns.name
tube8vidsdob.dnset.com
tube8vidsdst.ddns.name
tube8vidsfgd.ddns.name
tube8vidshhr.ddns.name
tube8vidshkk.ddns.name
tube8vidshrw.dnset.com
tube8vidsiet.ddns.name
tube8vidsiww.ddns.name
tube8vidsjac.dnset.com
tube8vidsjan.ddns.name
tube8vidsjhn.ddns.name
tube8vidsjtq.ddns.name
tube8vidslmf.dnset.com
tube8vidslni.dnset.com
tube8vidslqk.ddns.name
tube8vidslrz.ddns.name
tube8vidsnlq.dnset.com
tube8vidsnrt.ddns.name
tube8vidsnvd.ddns.name
tube8vidsnyp.dnset.com
tube8vidsolh.ddns.name
tube8vidsotz.dnset.com
tube8vidsowd.dnset.com
tube8vidspeq.ddns.name
tube8vidsqof.ddns.name
tube8vidsrau.dnset.com
tube8vidsrdr.dnset.com
tube8vidsrhl.ddns.name
tube8vidsrom.dnset.com
tube8vidssan.dnset.com
tube8vidssjw.ddns.name
tube8vidssyg.dnset.com
tube8vidstrh.dnset.com
tube8vidstyp.ddns.name
tube8vidsuty.dnset.com
tube8vidsvaj.dnset.com
tube8vidsvcs.ddns.name
tube8vidsvmr.ddns.name
tube8vidsvrx.ddns.name
tube8vidsvtp.dnset.com
tube8vidswsy.dnset.com
tube8vidswtb.ddns.name
tube8vidswys.ddns.name
tube8vidsxlo.ddns.name
tube8vidsxmx.dnset.com
tube8vidsxpg.ddns.name
tube8vidsxpp.dnset.com
tube8vidsxwu.ddns.name
tube8vidsycs.dnset.com
tube8vidsyip.ddns.name
tube8vidsymz.dnset.com
tube8vidsyre.dnset.com
tube8vidsyyf.dnset.com
tube8vidszmi.ddns.name
tube8vidsznj.ddns.name
tube8vidsznx.ddns.name
tube8vidszyj.ddns.name
tubemoviez.com
typeofmarijuana.com
ubike.tourstogo.us
uchyz.cruisingsmallship.com
ukonline.hc0.me
ukrfarms.com.ua
ukugl.tourstogo.us
unalbilgisayar.com
undefined.it
unitex.home.pl
unlim-app.tk
unlink.altitude.lv
up.mykings.pw
updat120.clanteam.com
update.51edm.net
update.onescan.co.kr
updo.nl
uploads.tmweb.ru
upsoj.iptvdeals.com
upswings.net
url-cameralist.tk
users173.lolipop.jp
utopia-muenchen.de
uvidu.butlerelectricsupply.com
v.inigsplan.ru
valouweeigenaren.nl
vdula.czystykod.pl
veevu.tourstogo.us
veksi.barginginfrance.net
vernoblisk.com
vette-porno.nl
victor.connectcloud.ch
videoflyover.com
villalecchi.com
vipdn123.blackapplehost.com
vistatech.us
vitalityxray.com
vitaly.agricolacolhue.cl
vitamasaz.pl
vitha.csheaven.com
vivaweb.org
vkont.bos.ru
vmay.com
vocational-training.us
vomit.facilitandosonhos.com.br
vroll.net
vural-electronic.com
vvps.ws
w4988.nb.host127-0-0-1.com
w612.nb.host127-0-0-1.com
wahyufian.zoomshare.com
wallpapers91.com
warco.pl
wc0x83ghk.homepage.t-online.de
web-domain.tk
web-fill.tk
web-olymp.ru
web-sensations.com
webcashmaker.com
webcom-software.ws
webordermanager.com
weboxmedia.by
websalesusa.com
websitebuildersinfo.in
welington.info
wetjane.x10.mx
wetyt.tourstogo.us
wfoto.front.ru
whabi.csheaven.com
whave.iptvdeals.com
whitehorsetechnologies.net
windspotter.net
winlock.usa.cc
winrar-soft.ru
winsetupcostotome.easthamvacations.info
wixx.caliptopis.cl
wkmg.co.kr
wmserver.net
womenslabour.org
womsy.bobbutcher.net
wonchangvacuum.com.my
wopper.bioblitzgaming.ca
worldgymperu.com
wp9.ru
writingassociates.com
wroclawski.com.pl
wt10.haote.com
wuvac.agwebdigital.com
wv-law.com
www.0uk.net
www.3difx.com
www.3peaks.co.jp
www.acquisizionevideo.com
www.actiagroup.com
www.advancesrl.eu
www.aerreravasi.com
www.airbornehydrography.com
www.airsonett.se
www.alphamedical02.fr
www.angolotesti.it
www.anticarredodolomiti.com
www.archigate.it
www.areadiprova.eu
www.arkinsoftware.in
www.assculturaleincontri.it
www.atousoft.com
www.autoappassionati.it
www.bcservice.it
www.blueimagen.com
www.casamama.nl
www.catgallery.com
www.caue971.org
www.ceisystems.it
www.cellularbeton.it
www.cerquasas.it
www.chiaperottipaolo.it
www.cifor.com
www.coloritpak.by
www.consumeralternatives.org
www.cortesidesign.com
www.daspar.net
www.del-marine.com
www.dezuiderwaard.nl
www.divshare.com
www.doctor-alex.com
www.donneuropa.it
www.dowdenphotography.com
www.downloaddirect.com
www.drteachme.com
www.eivamos.com
www.elisaart.it
www.email-login-support.com
www.emrlogistics.com
www.enchantier.com
www.fabioalbini.com
www.family-partners.fr
www.fasadobygg.com
www.feiyang163.com
www.fiduciariobajio.com.mx
www.fiocchidiriso.com
www.flowtec.com.br
www.fotoidea.com
www.freemao.com
www.freewebtown.com
www.frosinonewesternshow.it
www.fsm-europe.eu
www.galileounaluna.com
www.gameangel.com
www.gasthofpost-ebs.de
www.gennaroespositomilano.it
www.gliamicidellunicef.it
www.gmcjjh.org
www.gold-city.it
www.hausnet.ru
www.hitekshop.vn
www.hjaoopoa.top
www.hospedar.xpg.com.br
www.icybrand.eu
www.imagerieduroc.com
www.inevo.co.il
www.infra.by
www.jcmarcadolib.com
www.joomlalivechat.com
www.kcta.or.kr
www.kjbbc.net
www.lccl.org.uk
www.lifelabs.vn
www.litra.com.mk
www.lostartofbeingadame.com
www.lowes-pianos-and-organs.com
www.luce.polimi.it
www.lyzgs.com
www.m-barati.de
www.makohela.tk
www.marinoderosas.com
www.marss.eu
www.milardi.it
www.mondoperaio.net
www.montacarichi.it
www.motivacionyrelajacion.com
www.moviedownloader.net
www.northpoleitalia.it
www.notaverde.com
www.nothingcompares.co.uk
www.nuvon.com
www.obyz.de
www.offerent.com
www.officialrdr.com
www.ohiomm.com
www.oiluk.net
www.ostsee-schnack.de
www.outlinearray.com
www.over50datingservices.com
www.panazan.ro
www.perupuntocom.com
www.petpleasers.ca
www.pgathailand.com
www.pieiron.co.uk
www.poesiadelsud.it
www.praxisww.com
www.proascolcolombia.com
www.professionalblackbook.com
www.profill-smd.com
www.propan.ru
www.purplehorses.net
www.racingandclassic.com
www.realinnovation.com
www.rebeccacella.com
www.reifen-simon.com
www.rempko.sk
www.riccardochinnici.it
www.ristoromontebasso.it
www.rokus-tgy.hu
www.roltek.com.tr
www.rooversadvocatuur.nl
www.rst-velbert.de
www.saemark.is
www.salentoeasy.it
www.sankyo.gr.jp
www.sanseracingteam.com
www.sasenergia.pt
www.sbo.it
www.scanmyphones.com
www.scantanzania.com
www.schuh-zentgraf.de
www.seal-technicsag.ch
www.secondome.com
www.sieltre.it
www.sitepalace.com
www.sj88.com
www.slivki.com.ua
www.smartgvcfunding.com
www.smartscan.ro
www.sonnoli.com
www.spris.com
www.stirparts.ru
www.studiochiarelli.eu
www.studiolegaleabbruzzese.com
www.super8service.de
www.t-gas.co.uk
www.t-sb.net
www.tdms.saglik.gov.tr
www.technix.it
www.thesparkmachine.com
www.tiergestuetzt.de
www.toochattoo.com
www.torgi.kz
www.tpt.edu.in
www.tvnews.or.kr
www.two-of-us.at
www.unicaitaly.it
www.uriyuri.com
www.usaenterprise.com
www.vertourmer.com
www.vinyljazzrecords.com
www.vipcpms.com
www.vivaimontina.com
www.volleyball-doppeldorf.de
www.vvvic.com
www.whitesports.co.kr
www.widestep.com
www.wigglewoo.com
www.wildsap.com
www.wrestlingexposed.com
www.wyroki.eu
www.xiruz.kit.net
www.ywvcomputerprocess.info
www.zatzy.com
www.zctei.com
www.zyxyfy.com
www12.0zz0.com
www8.0zz0.com
xamateurpornlic.www1.biz
xicaxique.com.br
xindalawyer.com
xoomer.alice.it
xorgwebs.webs.com
xotsa.frenchgerlemanelectric.com
xpornstarsckc.ddns.name
yigitakcali.com
ylpzt.juzojossai.net
yougube.com
youtibe.com
youtuhe.com
yumekin.com
z32538.nb.host127-0-0-1.com
z7752.com
zgsysz.com
zibup.csheaven.com
zjjlf.croukwexdbyerr.net
zkic.com
zous.szm.sk
zt.tim-taxi.com
zyrdu.cruisingsmallship.com
EOF

# setting iptables
cat > /etc/rc.local <<-END
echo "1" > /proc/sys/net/ipv4/ip_forward
echo "1" > /proc/sys/net/ipv4/ip_dynaddr
 
iptables -A INPUT -i tun0 -j ACCEPT
iptables -A FORWARD -i tun0 -j ACCEPT
 
iptables -A INPUT -i tun1 -j ACCEPT
iptables -A FORWARD -i tun1 -j ACCEPT
 
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp -m tcp --dport 3306 -j ACCEPT

 
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.4.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.5.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE


exit 0;

END

/etc/rc.local
iptables-save

# set time GMT +8
ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime
# setting ufw
ufw allow ssh
ufw allow 1194/tcp

ufw enable
ufw status
ufw disable
# set ipv4 forward
echo 1 > /proc/sys/net/ipv4/ip_forward
sed -i 's|#net.ipv4.ip_forward=1|net.ipv4.ip_forward=1|' /etc/sysctl.conf
# restart apps
chmod 777 /etc/openvpn
chmod -R 755 /etc/openvpn
service openvpn restart
service squid3 restart
service stunnel4 restart
service openvpn stop
service openvpn start
# create openvpn account
useradd openvpn
echo "openvpn:0p3nvpn123" | chpasswd
clear
echo "######### Download your config files here! #########"
echo "~> http://$IPADDRESS/openvpn.ovpn - Normal config"
echo "~> http://$IPADDRESS/openvpnssl.ovpn - Config with stunnel"
echo "~> http://$IPADDRESS/stunnel.conf - Stunnel config file"
echo "~> http://$IPADDRESS/openvpn.tgz - All config"
echo "######### Download your config files here! #########"
echo "######### Autoscript by STARKDEVTEAM #########"
fi
