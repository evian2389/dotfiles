#!/bin/bash
set -x

cd .

if [ "$1" == "" ]
then
 echo "parma1b=[$1] is empty exit.."
 exit
fi

ORI=$(ssh root@10.186.128.49 "ls /app/bin/$1.ori")
if [ "$ORI" == "/app/bin/$1.ori" ]
 then
 echo ${ORI} exist..
else
 echo copy "/app/bin/$1.ori"...
 ssh root@10.186.128.49 "cp /app/bin/$1 /app/bin/$1.ori"
fi

ssh root@10.186.128.49 "rm ~/$1 ; rm /app/bin/$1"
scp $1 root@10.186.128.49:/home/root/
ssh root@10.186.128.49 "cp /home/root/$1 /app/bin/$1"
ssh root@10.186.128.49 "cd /app/bin/; sync"
