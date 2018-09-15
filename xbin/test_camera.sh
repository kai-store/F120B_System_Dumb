#!/system/bin/sh

echo $$ > /data/camera_test.pid

cp /system/etc/back.yuv /data/front.yuv
cp /system/etc/back.yuv /data/back.yuv

camera_back $1&

camera_pid=$!

(
  if [ $1 = 0 ] ; then
  echo "2"; 
  else
  echo "3"; 
  fi
  while :
  do
  	if [ ! -f /data/camera_test.pid ] ; then
  		break
  	fi
  	sleep 1
  done
  
  echo "z"
  
  )|mm-qcamera-app > /dev/null

echo kill camera_back process pid is $camera_pid
kill $camera_pid

#notify stop script, already exit
echo $$ > /data/camera_test.pid