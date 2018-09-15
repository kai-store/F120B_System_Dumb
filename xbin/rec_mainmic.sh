#!/system/bin/sh
play_volume=$2

if [ "x$play_volume" == "x" ] ; then
	play_volume=75
fi

tinymix 'MultiMedia1 Mixer TERT_MI2S_TX' 1
tinymix 'DEC1 MUX' 'ADC1'

tinycap /data/record_mainmic.wav -c 1 -r 22050 &

tinycap_pid=$!

sh /system/xbin/play_spk.sh $1 $play_volume

kill -s INT $tinycap_pid
wait
tinymix 'MultiMedia1 Mixer TERT_MI2S_TX' 0
tinymix 'DEC1 MUX' 'ZERO'
chmod 666 /data/record_mainmic.wav

sh /system/xbin/play_headphone.sh /system/etc/rec_playback.wav play_volume


sh /system/xbin/play_headphone.sh /data/record_mainmic.wav 
