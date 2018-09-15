
if [ -d  /sys/bus/i2c/drivers/tfa98xx/2-0034 ] ;then

tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
tinymix 'RX3 MIX1 INP1' 'RX1'
tinymix 'SPK DAC Switch' 1
tinyplay /system/etc/mute300ms.wav
#tinyplay /system/etc/spk_play.wav
tinymix 'RX3 MIX1 INP1' 'ZERO'
tinymix 'SPK DAC Switch' 0
tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0

setprop sys.audio.tfa 1
fi

