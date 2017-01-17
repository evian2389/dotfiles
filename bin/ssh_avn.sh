#!/bin/bash

if [ -z "$1" ]
then
	ssh root@10.186.128.49
else
	ssh root@10.186.128.$1
fi

