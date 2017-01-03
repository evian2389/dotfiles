#!/bin/bash

#this is cscope index build script
# created by [jongho3.lee@lge.com] 2010.04.17
# modified by seungdae.goh@lge.com
#############variables###########################

CUR_DIR=`pwd`

CSCOPE_FILES=cscope.files
CSCOPE_OUT=cscope.out
TAGS_OUT=tags




echo "make cscope file"

LNX="kernel"

if [ -d $LNX ]; then
if [ "$1" == "kernel" -o "$1" == "kernel/" ]; then

echo "kernel file include ..."
find  $LNX                                                                \
	-path "$LNX/arch/*" ! -path "$LNX/arch/arm*" -prune -o               \
	-path "$LNX/tmp*" -prune -o                                           \
	-path "$LNX/Documentation*" -prune -o                                 \
	-path "$LNX/scripts*" -prune -o                                       \
        -name "*.[chxsS]" -print > ${CSCOPE_FILES}

#find  $LNX                                                                \
#	-path "$LNX/arch/*" ! -path "$LNX/arch/arm*" -prune -o               \
#	-path "$LNX/tmp*" -prune -o                                           \
#	-path "$LNX/Documentation*" -prune -o                                 \
#	-path "$LNX/scripts*" -prune -o                                       \
#	-path "$LNX/drivers*" -prune -o                                       \
#        -name "*.[chxsS]" -print > ${CSCOPE_FILES}

shift

fi
fi

if [ -n "$1" ]; then
ADD_DIR="$@"
else
ADD_DIR="$CUR_DIR"
fi


echo " "
echo "[$ADD_DIR]"
echo "################################### "
echo "indexing $ADD_DIR cscope.files "
find $ADD_DIR -type f \(  -iname '*.c' -o -iname '*.cpp' -o -iname '*.py' -o -iname '*.cc' -o -iname '*.h' -o -iname '*.asm' -o -iname '*.java' -o -iname '*.jni' -o -iname '*.mk' -o -iname '*.xml' -o -iname '*.aidl' -o -iname '*.s' -o -iname '*.S' -o -iname '*.rc' -o -iname '*defconfig' -o -iname '*.dts' -o -iname '*.dtsi' -o -iname '*.config' -o -iname 'Makefile' -o -iname 'Kconfig' -o -iname '*.sh' \) \
	-print > ${CSCOPE_FILES}

echo " "
echo "################################### "
echo "building cscope.out ...."
#make cscope ARCH=arm
cscope -b -q -k -i ${CSCOPE_FILES} -f ${CSCOPE_OUT}

#echo " "
echo "################################### "
echo "building ctags ...."
ctags -L ${CSCOPE_FILES} -f ${TAGS_OUT}





