set -x
if [ -z $1 ]
then
    sshpass -p "prmavn6423?1" ssh root@${HU_IP}
else
    sshpass -p "prmavn6423?1" ssh root@$1
fi
