#!/bin/bash

while :
do
    clear
    git --no-pager log --graph --pretty=oneline --abbrev-commit --decorate --all $*
    sleep 1
done


#!/bin/bash

#while :
#do
#    clear
#    git --no-pager log `git rev-parse HEAD` -n $* --graph --pretty=oneline --abbrev-commit --decorate
#    sleep 1
#done
