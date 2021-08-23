set -x
#CCIC_PDK_ROOT=/home/jongho3/workspace/hkmc/ccIc/src/build_ccic
CCIC_PDK_ROOT=/home/jongho3/workspace/hkmc/ccIc/src/pdk_build/build-ccic/vendor/nvidia

IMGPATH="/home/jongho3/workspace/hkmc/ccIc/img/699-62382-0010-100_BB"

if [ -z $1 ]; then
    echo "IMGPATH=${IMGPATH}"
else
    IMGPATH=`readlink -f $1`
fi

IMGPATH=`readlink -f $IMGPATH`

#/dev/block/2450000.ufshci:1  => /dev/block/sdb
cd "${IMGPATH}/flash-images"
#find . -type f -iname FileToFlash.txt -exec sed -i -e 's/\/dev\/block\/2450000.ufshci:1/\/dev\/block\/sdb/g' {} \;
find ${IMGPATH}/flash-images/FileToFlash.txt -type f -exec sed -i -e 's/\/dev\/block\/2450000.ufshci:0/\/dev\/block\/sda/g' {} \;
find ${IMGPATH}/flash-images/FileToFlash.txt -type f -exec sed -i -e 's/\/dev\/block\/2450000.ufshci:1/\/dev\/block\/sdb/g' {} \;

cd ${CCIC_PDK_ROOT}

echo "##############"
echo `pwd`
echo "##############"

source ${CCIC_PDK_ROOT}/qnxenv.sh

cd drive*foundation/tools/host/flashtools/bootburn
#drive-t186ref-foundation/bootburn
echo "##############"
echo `pwd`
echo "##############"


find ./ -type f -exec sed -i -e 's/NVidia Corp/NVIDIA Corp/g' {} \;
find ./ -type f -exec sed -i -e 's/NVIDIA Corp\. \$/NVIDIA Corp/g' {} \;
find ./ -type f -exec sed -i -e 's/lsusb | grep -c /lsusb | grep -ci /g' {} \;


#./flash_bsp_images.sh  -b hkmc-ccic -P $1  [-z "--skunum 699-62382-0010-100 --setskuversion BB --setboardserial 1234 --setmacid eth0 0x00044b52f69b --setprodinfo 699-62382-0010-100 BB" ]
#./flash_bsp_images.sh  -b hkmc-ccic -P ${1}  -z "--skunum 699-62382-0010-100 --setskuversion BB --setboardserial 1234 --setmacid eth0 0x00044b52f69b --setprodinfo 699-62382-0010-100 BB"
#./flash_bsp_images.sh  -b hkmc-ccic -P ${1}
# → Root FS 제외한 전체 다운로드
#./bootburn.sh -b hkmc-ccic -s -p rsa_priv.pem
#→ Kernel만 다운로드
# ./bootburn.sh -b hkmc-ccic -u A_1_kernel A_1_kernel-dtb -p rsa_priv.pem
#./bootburn.sh -b hkmc-ccic
#sudo ./flash_bsp_images.sh -b hkmc-ccic -P ${IMGPATH} -z "--skunum 699-62382-0010-100 --setskuversion BB --setboardserial 1234 --setmacid eth0 0x020000000300 --setprodinfo 699-62382-0010-100 BB" 
sudo ./flash_bsp_images.sh -b hkmc-ccic -P ${IMGPATH}
