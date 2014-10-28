#!/bin/bash
# Script assign bandwidth to each ports.
echo "<<<<<<<<<<<<<<<<<<<<<<start>>>>>>>>>>>>>>>>>>>>>>"
./script.sh stop
./script.sh start 15mbps
./script.sh add 50001 21 1mbps 121
./script.sh add 50002 22 1mbps 122
./script.sh add 50003 23 1mbps 123
./script.sh add 50004 24 1mbps 124
./script.sh add 50005 25 1mbps 125
./script.sh add 50011 31 1mbps 131
./script.sh add 50012 32 1mbps 132
./script.sh add 50013 33 1mbps 133
./script.sh add 50014 34 1mbps 134
./script.sh add 50015 35 1mbps 135
./script.sh add 22 41 200kbps 141
echo "<<<<<<<<<<<<<<<<<<<<<<<stop>>>>>>>>>>>>>>>>>>>>>"

