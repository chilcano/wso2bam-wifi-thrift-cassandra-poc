#!/bin/bash

RPI2BAM_POC_HOME="/home/pi/_kismet_wso2bam_poc"
RPI2BAM_POC_PYTHON_THRIFT="/home/pi/_kismet2das/python-thrift-cli"

sudo apt-get -y update
mkdir -p $RPI2BAM_POC_HOME
cd $RPI2BAM_POC_HOME

# =========== GPSd, ntp, iw scripts ============ #
sudo apt-get install gpsd gpsd-clients ntp iw

# =========== Kismet installation ============ #
sudo apt-get -y install git
#sudo apt-get -y install ncurses-dev libpcap-dev libnl-dev
sudo apt-get -y install libncurses5-dev libpcre3-dev libpcap-dev libnl-dev
wget https://www.kismetwireless.net/code/kismet-2016-01-R1.tar.xz
tar xvfJ kismet-2016-01-R1.tar.xz
cd kismet-2016-01-R1
./configure 
make
sudo make install suidinstall
sudo usermod -a -G kismet pi

# =========== MAC Address Manufacturer file, plugins and log folder for Kismet ============ #
wget -O manuf http://anonsvn.wireshark.org/wireshark/trunk/manuf
sudo cp manuf /etc/manuf

# =========== Python and Python Thrift client installation ============ #
mkdir -p $RPI2BAM_POC_PYTHON_THRIFT
cd $RPI2BAM_POC_PYTHON_THRIFT
sudo apt-get -y install subversion
svn checkout --trust-server-cert --non-interactive https://github.com/chilcano/iot-server-appliances/trunk/Arduino%20Robot/PC_Clients/PythonRobotController/DirectPublishClient/BAMPythonPublisher
git -c http.sslVerify=false clone https://github.com/chilcano/kismetclient
wget https://raw.githubusercontent.com/chilcano/wso2bam-wifi-thrift-cassandra-poc/master/raspberrypi_wifi_traffic_capture/sendTrafficFromKismetToWSO2BAM.py

# =========== Copy the bash runner script ============ #
wget https://raw.githubusercontent.com/chilcano/wso2bam-wifi-thrift-cassandra-poc/master/raspberrypi_wifi_traffic_capture/2_rpi_poc_runner.sh
chmod +x 2_rpi_poc_runner.sh
mv 2_rpi_poc_runner.sh $RPI2BAM_POC_HOME/../.
