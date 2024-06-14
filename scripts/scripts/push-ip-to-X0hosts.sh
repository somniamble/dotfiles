#!/bin/sh

INTERFACE='eth0'
X0HOSTS='/mnt/c/Program Files (x86)/Xming/X0.hosts'

echo 'localhost' > "$X0HOSTS"
ip -o -4 a show dev $INTERFACE | awk '{print $4;}' | cut -d '/' -f 1 >> "$X0HOSTS"
