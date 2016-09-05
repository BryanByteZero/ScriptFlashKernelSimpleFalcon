#!/sbin/sh

# copy old kernel to sdcard
if [ ! -e /sdcard/pre_zero_boot ]; then
	cp /tmp/boot.img /sdcard/pre_zero_boot.img
fi

# decompress ramdisk
mkdir /tmp/ramdisk
cd /tmp/ramdisk
gunzip -c ../boot.img-ramdisk.gz | cpio -i

# add init.d support if not already supported
found=$(find init.rc -type f | xargs grep -oh "run-parts /system/etc/init.d");
if [ "$found" != 'run-parts /system/etc/init.d' ]; then
        #find busybox in /system
        bblocation=$(find /system/ -name 'busybox')
        if [ -n "$bblocation" ] && [ -e "$bblocation" ] ; then
                echo "BUSYBOX FOUND!";
                #strip possible leading '.'
                bblocation=${bblocation#.};
        else
                echo "NO BUSYBOX NOT FOUND! init.d support will not work without busybox!";
                echo "Setting busybox location to /system/xbin/busybox! (install it and init.d will work)";
                #set default location since we couldn't find busybox
                bblocation="/system/xbin/busybox";
        fi
		#append the new lines for this option at the bottom
        echo "" >> init.rc
        echo "service userinit $bblocation run-parts /system/etc/init.d" >> init.rc
        echo "    oneshot" >> init.rc
        echo "    class late_start" >> init.rc
        echo "    user root" >> init.rc
        echo "    group root" >> init.rc
fi

#
# disable powerHal and mpdecision if enabled
# thanks to alberto & fabio for finding out the true location of powerhal
# adapt the idea of blechdose and modified by hurtsky for anykernel script usage
# a big thanks to this devs!
#
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

find . | cpio -o -H newc | gzip > ../newramdisk.cpio.gz
cd /
