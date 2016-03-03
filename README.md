# PoC - Capturing WIFI traffic in Real Time using WSO2 BAM, Kismet, Thrift and Cassandra

This repository contains:

- A toolbox to view incoming Kismet traffic (802.11) in realtime valid for WSO2 BAM 2.5.0.
- A set of definitions to create Execution Plan (CEP Shiddi), Input and Output Stream Definitions (Apache Thrift), and Formatters.

## Considerations

- I've used WSO2 BAM 2.5.0 (standard configuration without changes and with offset 0)
- I've used a Raspberry Pi as agent to send captured 802.11 traffic to WSO2 BAM by using Apache Thrift. 
- I've used a Python Thrift and Kismet script to send the captured traffic. 

## How to use

__1) Send Kismet traffic to WSO2 BAM using Apache Thrift listener__

- Follow this first blog post to configure your Device to capture anonymous 802.11 traffic.
https://holisticsecurity.wordpress.com/2016/02/02/everything-generates-data-capturing-wifi-anonymous-traffic-raspberrypi-wso2-part-i

- Follow this second blog post to send 802.11 captured traffic to WSO2 BAM / Apache Thrift listener.
https://holisticsecurity.wordpress.com/2016/02/04/everything-generates-data-capturing-wifi-anonymous-traffic-using-raspberry-pi-and-wso2-bam-part-ii

- Check if the Kismet Input Stream was created in WSO2 BAM - Input Streams. If so, WSO2 BAM is receiving the incoming Kismet traffic by Thrift listener.


__2) Deploy the WSO2 BAM Kismet toolbox__

- Deploy the kismet_wifi_realtime_traffic.tbox in WSO2 BAM.
- Check if WSO2 BAM toolbox was deployed successfully.


![Kismet Real Time Toolbox for WSO2 BAM](https://github.com/chilcano/wso2bam-wifi-thrift-cassandra-poc/blob/master/chilcano-wso2bam-wifi-thrift-cassandra-1-toolbox.png "Kismet Real Time Toolbox for WSO2 BAM")


__3) Deploy the set of Stream and Execution Plan definitions__

Copy the set of definitions to create Execution Plan (CEP Shiddi), Input and Output Stream Definitions (Apache Thrift), and Formatters to WSO2 BAM manually.
All files and directories to be copied are under `wso2bam-wifi-thrift-cassandra-poc/wso2bam_defns/` and have to be copied to `<WSO2BAM_HOME>/`.


_Structure of file definitions and directories_
![Input/Output Stream, Execution Plan and Formatters for WSO2 BAM](https://github.com/chilcano/wso2bam-wifi-thrift-cassandra-poc/blob/master/chilcano-wso2bam-wifi-thrift-cassandra-2-dirs.png "Input/Output Stream, Execution Plan and Formatters for WSO2 BAM")

_Two Output Streams deployed into WSO2 BAM_
![Input/Output Stream, Execution Plan and Formatters for WSO2 BAM](https://github.com/chilcano/wso2bam-wifi-thrift-cassandra-poc/blob/master/chilcano-wso2bam-wifi-thrift-cassandra-3-defns.png "Input/Output Stream, Execution Plan and Formatters for WSO2 BAM")


__4) Visualizing Kismet (802.11) traffic in WSO2 BAM Dashboard__

If everything is OK, then you can see the incoming traffic in realtime, to do that, you have to use the previously installed/deployed WSO2 BAM toolbox.
Then, login to WSO2 BAM Dashboard and select the `Kismet WIFI Realtime Monitoring` graphic. You should see the following.


_Visualizing Captured Kismet Traffic in Realtime from WSO2 BAM Dashboard_
![Visualizing Captured Kismet Traffic in Realtime](https://github.com/chilcano/wso2bam-wifi-thrift-cassandra-poc/blob/master/chilcano-wso2bam-wifi-thrift-cassandra-4-kismet.png "Visualizing Captured Kismet Traffic in Realtime")


__5) Working with the Docker MAC Address Manufacturer Lookup__

If you want to get the MAC Address Manufacturer for each MAC address captured automatically, you could use the Docker MAC Address Manufacturer Lookup (now `Docker MAC Manuf`) prepared to do that.
Just download and run the [`Docker MAC Manuf`](https://hub.docker.com/r/chilcano/docker-mac-manuf) and start your WSO2 BAM with `kismet_wifi_realtime_traffic.tbox` previously deployed and voilà!.

The `kismet_wifi_realtime_traffic.tbox` is prepared to call to `Docker MAC Manuf` to get the MAC Address Manufacturer.
The configuration by defaul is:

* MAC Manuf lookup REST Service - URL: https://192.168.99.100:5443
* MAC Manuf lookup REST Service - Context: chilcano/api
* MAC Manuf lookup REST Service - Resource: manuf/{macAddress}

At the end, when WSO2 BAM and `Docker MAC Manuf` are running, you will see the next:
![Visualizing Captured WIFI Traffic in Realtime and MAC Address Manufacturer](https://github.com/chilcano/wso2bam-wifi-thrift-cassandra-poc/blob/master/chilcano-wso2bam-wifi-thrift-cassandra-5-kismet-toolbox-docker-manuf "Visualizing Captured WIFI Traffic in Realtime and MAC Address Manufacturer")


