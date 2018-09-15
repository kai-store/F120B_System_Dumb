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

tinymix 'LOOPBACK Mode' 'ENABLE'
sleep 0.5
tinymix 'DEC1 MUX' 'ADC1'
tinymix 'IIR1 INP1 MUX' 'DEC1'
tinymix 'RX1 MIX1 INP1' 'IIR1'
tinymix 'RX2 MIX1 INP1' 'IIR1'
tinymix 'RDAC2 MUX' 'RX2'
tinymix 'IIR1 INP1 Volume' 84
tinymix "ADC1 Volume" 6
tinymix 'DEC1 Volume' 84
tinymix 'RX1 Digital Volume' $play_volume
tinymix 'RX2 Digital Volume' $play_volume
tinymix 'HPHL' 'Switch'
tinymix 'HPHR' 'Switch'
tinymix 'Loopback MCLK' 'ENABLE'
