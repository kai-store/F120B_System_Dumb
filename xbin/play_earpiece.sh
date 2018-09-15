#!/system/bin/sh
audio_file=$1
play_volume=$2

if [ "x$audio_file" == "x" ] ; then
	exit 1
fi

if [ "x$play_volume" == "x" ] ; then
	play_volume=100
fi
tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1' 1
tinymix 'RX1 MIX1 INP1' 'RX1'
tinymix 'RX1 Digital Volume' $play_volume
tinymix 'RDAC2 MUX' 'RX1'
tinymix 'EAR_S' 1  #'EAR_S Switch'
tinyplay $audio_file

tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1' 0
tinymix 'RX1 MIX1 INP1' 'ZERO'
tinymix 'RDAC2 MUX' 'ZERO'
tinymix 'EAR_S' 0
