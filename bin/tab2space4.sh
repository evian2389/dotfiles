#!/bin/bash

set -x

COMMIT_FILES=`git show --pretty="format:" --name-only -r $1`

for file in $COMMIT_FILES
do
	echo $file
	sed -i 's/\t/    /g' $file
	sed -i 's/[ \t]*$//' $file
done

set +x
