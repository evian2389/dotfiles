set -x
IP=$2
FILE=$1
DIR=$3
PW="root"

if [ -z "$DIR"]; then
    DIR=/home/root/
fi
if [ -z "$IP"]; then
    #IP=10.157.129.197
    IP=192.168.105.100
#    PW="!1qasw23ed4rf!"
    PW="root"
fi

sshpass -p ${PW} scp -r $1 root@${IP}:${DIR}
