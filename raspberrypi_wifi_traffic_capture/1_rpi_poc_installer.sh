#!/bin/bash


sudo apt-get -y update

mkdir -p _kismet2das
mkdir -p _kismet2das/python-thrift-cli
cd _kismet2das

# =========== Kismet installation ============ #
sudo apt-get -y install --only-upgrade git
sudo apt-get -y install ncurses-dev libpcap-dev libnl-dev
wget https://www.kismetwireless.net/code/kismet-2016-01-R1.tar.xz
tar xvfJ kismet-2016-01-R1.tar.xz
cd kismet-2016-01-R1
./configure 
make
sudo make install suidinstall
sudo usermod -a -G kismet pi

# =========== MAC Address Manufacturer file for Kismet ============ #
cd ../
wget -O manuf http://anonsvn.wireshark.org/wireshark/trunk/manuf
sudo cp manuf /etc/manuf

# =========== Python and Python Thrift client installation ============ #

cd python-thrift-cli
sudo apt-get -y install subversion
svn checkout --trust-server-cert --non-interactive https://github.com/chilcano/iot-server-appliances/trunk/Arduino%20Robot/PC_Clients/PythonRobotController/DirectPublishClient/BAMPythonPublisher
git -c http.sslVerify=false clone https://github.com/chilcano/kismetclient
