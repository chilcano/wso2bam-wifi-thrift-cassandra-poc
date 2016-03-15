#!/bin/bash
echo "Starting gpsd and Kismet, Logging to Desktop/kismet"

# adding and setting mon0 in monitor mode
sudo iw phy phy0 interface add mon0 type monitor
sudo iw dev wlan0 del

# setting mon0 is in monitor mode
sudo ifconfig mon0 down
sudo iwconfig mon0 mode monitor
sudo ifconfig mon0 up

# enabling GPS
#sudo killall gpsd
#sudo gpsd /dev/ttyUSB0 -F /var/run/gpsd.sock
#sudo service gpsd restart
#sleep 3

# refreshing the Time server
sudo service ntp restart
sleep 3

# starting Kismet server in background
kismet_server -p /home/pi/kismet_logs -c mon0 --daemonize

# running the Python Thrift Client
#sleep 5
#cd /home/pi/kismet_to_wso2bam
#python sendTrafficFromKismetToWSO2BAM.py