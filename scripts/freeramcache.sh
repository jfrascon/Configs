#!/usr/bin/env bash

# Make a link to this file in $HOME/bin/freecacheram.sh

free -h
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf "\n%s\n" "Ram-cache and swap cleared"'
free -h
