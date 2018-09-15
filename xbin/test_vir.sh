#!/system/bin/sh
if [ $1 = 0 ] ; then
echo 10000 > /sys/class/timed_output/vibrator/enable
else
echo 0 > /sys/class/timed_output/vibrator/enable
fi