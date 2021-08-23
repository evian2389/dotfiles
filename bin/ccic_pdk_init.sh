CCIC_PDK_ROOT=/home/jongho3/workspace/hkmc/ccIc/src/build_ccic

mkdir -p ${CCIC_PDK_ROOT}
cd ${CCIC_PDK_ROOT}

git clone ssh://$(whoami)@vgit.lge.com:29440/hkmc/linux/build-ccic -b ccic_release
cd build-ccic


~/.local/bin/ccic_pdk_build.sh


#git clone ssh://jongho3.lee@vgit.lge.com:29440/hkmc/linux/build-ccic -b ccic_release
 cd drive-t186ref-foundation
 make -f Makefile.bind PCT=linux-qnx BOARD=hkmc-ccic clean
 make -f Makefile.bind PCT=linux-qnx BOARD=hkmc-ccic

#cd ${CCIC_PDK_ROOT}
#
#./coconutshell_128GB_32GB.sh
##1
#
#echo "BB_NUMBER_THREADS = \"8\"" >> coconutshell_128GB_32GB.sh
#echo "PARALLEL_MAKE = \"-j 8\""  >> coconutshell_128GB_32GB.sh
#
#./coconutshell_128GB_32GB.sh
##5
#
#
#./coconutshell_128GB_32GB.sh
##7
