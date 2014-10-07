#!/bin/bash

clear screen

echo "List running vms:"

vboxmanage list runningvms

read VBox
  vboxmanage controlvm $VBox poweroff

echo "Good bye!"
