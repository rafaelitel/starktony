#!/bin/bash
# SHC Installer
SHC_VERSION='4.0.2'
cd

# apt-get install lsb-release -y &> /dev/null
# yum install redhat-lsb-core -y &> /dev/null

clear
echo -e " SHC Installer"
echo -e " Please wait..."
sleep 2

if [ -e /usr/bin/shc ]; then
 echo -e " SHC Already Installed on your system, Please uninstall it first..";
 rm -rf shc*
 exit 1;
fi

if [ -e /etc/debian_version ]; then
 apt-get update
 apt-get install wget zip build-essential -y
 apt-get build-dep shc -y
fi
if [ -e /etc/ubuntu_version ]; then
 apt-get update
 apt-get install wget zip unzip build-essential -y
 apt-get build-dep shc -y
fi
if [ -e /etc/redhat-release ]; then
 yum update -y
 yum install wget zip unzip yum-utils -y
 yum group install "Development Tools" -y
 yum groupinstall "Development Tools" -y
 yum-builddep shc -y
fi

wget -qO shc.zip "https://github.com/neurobin/shc/archive/$SHC_VERSION.zip"
unzip -qq shc.zip
rm -rf shc.zip
cd shc-$SHC_VERSION
./configure
make
make install
cd ..
clear
echo -e ""
echo -e " SHC is now Installed"
echo -e " Try it now by typing the shc commands"
echo -e ""
rm -rf shc*

