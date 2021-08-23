
IPADR=${1}

echo "IPADR=${IPADR}"

if [ -z "${IPADR}" ]; then
    #IPADR=10.157.129.197
    IPADR=192.168.105.100
fi



#sshpass -p "!1qasw23ed4rf!" ssh root@192.168.200.200
sshpass -p "root" ssh root@${IPADR}
#sshpass -p "!1qasw23ed4rf!" ssh root@192.168.33.3
#"sshpass -p "prmavn6423?1" ssh root@${HU_IP}
#"sshpass -p "prmavn6423?1" ssh root@$192.168.156.36
