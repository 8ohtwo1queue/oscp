#!/bin/bash

# last updated: 20190524

# INFO
# according to Nmap documentation, the top 100 ports accounts for 78% of commonly used TCP ports
# this script is intended to get you on target as fast as possible by automating your scans for low hanging fruit and giving you some organizational flexibility
# https://www.youtube.com/watch?v=NnP5iDKwuwk

# USAGE
# customize the following as needed:
	# directory structure
	# target network

# change to appropriate directory
cd ~/scans/

# basic ping sweep
nmap -vvv -sn -oA 10.11.1.0_24-phase-01-ping.o.A 10.11.1.0/24

# for all hosts identified as online in ping sweep output...
for online_host in $(cat 10.11.1.0_24-phase-01-ping.o.A.gnmap | grep Up | cut -d " " -f 2); do
 # make a directory
 mkdir $online_host
 # change to directory
 cd $online_host
 # run scan against top 100 poorts
 nmap -vvv -F -oA $online_host-phase-02-top-100.A.O $online_host
 # create and append an aggregated file for quick, future reference
 cat $online_host-phase-02-top-100.A.O.gnmap >> ~/scans/10.11.1.0_24-phase-02-top-100.A.O.gnmap
 cat $online_host-phase-02-top-100.A.O.nmap >> ~/scans/10.11.1.0_24-phase-02-top-100.A.O.nmap
 cat $online_host-phase-02-top-100.A.O.xml >> ~/scans/10.11.1.0_24-phase-02-top-100.A.O.xml
 cd ..; done