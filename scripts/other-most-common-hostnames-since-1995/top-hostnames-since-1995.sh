#!/bin/bash

# last updated: 20190524

# INFO
# this script is used to compile a list of the top hostnames since 1995 as reported by the ISC
# directory for these reports is located here: https://ftp.isc.org/www/survey/reports/
# output file can be used to automate hostname lookups during penetration testing

# USAGE
# no customization needed, just run the script!

# download top hostnames from the first reported year, 1995 | create file
curl https://ftp.isc.org/www/survey/reports/1995/01/firstnames.txt -o hostnames.txt
# 1996 through 2008 use the same directory naming convention | append output to file
curl https://ftp.isc.org/www/survey/reports/{1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008}/01/firstnames.txt >> hostnames.txt
# naming convention changes in 2009; adjust URL | append output to file
curl https://ftp.isc.org/www/survey/reports/{2009,2010}/01/report.first.top100 >> hostnames.txt
# naming convention changes in 2011; adjust URL | append output to file
curl  https://ftp.isc.org/www/survey/reports/{2011,2012,2013,2014,2015,2016,2017,2018,2019}/01/first.txt >> hostnames.txt
# download the most current list | append output to file
curl https://ftp.isc.org/www/survey/reports/current/first.txt >> hostnames.txt

# cleanup
# note, this is poorly written and needs improvement because lol network engineer

# ignore HTML code (anything with a <, >, [, or include); ignore lines with the word "Top") | ignore blank lines | output to temporary file
cat hostnames.txt | egrep -v '<|>|\[|include|Top' | grep . > hostnames-clean-1.txt

# for every space, create a new line | output to temporary file
xargs -n1 < hostnames-clean-1.txt > hostnames-clean-2.txt 

# sort for unique values | output to temporary file
cat hostnames-clean-2.txt | sort -u > hostnames-clean-3.txt

# remove the hit counts for each hostname | output to usable file
cat hostnames-clean-3.txt | egrep -v '([0-9]+)' > top-hostnames-since-1995.txt

# cleanup temporary files
rm hostnames.txt
rm hostnames-clean-1.txt
rm hostnames-clean-2.txt
rm hostnames-clean-3.txt