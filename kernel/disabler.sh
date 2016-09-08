#!/sbin/sh

# disable powerHal and mpdecision if enabled
# thanks to alberto & fabio for finding out the true location of powerhal
# adapt the idea of blechdose and modified by hurtsky for anykernel script usage
# now i modified to work on old flash script since my ak is not working
# a big thanks to this devs!

if [ -e /system/vendor/lib/hw/power.msm8226.so ]; then
	[ -e /system/vendor/lib/hw/power.msm8226.so.bak ] || cp /system/vendor/lib/hw/power.msm8226.so /system/vendor/lib/hw/power.msm8226.so.bak;
	[ -e /system/vendor/lib/hw/power.msm8226.so ] && rm -f /system/vendor/lib/hw/power.msm8226.so;
fi;

# add another location (CM latest powerhal)
if [ -e /system/lib/hw/power.msm8226.so ]; then
	[ -e /system/lib/hw/power.msm8226.so.bak ] || cp /system/lib/hw/power.msm8226.so /system/lib/hw/power.msm8226.so.bak;
	[ -e /system/lib/hw/power.msm8226.so ] && rm -f /system/lib/hw/power.msm8226.so;
fi;

if [ -e /system/bin/mpdecision ]; then
	[ -e /system/bin/mpdecisionbak ] || cp /system/bin/mpdecision /system/bin/mpdecisionbak;
	[ -e /system/bin/mpdecision ] && rm -f /system/bin/mpdecision;
fi;
