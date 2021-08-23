CCIC_PDK_ROOT=/home/jongho3/workspace/hkmc/ccIc/src/build_ccic

cd ${CCIC_PDK_ROOT}

 ./changepath.sh

#Root FS 생성(CM이 올려줄 예정) - Provisioning 혹은 daily build 다운로드시에는 생략 가능
cd ${CCIC_PDK_ROOT}
 cd drive-t186ref-linux/
 mkdir targetfs_hyp/
 tar -xvf ccos-image-tegra-t18x.tar.gz -C targetfs_hyp/
 tar -xvf targetfs_sub.tar
 sudo cp ../drive-t186ref-foundation/bootburn/fstab_128G targetfs_hyp/etc/fstab
 cd ../drive-t186ref-foundation/

#Kernel Build
cd ${CCIC_PDK_ROOT}
 cd drive-oss-src
 ./ccic_vm1_kernel_make.sh
 ./ccic_vm1_kernel_image_copy.sh

#Hyphervisor Build
cd ${CCIC_PDK_ROOT}
 cd drive-t186ref-foundation
 make -f Makefile.bind PCT=linux-qnx BOARD=hkmc-ccic clean
 make -f Makefile.bind PCT=linux-qnx BOARD=hkmc-ccic


