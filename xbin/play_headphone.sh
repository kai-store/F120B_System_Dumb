#!/system/bin/sh
audio_file=$1
play_volume=$2
play_mode=$3


if [ "x$audio_file" == "x" ] ; then
	exit 1
fi

if [ "x$play_volume" == "x" ] ; then
	play_volume=70
fi


tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1' 1
tinymix 'RX1 MIX1 INP1' 'RX1'
tinymix 'RX2 MIX1 INP1' 'RX2'
tinymix 'RDAC2 MUX' 'RX2'

tinymix 'RX1 Digital Volume' $play_volume
tinymix 'RX2 Digital Volume' $play_volume

if [ "x$play_mode" == "xL" ] ; then
	tinymix 'HPHL' 1
	tinymix 'HPHR' 0
elif [ "x$play_mode" == "xR" ] ; then
	tinymix 'HPHL' 0
	tinymix 'HPHR' 1
else
	tinymix 'HPHL' 1
	tinymix 'HPHR' 1
fi



tinyplay $audio_file

#Disable Sequence:
tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1' 0
tinymix 'RX1 MIX1 INP1' 'ZERO'
tinymix 'RX2 MIX1 INP1' 'ZERO'
tinymix 'RDAC2 MUX' 'ZERO'
tinymix 'HPHL' 0
tinymix 'HPHR' 0