#!/bin/bash

repo forall -c "echo ------------------------ ; pwd ; git reset --hard HEAD^^^^^ ;  repo sync . -qcj4 ; git pull" 2>&1 | tee repo_sync.log
