PARAM=$1
IS_CCIC=`pwd | grep -i ccic`

if [ -z "${IS_CCIC}" ]; then
    #source /usr/local/oecore-x86_64/environment-setup-corei7-64-oe-linux
    source /usr/local/hkmc5th_SDK/environment-setup-corei7-64-oe-linux
else
    . /opt/drive5-linux/5.0.40.0-27058778/environment-setup-aarch64-gnu-linux
    #. /opt/drive5-linux/5.0.34.0-22152607/environment-setup-aarch64-gnu-linux

    #source /usr/local/ccic_SDK/environment-setup-aarch64-gnu-linux
fi
#source /usr/local/hkmc5th_SDK/environment-setup-corei7-64-oe-linux

if [ -z ${PARAM} ]; then
    PARAM="CONFIG+=LOCAL_CSystem"
    #PARAM+="CONFIG+=LOCAL_DCM"
else
    PARAM=$@
fi
echo "PARAM=${PARAM}"
qmake *.pro -spec linux-oe-g++ CONFIG+=debug CONFIG+=qml_debug ${PARAM}
make -j2
