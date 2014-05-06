#!/bin/bash
# display uptime for xmobar

up=$(uptime -p | sed 's/up //g')


echo $up | sed 's/minutes/min/g; s/minute/min/g; s/hours/hr/g; s/hour/hr/g; s/days/d/g; s/day/d/g; s/ //g'
