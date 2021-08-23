#!/bin/bash

ls -al /dev/ttyUSB*

set -x

port=3

if [ -z "$1" ]; then
	echo "port is empty..\n"
	port=3
else
	port=${1}
	echo "port is \$1..\n"
fi


sudo screen -L /dev/ttyUSB${port} 115200
