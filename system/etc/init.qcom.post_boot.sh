#!/system/bin/sh
# Copyright (c) 2009-2012, Code Aurora Forum. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of Code Aurora nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

target=`getprop ro.board.platform`

case "$target" in
    "msm8960")
     echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
     echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
     echo 90 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
     echo 50000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
     echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
     echo 4 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
     echo 10 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
     echo 384000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
     echo 384000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
	 echo 1512000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	 echo 1512000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
     chown system /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
     chown system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
     chown system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
     chown system /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
     chown system /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
     chown root.system /sys/devices/system/cpu/mfreq
     chmod 220 /sys/devices/system/cpu/mfreq
     chown root.system /sys/devices/system/cpu/cpu1/online
     chmod 664 /sys/devices/system/cpu/cpu1/online
#     chown system /sys/power/perflock
     chown system /sys/power/cpufreq_ceiling
     chown system /sys/power/cpunum_floor
     chown system /sys/power/cpunum_ceiling
     chown system /sys/power/powersave
     chown system /sys/power/launch_event
     chown system /sys/power/pnpmgr/apps/activity_trigger
     chmod 664 /sys/power/pnpmgr/apps/media_mode
     chown media.system /sys/power/pnpmgr/apps/media_mode
     chown system /sys/module/restart/parameters/notify_efs_sync
     echo "0,2,4,7,9,12" > /sys/module/lowmemorykiller/parameters/adj
	 chown system /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
        ;;
esac

#wifi fix
#insmod /system/lib/modules/prima_wlan.ko

#wifi fix for s3
insmod /system/lib/modules/dhd.ko "firmware_path=/system/etc/wifi/bcmdhd_apsta.bin nvram_path=/system/etc/wifi/nvram_net.txt"

emmc_boot=`getprop ro.emmc`
#case "$emmc_boot"
#    in "1")
#        chown system /sys/devices/platform/rs300000a7.65536/force_sync
#        chown system /sys/devices/platform/rs300000a7.65536/sync_sts
#        chown system /sys/devices/platform/rs300100a7.65536/force_sync
#        chown system /sys/devices/platform/rs300100a7.65536/sync_sts
#    ;;
#esac


# Post-setup services
case "$target" in
    "msm8660" | "msm8960")
        #start mpdecision
        start adaptive
    ;;
esac

