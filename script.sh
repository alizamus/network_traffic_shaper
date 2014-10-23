#!/bin/bash
# Script to shape the traffic for user1 and user2 in any network topology.

#
#  tc uses the following units when passed as a parameter.
#  kbps: Kilobytes per second 
#  mbps: Megabytes per second
#  kbit: Kilobits per second
#  mbit: Megabits per second
#  bps: Bytes per second 
#       Amounts of data can be specified in:
#       kb or k: Kilobytes
#       mb or m: Megabytes
#       mbit: Megabits
#       kbit: Kilobits
#  To get the byte figure from bits, divide the number by 8 bit
#

# The network interface we're planning on limiting bandwidth.
IF=eth0             # Interface

#upload limit bandwidth
UPLD=$2

# IP address of the machine we are controlling
#IP=$2     # Host IP

# Port address of the machine we are controlling
PORT=$2

# Packet FLOW ID
FLOW=$3

# speed for the flow
SPEED=$4

stop(){
	tc qdisc del dev $IF root

}

start(){
	tc qdisc add dev $IF root handle 1: htb default 12
	tc class add dev $IF parent 1: classid 1:1 htb rate $UPLD ceil $UPLD
	tc class add dev $IF parent 1:1 classid 1:12 htb rate 1bps ceil $UPLD
}

add(){
	tc class add dev $IF parent 1:1 classid 1:$FLOW htb rate $SPEED ceil $SPEED
	#tc filter add dev $IF protocol ip parent 1:0 prio 1 u32 match ip dst $IP match ip sport $PORT 0xffff flowid 1:$FLOW
	tc filter add dev $IF protocol ip parent 1:0 prio 1 u32 match ip sport $PORT 0xffff flowid 1:$FLOW
}

restart() {

    stop
    sleep 1
    start

}

show() {

    tc -s qdisc ls dev $IF

}


case "$1" in

    start)
	echo "start of bandwidth shaping"
	start
	echo "done"
	;;

    add)
	echo "adding flow"
	add
	echo "done"
	;;

    stop)
	echo "stop bandwidth shaping" 
	stop
	echo "done"
	;;

    restart)

    	echo "Restarting bandwidth shaping: "
    	restart
    	echo "done"
    	;;

    show)
    	    	    
    	echo "Bandwidth shaping status for $IF:\n"
    	show
    	echo ""
    	;;

    *)
	pwd=$(pwd)
	echo "======================== Usage ========================"
	echo "Start    : ./script.sh {start} {max speed of link}"
	echo "Add      : ./script.sh {add} {port assigned for this flow} {unique flow ID (int!=12)} {speed of the flow}"
	echo "Stop     : ./script.sh {stop}"
	echo "Restart  : ./script.sh {restart} {new max speed of link}"
	echo "======================================================="
	;;
esac

exit 0

