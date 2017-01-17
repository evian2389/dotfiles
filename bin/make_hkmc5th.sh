#!/bin/bash

set -x

PWD=`pwd`
CWD=${PWD}
TARGET=${PWD##*corei7-64-oe-linux/}
TARGET=${TARGET%%/*}

BUILD_DIR=${PWD%%BUILD*}

if [ -z "$1" ]
then
	BUILD_OPT1="compile"
else
	BUILD_OPT1=$1
fi

cd $BUILD_DIR
source ./oe-init-build-env
bitbake -fC $BUILD_OPT1 ${TARGET}

cd ${PWD}


