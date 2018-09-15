#!/system/bin/sh

if [ ! -f /data/camera_test.pid ] ;then
	echo "camera_test not exist"
	exit 0
	
fi

echo send event to camera process
rm /data/camera_test.pid 
while true
do
	if [ -f /data/camera_test.pid ]; then
		break;
	fi
	sleep 1
done
echo Stop finish
rm /data/camera_test.pid 