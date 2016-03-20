#!/bin/bash

##
##	sets xeon processors to full steam ahead
##

for cpu in `find /sys/devices/system/cpu -iname scaling_governor`; do
        echo performance > $cpu
done


