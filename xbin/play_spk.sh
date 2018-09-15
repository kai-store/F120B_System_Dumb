#!/system/bin/sh
audio_file=$1
play_volume=$2
if [ "x$audio_file" == "x" ] ; then
	exit 1
fi

if [ "x$play_volume" == "x" ] ; then
	play_volume=75
fi
if [ -d  /sys/bus/i2c/drivers/tfa98xx/2-0034 ] ;then
tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
tinymix 'RX3 MIX1 INP1' 'RX1'
tinymix 'SPK DAC Switch' 1
tinymix 'TFA Profile' 'hp_test'

if [ $play_volume -ge 99 ] ; then
play_volume=99
fi
play_volume=`echo $play_volume |busybox awk '{print int($1/10) }'`

echo "play_volume=$play_volume"
tinymix "TFA hp_test Playback Volume"  $play_volume
else
tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1' 1
tinymix 'RX3 MIX1 INP1' 'RX1'
tinymix 'SPK DAC Switch' 1
tinymix 'Speaker Boost' 'ENABLE'


tinymix 'RX3 Digital Volume' $play_volume

fi


tinyplay $1
if [ -d  /sys/bus/i2c/drivers/tfa98xx/2-0034 ] ;then
	tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
	tinymix 'TFA Profile' 'hp'
else
	tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1' 0
fi
tinymix 'RX3 MIX1 INP1' 'ZERO'
tinymix 'SPK DAC Switch' 0
