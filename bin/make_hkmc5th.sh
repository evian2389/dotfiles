#!/bin/bash

PWD=`pwd`
CWD=${PWD}
TARGET=${PWD##*corei7-64-oe-linux/}
TARGET=${TARGET%%/*}

BUILD_DIR=${PWD%%BUILD*}

cd $BUILD_DIR
source ./oe-init-build-env
bitbake -fC compile ${TARGET}

cd ${PWD}


