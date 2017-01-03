#!/bin/bash

repo forall -c "echo ---------START----------- ; pwd ; git log --pretty=format:\"%h - %an, %ar : %s\" ; echo ----------end------------ " > git.log
