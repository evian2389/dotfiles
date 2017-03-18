#!/bin/bash
set -x

cd .

if [ -z "$1" ]
then
TARGET_IP="10.186.128.49"
else
TARGET_IP="10.186.128.$1"
fi

RPM_DIR=`find ../../ -type d -name "deploy-rpms"`
echo "RPM_DRIR=$RPM_DIR"


IFS=$'\r\n'
file_list=($(find $RPM_DIR -type f -name *.rpm | sort))
first_rpm_filename=(${file_list[0]})
echo "first_rpm_filename=$first_rpm_filename"
RPM_FILE_NAME=${first_rpm_filename##.*\/}
APP_NAME=${RPM_FILE_NAME%%-*}
echo RPM_FILE_NAME=$RPM_FILE_NAME
echo APP_NAME=$APP_NAME

if [ ! -f $first_rpm_filename ]
then
 echo "$first_rpm_filename is not exist.."
 exit
fi

ssh root@$TARGET_IP "mount -o rw,remount /"

ORI=$(ssh root@$TARGET_IP "ls /home/root/$APP_NAME.ori")
if [ "$ORI" == "/app/bin/$APP_NAME.ori" ]
 then
 echo ${ORI} exist..
else
 echo copy "/app/bin/$APP_NAME.ori"...
 ssh root@$TARGET_IP "cp /app/bin/$APP_NAME /home/root/$APP_NAME.ori"
fi

ssh root@$TARGET_IP "rm ~/$RPM_FILE_NAME ; rm /app/bin/$APP_NAME"
scp $first_rpm_filename root@$TARGET_IP:/home/root/
ssh root@$TARGET_IP "rpm -ivh --force --nodeps /home/root/$RPM_FILE_NAME"
ssh root@$TARGET_IP "rm /home/root/$APP_NAME.new"
ssh root@$TARGET_IP "cd /app/bin/; sync"
