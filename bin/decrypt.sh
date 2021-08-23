##공개키(public key)가 포함된 암호화 파일 :
##
##1)     ./DecryptToFile –d [비대칭키] [암호화 파일] [생성될 복호화 파일]
##
##예제) ./DecryptToFile –d prm-avn5-kor enc/TestFile.txt dec/TestFile.txt.dec
##
##2)     ./DecryptToFile –d [비대칭키] [암호화 파일] [생성될 복호화 파일] [비대칭 공개키]
##
##예제) ./DecryptToFile –d prm-avn5-kor enc/TestFile.txt dec/TestFile.txt.dec usb_update_pub.key
##
##ð  공개키(public key)가 미포함된 암호화 파일
##
##1)     ./DecryptToFile –d [비대칭키] [암호화 파일] [생성될 복호화 파일] [비대칭 공개키]
##
##예제) ./DecryptToFile –d prm-avn5-kor enc/TestFile.txt dec/TestFile.txt.dec usb_update_pub.key

./DecryptToFile –d key_premium5/prm-avn5-$1 $2 dec/$3
