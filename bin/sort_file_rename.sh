#!/bin/bash

IFS=$'\r\n'
FILE_EX1=$1
FILE_EX2=$2

fc=0
sc=0
tc=0

fct=0
sct=0
tct=0

first_file_list=($(ls -v *.${FILE_EX1}))
printf '%s\n' "${first_file_list[@]}"
fct=${#first_file_list[@]}
echo numOfFiles \*\.$FILE_EX1 is $fct

second_file_list=($(ls -v *.${FILE_EX2}))
printf '%s\n' "${second_file_list[@]}"
sct=${#second_file_list[@]}
echo numOfFiles \*\.$FILE_EX2 is $sct

echo numOfFirstFile=$fct
echo numOfSecondFile=$sct

echo "#################"

if [ $fct -lt $sct ]
then tct=$fct
else tct=$sct
fi
echo tct=$tct

while [ $tc -lt $tct ]
do
    echo "############ $((tc + 1)) ############"
    first_filename=(${first_file_list[$tc]})
    first_filename=(${first_filename%%"$FILE_EX1"})
    second_filename=(${second_file_list[$tc]})
    echo "$first_filename"
    echo "$second_filename"
    echo mv "$second_filename" "$first_filename$FILE_EX2"
    mv "$second_filename" "$first_filename$FILE_EX2"
    tc=$(($tc + 1))
done

