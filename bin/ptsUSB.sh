set -x

port="$1"

if [ -z "$port" ]; then
    CHECK=`ls /dev/pts/6`
    if [ true ]; then
    #if [ -z "${CHECK}" ]; then
        ccicMuxer.sh >> /tmp/uartMixer.log
        cat /tmp/uartMixer.log
    else
        cat /tmp/uartMixer.log
        ls -al /dev/pts/*
    fi
else
    #minicom -D /dev/pts/$1
    sudo screen /dev/pts/${port} 115200
fi


