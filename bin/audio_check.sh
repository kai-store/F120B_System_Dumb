	num=1
	 while :

		do
			res=`tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1'|grep Off`
			if [ "x$res" = "x" ] ; then
				echo "Some audio is playing $num" 
				let num++
				sleep 1
			else
			    echo "Some audio is playing stop" 
				sleep 1
			fi
	done
			