#!/sbin/sh

# Disable PowerHal and MPdecision if enabled
# thanks to Alberto & Fabio for finding out the true location of powerhal
# adapt the idea of Blechdose and modified by Hurtsky for AnyKernel script usage
# now i modified to work on old flash script since my AK is not working
# a big thanks to this devs!
# 2017, for now disabled, working on a kernel that can have multiple hotplugs and MPdecision/CMPowerHal working ok

#if [ -e /system/vendor/lib/hw/power.msm8226.so ]; then
#	[ -e /system/vendor/lib/hw/power.msm8226.so.bak ] || cp /system/vendor/lib/hw/power.msm8226.so /system/vendor/lib/hw/power.msm8226.so.bak;
#	[ -e /system/vendor/lib/hw/power.msm8226.so ] && rm -f /system/vendor/lib/hw/power.msm8226.so;
#fi;

# add another location (CM latest powerhal)
#if [ -e /system/lib/hw/power.msm8226.so ]; then
#	[ -e /system/lib/hw/power.msm8226.so.bak ] || cp /system/lib/hw/power.msm8226.so /system/lib/hw/power.msm8226.so.bak;
#	[ -e /system/lib/hw/power.msm8226.so ] && rm -f /system/lib/hw/power.msm8226.so;
#fi;
#
#if [ -e /system/bin/mpdecision ]; then
#	[ -e /system/bin/mpdecisionbak ] || cp /system/bin/mpdecision /system/bin/mpdecisionbak;
#	[ -e /system/bin/mpdecision ] && rm -f /system/bin/mpdecision;
#fi;
