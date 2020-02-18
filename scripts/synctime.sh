#!/usr/bin/env bash

# NOTE: Check out your /etc/ntp.conf file to know which time servers
# your machine is synchronized with.

# Make a link to this file in $HOME/bin/synctime.sh

timedatectl set-ntp off   # Disable synchronization via systemd-timesyncd
sudo systemctl stop ntp   # Stop ntp service
sleep 1
sudo systemctl status ntp 
sleep 3
sudo ntpd -gq             # Force synchronization with the time server
sudo hwclock -w           # Synchronize the real time clock
sudo systemctl start ntp  # Start the ntp service
sleep 1
sudo systemctl status ntp
#ntpq -p                  # Query info

