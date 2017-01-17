#!/bin/bash
set -x

cd .

TARGET_IP="10.186.128.49"

RPM_DIR=`find ../../ -type d -name "deploy-rpms"`
echo "RPM_DRIR=$RPM_DIR"


IFS=$'\r\n'
file_list=($(find $RPM_DIR -type f -name *.rpm | sort))
first_rpm_filename=(${file_list[0]})
echo "first_rpm_filename=$first_rpm_filename"
RPM_FILE_NAME=${first_rpm_filename##.*\/}
APP_NAME=${RPM_FILE_NAME%%-*}
BIN_FILE=`find ../../ -type f -iname ${APP_NAME} | grep image/app/bin/$APP_NAME`
echo RPM_FILE_NAME=$RPM_FILE_NAME
echo APP_NAME=$APP_NAME
echo APP_BIN_FILE=$BIN_FILE

if [ ! -f $first_rpm_filename ]
then
 echo "$first_rpm_filename is not exist.."
 exit
fi

USB_PATH_LIST=(`ssh root@10.186.128.49 "ls /media/usb/"`)
USB_PATH="/media/usb/${USB_PATH_LIST[0]}/"

echo USB_PATH_LIST=$USB_PATH_LIST
echo USB_PATH=$USB_PATH

ORI=$(ssh root@$TARGET_IP "ls $USB_PATH$APP_NAME.ori")
if [ "$ORI" == "$USB_PATH$APP_NAME.ori" ]
 then
 echo ${ORI} exist..
else
 echo copy "/app/bin/$APP_NAME.ori"...
 ssh root@$TARGET_IP "cp $USB_PATH$APP_NAME $USB_PATH$APP_NAME.ori"
fi

ssh root@10.186.128.49 "rm $USB_PATH$APP_NAME"
scp $BIN_FILE root@10.186.128.49:$USB_PATH$APP_NAME
scp $first_rpm_filename root@10.186.128.49:$USB_PATH$RPM_FILE_NAME
ssh root@10.186.128.49 "cd $USB_PATH; sync"
