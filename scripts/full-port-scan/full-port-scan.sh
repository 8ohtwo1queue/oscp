#!/bin/bash

# last updated: 20190524

# INFO
# this script assumes you have run the get-on-target.sh script
# run this script in the background while you work on your low hanging fruit

# USAGE
# customize the following as needed:
	# directory structure
	# target network

# change to appropriate directory
cd ~/scans/

# for all hosts identified as online in ping sweep output...
for online_host in $(cat 10.11.1.0_24-phase-01-ping.o.A.gnmap | grep Up | cut -d " " -f 2); do
 # change to directory
 cd $online_host
 # run scan against top 100 ports
 nmap -vvv -p- -oA $online_host-phase-04-full-port-scan.o.A $online_host


 -p T1:65535U:53,111,137,T:21-25,80
 #nmap -vvv -F -oA $online_host-phase-02-top-100.A.O $online_host
 # create and append an aggregated file for quick, future reference
 cat $online_host-phase-04-full-port-scan.o.A.gnmap >> ~/scans/10.11.1.0_24-phase-04-full-port-scan.o.A.gnmap
 cat $online_host-phase-04-full-port-scan.o.A.nmap >> ~/scans/10.11.1.0_24-phase-04-full-port-scan.o.A.nmap
 cat $online_host-phase-04-full-port-scan.o.A.xml >> ~/scans/10.11.1.0_24-phase-04-full-port-scan.o.A.xml
 cd ..; done