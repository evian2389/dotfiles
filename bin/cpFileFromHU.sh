set -x
IP=$2
FILE=$1
if [ -z "$IP"]; then
#    IP=10.157.129.197
    IP=192.168.105.100
#    IP=192.168.33.3
    #PW="!1qasw23ed4rf!"
    PW="root"
fi
sshpass -p ${PW} "scp -r root@${IP}:$1 ."
