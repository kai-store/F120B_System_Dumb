#!/system/bin/sh


echo $0 $1 start >> /data/log.txt

wait_kai_release_audio() {
	 while :
		do
			res=`tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1'|grep Off`
			if [ "x$res" = "x" ] ; then
				echo "Some audio is playing" >> /data/log.txt
				sleep 1
			else
				break
				sleep 1
			fi
	done
}
main_mic_loop_test()
{

if [ -d  /sys/bus/i2c/drivers/tfa98xx/2-0034 ] ;then
	echo "Smart PA loop back"
	tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
	tinymix 'RX3 MIX1 INP1' 'RX1'
	tinymix 'SPK DAC Switch' 1
	tinymix 'RX3 Digital Volume' '30'
	tinymix "QUAT_MI2S_RX Port Mixer TERT_MI2S_TX" 1
	tinymix 'MultiMedia1 Mixer TERT_MI2S_TX' 1
	#tinymix 'MultiMedia1 Mixer TERT_MI2S_TX' 1
	tinymix 'ADC1 Volume' '3'
        tinymix "DEC1 Volume" '60'
	tinymix 'DEC1 MUX' 'ADC1'
	tinyhostless -D 0  -C 0 -P 0 -p 256 -n 2 -r 8000 -c 2 &

	pid=$!
	echo $pid > /data/audio_play.pid
else      

      sleep 0.5
	tinymix 'LOOPBACK Mode' 'ENABLE'
	sleep 0.5
	tinymix 'ADC1 Volume' '5'
	tinymix 'DEC1 MUX' 'ADC1'
	tinymix 'RDAC2 MUX' 'RX1'
	tinymix 'IIR1 INP1 MUX' 'DEC1'
	tinymix 'RX3 MIX1 INP1' 'IIR1'	
	tinymix 'RX1 Digital Volume' '124'
	tinymix 'DEC1 Volume' '90'
	tinymix 'SPK DAC Switch' '1'
	tinymix 'Loopback MCLK' 'ENABLE'
fi
}

stop_main_mic_loop_test(){
if [ -d  /sys/bus/i2c/drivers/tfa98xx/2-0034 ] ;then
	
	if [ -f /data/audio_play.pid ];then
	   		pid=`cat /data/audio_play.pid`
	   		echo kill -9 $pid
	   		kill -9 $pid
	   	    rm /data/audio_play.pid
	fi
	tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
	tinymix 'ADC1 Volume' '4'	
	tinymix 'DEC1 MUX' 'ZERO'
	tinymix 'RDAC2 MUX' 'ZERO'
	tinymix 'IIR1 INP1 MUX' 'ZERO'
	tinymix 'RX3 MIX1 INP1' 'ZERO'
	tinymix 'RX1 Digital Volume' '84'
	tinymix 'DEC1 Volume' '84'
	tinymix 'SPK DAC Switch' '0'
	tinymix "QUAT_MI2S_RX Port Mixer TERT_MI2S_TX" 0
	tinymix 'MultiMedia1 Mixer TERT_MI2S_TX' 0
else 
	tinymix 'ADC1 Volume' '4'	
	tinymix 'DEC1 MUX' 'ZERO'
	tinymix 'RDAC2 MUX' 'ZERO'
	tinymix 'IIR1 INP1 MUX' 'ZERO'
	tinymix 'RX3 MIX1 INP1' 'ZERO'
	tinymix 'RX1 Digital Volume' '84'
	tinymix 'DEC1 Volume' '84'
	tinymix 'SPK DAC Switch' '0'
	tinymix 'Loopback MCLK' 'DISABLE'
	tinymix 'LOOPBACK Mode' 'DISABLE'
fi	
}

sub_mic_loop_test()
{
	echo 'sub-mic loop test'
	sleep 0.5
	tinymix 'LOOPBACK Mode' 'ENABLE'
	sleep 0.5
	tinymix 'DEC1 MUX' 'ADC3'
	tinymix 'ADC2 MUX' 'INP3'
	tinymix 'RDAC2 MUX' 'RX1'
	tinymix 'IIR1 INP1 MUX' 'DEC1'
	tinymix 'RX3 MIX1 INP1' 'IIR1'
	tinymix 'RX1 Digital Volume' '120'
	tinymix 'SPK DAC Switch' '1'
	tinymix 'Loopback MCLK' 'ENABLE'
}

stop_sub_mic_loop_test(){
	echo 'stop sub-mic loop test'
	tinymix 'DEC1 MUX' 'ZERO'
	tinymix 'ADC2 MUX' 'ZERO'
	tinymix 'RDAC2 MUX' 'ZERO'
	tinymix 'IIR1 INP1 MUX' 'ZERO'
	tinymix 'RX3 MIX1 INP1' 'ZERO'
	tinymix 'RX1 Digital Volume' '84'
	tinymix 'SPK DAC Switch' '0'
	tinymix 'Loopback MCLK' 'DISABLE'
	tinymix 'LOOPBACK Mode' 'DISABLE'
}


headset_mic_loop_test()
{
	echo 'headset_mic_loop_test'
	
	wait_kai_release_audio
	
	tinymix 'LOOPBACK Mode' 'ENABLE'
	sleep 0.5
	tinymix 'ADC2 MUX' 'INP2'
	tinymix 'DEC1 MUX' 'ADC2'
	tinymix 'IIR1 INP1 MUX' 'DEC1'
	tinymix 'RX1 MIX1 INP1' 'IIR1'
	tinymix 'RX2 MIX1 INP1' 'IIR1'
	tinymix 'RDAC2 MUX' 'RX2'
	tinymix 'HPHL' 'Switch'
	tinymix 'HPHR' 'Switch'
	tinymix "ADC2 Volume" 40
	tinymix "DEC1 Volume" 72
	tinymix 'RX1 Digital Volume' '78'
	tinymix 'RX2 Digital Volume' '78'
	tinymix 'Loopback MCLK' 'ENABLE'
}

stop_headset_mic_loop_test(){
	echo 'stop_headset_mic_loop_test'
	tinymix 'LOOPBACK Mode' 'DISABLE'
	tinymix 'ADC2 MUX' 'ZERO'
	tinymix 'DEC1 MUX' 'ZERO'
	tinymix 'IIR1 INP1 MUX' 'ZERO'
	tinymix 'RX1 MIX1 INP1' 'ZERO'
	tinymix 'RX2 MIX1 INP1' 'ZERO'
	tinymix 'RDAC2 MUX' 'ZERO'
	tinymix 'HPHL' 'ZERO'
	tinymix 'HPHR' 'ZERO'
	tinymix "ADC2 Volume" 4
	tinymix "DEC1 Volume" 84
	tinymix 'Loopback MCLK' 'DISABLE'
}

enable_headphone(){
	echo "manually enable headphone RX channel"
	tinymix 'SPK DAC Switch' '0'
	tinymix 'MI2S_RX Channels' 'Two'
	tinymix 'RX1 MIX1 INP1' 'RX2'
	tinymix 'RX2 MIX1 INP1' 'RX2'
	tinymix 'RX1 Digital Volume' '75'
	tinymix 'RX2 Digital Volume' '75'
	tinymix 'RDAC2 MUX' 'RX2'
	tinymix 'HPHL' 'Switch'
	tinymix 'HPHR' 'Switch'
}

disable_headphone(){
	echo "manually disable headphne RX channel"
        tinymix 'SPK DAC Switch' '1'
        tinymix 'MI2S_RX Channels' 'One'
        tinymix 'RX1 MIX1 INP1' 'ZERO'
        tinymix 'RX2 MIX1 INP1' 'ZERO'
        tinymix 'RX1 Digital Volume' '84'
        tinymix 'RX2 Digital Volume' '84'
        tinymix 'RDAC2 MUX' 'ZERO'
        tinymix 'HPHL' 'ZERO'
        tinymix 'HPHR' 'ZERO'

}

headset-left(){
	sleep 0.5
        echo $$ > /data/audio_test.pid
	tinymix "SPK DAC Switch" 0
	tinymix "MI2S_RX Channels"  Two
	tinymix "RX1 MIX1 INP1" RX1
	tinymix "RX2 MIX1 INP1" RX2
       tinymix 'RX1 Digital Volume' '70'
       tinymix 'RX2 Digital Volume' '70'
	tinymix "RDAC2 MUX" RX2
	tinymix "HPHL" Switch
	tinymix "HPHR" ZERO
	tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 1
	sleep 1
	while [ 1 ];do
		tinyplay /vendor/112.wav -d 0 &
		pid=$!
		echo $pid > /data/audio_play.pid
		wait
	done

}

headset-left-stop() {
		# kill audio_test.sh shell script
        if [ -f /data/audio_test.pid ];then
	   		pid=`cat /data/audio_test.pid`
	   		kill -9 $pid
	   	    rm /data/audio_test.pid
		fi
		# kill play application
		if [ -f /data/audio_play.pid ];then
	   		pid=`cat /data/audio_play.pid`
	   		echo kill -9 $pid
	   		kill -9 $pid
	   	    rm /data/audio_play.pid
		fi
		
	tinymix "MI2S_RX Channels" One 
	tinymix "RX1 MIX1 INP1" 0
	tinymix "RX2 MIX1 INP1" 0
	tinymix "RDAC2 MUX" 0
	tinymix "HPHL" 0
	tinymix "HPHR" 0
	tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 0
	tinymix "SPK DAC Switch" 1	
}

headset-right() {
	
	sleep 0.5
        echo $$ > /data/audio_test.pid
	tinymix "SPK DAC Switch" 0
	tinymix "MI2S_RX Channels"  Two
	tinymix "RX1 MIX1 INP1" RX1
	tinymix "RX2 MIX1 INP1" RX2
       tinymix 'RX1 Digital Volume' '70'
       tinymix 'RX2 Digital Volume' '70'
	tinymix "RDAC2 MUX" RX2
	tinymix "HPHL" 0
	tinymix "HPHR" Switch
	tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 1
	sleep 1
	while [ 1 ];do
		tinyplay /vendor/112.wav -d 0 &
		pid=$!
		echo $pid > /data/audio_play.pid
		wait
	done
}

headset-right-stop(){
        if [ -f /data/audio_test.pid ];then
	   pid=`cat /data/audio_test.pid`
	   kill -9 $pid
	   rm /data/audio_test.pid
	fi
	
	# kill play application
	if [ -f /data/audio_play.pid ];then
	   		pid=`cat /data/audio_play.pid`
	   		echo kill -9 $pid
	   		kill -9 $pid
	   	    rm /data/audio_play.pid
	fi
	tinymix "MI2S_RX Channels" One 
	tinymix "RX1 MIX1 INP1" 0
	tinymix "RX2 MIX1 INP1" 0
	tinymix "RDAC2 MUX" 0
	tinymix "HPHL" 0
	tinymix "HPHR" 0
	tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 0
	tinymix "SPK DAC Switch" 1		
}

play_to_receiver(){
	echo play_to_receiver >> /data/log.txt

        echo $$ > /data/audio_test.pid
  
	wait_kai_release_audio
  sleep 1    
	tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1' 1
	tinymix 'RX1 MIX1 INP1' 'RX1'
	tinymix 'RX1 Digital Volume' 70%
	tinymix 'RDAC2 MUX' 'RX1'
	tinymix 'EAR_S' 1  #'EAR_S Switch
	sleep 1
	echo play_to_receiver 1 >> /data/log.txt
	while [ 1 ];do
		echo play_to_receiver 3 >> /data/log.txt
		tinyplay /vendor/112.wav -d 0  &
		pid=$!
		echo $pid > /data/audio_play.pid
		wait
	done
}
stop_play_to_receiver(){
	 if [ -f /data/audio_test.pid ];then
	   pid=`cat /data/audio_test.pid`
	   kill -9 $pid
	   rm /data/audio_test.pid
	fi
	
	# kill play application
	if [ -f /data/audio_play.pid ];then
	   		pid=`cat /data/audio_play.pid`
	   		echo kill -9 $pid
	   		kill -9 $pid
	   	    rm /data/audio_play.pid
	fi
	
	tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1' 0
	tinymix 'RX1 MIX1 INP1' 'ZERO'
	tinymix 'RDAC2 MUX' 'ZERO'
	tinymix 'EAR_S' 0
}


play_to_speaker(){
        echo $$ > /data/audio_test.pid
 
  wait_kai_release_audio
    
 
if [ -d  /sys/bus/i2c/drivers/tfa98xx/2-0034 ] ;then
	tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1
else      
	tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1' 1
fi	
	tinymix 'RX3 MIX1 INP1' 'RX1'
	tinymix 'SPK DAC Switch' 1
	tinymix 'Speaker Boost' 'ENABLE'
	tinymix 'RX3 Digital Volume' '75'
	
	sleep 1
	while [ 1 ];do
		tinyplay /vendor/112.wav -d 0 &
		pid=$!
		echo $pid > /data/audio_play.pid
		wait
	done
}
stop_play_to_speaker(){
	 if [ -f /data/audio_test.pid ];then
	   pid=`cat /data/audio_test.pid`
	   kill -9 $pid
	   rm /data/audio_test.pid
	fi
	
	# kill play application
	if [ -f /data/audio_play.pid ];then
	   		pid=`cat /data/audio_play.pid`
	   		echo kill -9 $pid
	   		kill -9 $pid
	   	    rm /data/audio_play.pid
	fi

	 if [ -d  /sys/bus/i2c/drivers/tfa98xx/2-0034 ] ;then
		tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
	 else
	    tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1' 0
	 fi   
	tinymix 'RX3 MIX1 INP1' 'ZERO'
	tinymix 'SPK DAC Switch' 0

}

if [ $1 == 'mic' ];then
  stop_play_to_speaker # kai os not stop receiver complete, so we add stop receiver cmd here
	wait_kai_release_audio
  stop_main_mic_loop_test
	main_mic_loop_test
fi

if [ $1 == 'stop-mic' ];then
	stop_main_mic_loop_test
fi

if [ $1 == 'sub-mic' ];then
	#stop_sub_mic_loop_test
	#sub_mic_loop_test
	wait_kai_release_audio
    echo "play audio to receiver" >> /data/log.txt	
	play_to_receiver
	
fi
if [ $1 == 'stop-sub-mic' ];then

    echo "stop audio to receiver" >> /data/log.txt
    stop_play_to_receiver

fi

if [ $1 == 'headset-mic' ];then
	wait_kai_release_audio
	stop_headset_mic_loop_test
	headset_mic_loop_test	
	
fi

if [ $1 == 'stop-headset-mic' ];then
	stop_headset_mic_loop_test
fi

if [ $1 == 'enable-headphone' ];then
        #enable_headphone
  	    stop_play_to_receiver # kai os not stop receiver complete, so we add stop receiver cmd here
  	    wait_kai_release_audio
		echo "play audio to speaker" >> /data/log.txt	
		play_to_speaker
fi

if [ $1 == 'disable-headphone' ];then
        #disable_headphone
		echo "stop audio to speaker" >> /data/log.txt	
		stop_play_to_speaker
        
fi

if [ $1 == 'headset-left' ];then
	wait_kai_release_audio
	headset-left-stop
	headset-left
fi

if [ $1 == 'headset-left-stop' ];then
		headset-left-stop
fi

if [ $1 == 'headset-right' ];then
	wait_kai_release_audio
	headset-right-stop
	headset-right
fi

if [ $1 == 'headset-right-stop' ];then
   headset-right-stop
fi

echo $0 $1 end >> /data/log.txt

