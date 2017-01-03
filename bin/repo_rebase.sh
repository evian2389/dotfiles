#!/bin/bash

repo forall -c "echo ------------------------ ; pwd ; git reset --hard HEAD^^^^^ ; repo rebase . " 2>&1 | tee repo_rebase.log
