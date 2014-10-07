#!/bin/bash
 
clear screen
 
echo "Please enter the name of the image as it appears in the list:"

vboxmanage list vms

read VBox
    vboxmanage startvm $VBox --type headless

echo "Currently running VBox Images"

vboxmanage list runningvms
