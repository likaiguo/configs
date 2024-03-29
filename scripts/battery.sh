#!/bin/bash

# get-volume script returns the percantage of battery load
all=`acpi -b`
stat=`echo $all | head -n1 | awk '{print $4-0}';`

if [ "$stat" -le 30 ]; then
  notify-send 'Low battery' 'Please connect charger!' -i '/usr/share/icons/ubuntu-mono-dark/status/24/battery-low.svg'
elif [ "$stat" -le 10 ]; then
  notify-send 'Empty battery' 'The System will be shutdown in minutes!' -i '/usr/share/icons/ubuntu-mono-dark/status/24/battery_empty.svg'
elif ["$stat" -eq 85]; then
  notify-send 'Full charged' 'Please remove charger!' -i '/usr/share/icons/ubuntu-mono-dark/status/24/battery-080-charging.svg'
elif [ "$stat" -eq 100 ]; then 
  notify-send 'Full charged' 'Please remove charger!' -i '/usr/share/icons/ubuntu-mono-dark/status/24/battery-100.svg'
fi
