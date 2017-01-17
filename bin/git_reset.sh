#!/bin/bash


for dir in * ; do
	if [[ -d "$dir/.git" ]]; then
		printf "\n===== $dir=====\n";
		pushd .
		cd "$dir";
		git reset --hard && git pull;
		scp -p -P 29411 jongho3.lee@mod.lge.com:hooks/commit-msg ./.git/hooks;
		popd
	fi
done

scp -p -P 29411 jongho3.lee@mod.lge.com:hooks/commit-msg ./.git/hooks
