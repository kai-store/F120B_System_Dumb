#!/system/bin/sh

while [ x`getprop sys.audio.init` != 'xtrue' ] 
do
    echo "waiting audio init finish"
    sleep 1
done


tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
tinymix 'RX3 MIX1 INP1' 'RX1'
tinymix 'SPK DAC Switch' 1
tinymix 'Speaker Boost' 'ENABLE'

tinyplay /system/etc/mute.wav &
tinyplay_pid=$!
rm /data/audio_cal.log
sleep 2
climax_hostSW -d /dev/i2c-2 --slave=0x34 -l /etc/firmware/tfa98xx.cnt --resetMtpEx
impedance=`climax_hostSW -d /dev/i2c-2 --slave=0x34 -l /etc/firmware/tfa98xx.cnt --calibrate=once|grep "Calibration value is"|busybox awk '{print $4}'`
#impedance=`climax_hostSW -d /dev/i2c-2 --slave=0x34 -A|grep "Calibration value is"|busybox awk '{print $4}'`

kill -s INT $tinyplay_pid
wait

tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
tinymix 'RX3 MIX1 INP1' 'ZERO'
tinymix 'SPK DAC Switch' 0

touch /data/audio_cal.log
chmod 666 /data/audio_cal.log

if [ -d  /sys/bus/i2c/drivers/tfa98xx/2-0034 ] ;then
echo "impedance is ${impedance} ohm"
impedance=$(busybox awk "BEGIN{print ${impedance}*100 }"|busybox awk '{printf("%d\n",$0)}')

echo impedance is ${impedance} 

if [ "x${impedance}" == "x" ] ; then
	echo "0" >> /data/audio_cal.log
	echo "Fail" >> /data/audio_cal.log
	echo "\nAudio cal end" >> /data/audio_cal.log
	exit 1
fi
echo ${impedance} >> /data/audio_cal.log

if [ ${impedance}  -ge 960 ] ;then
	echo "Fail" >> /data/audio_cal.log
	echo "\nAudio cal end" >> /data/audio_cal.log
	exit 1
fi

if [ ${impedance}  -le 640 ] ;then
	echo "Fail" >> /data/audio_cal.log
	echo "\nAudio cal end" >> /data/audio_cal.log
	exit 1
fi


echo "Pass" >> /data/audio_cal.log
echo "\nAudio cal end" >> /data/audio_cal.log
exit 0

else   # non spa return 800;
echo -1 >> /data/audio_cal.log
echo "Pass" >> /data/audio_cal.log
echo "\nAudio cal end" >> /data/audio_cal.log
exit 0
fi
