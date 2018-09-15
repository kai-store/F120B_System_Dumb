#!/system/bin/sh

rm /data/gps.log
rm /data/gps1.log
touch /data/gps.log
chmod 666 /data/gps.log
gps_test_cit  > /data/gps1.log
result=`cat /data/gps1.log|grep "GPS VERIFY TEST SUCCESSFUL"`
if [ "x$result" != "x" ]; then
	echo $result
	echo "GPS test Pass" >> /data/gps.log
else
	echo "GPS test fail" >> /data/gps.log
fi
echo "GPS test end" >> /data/gps.log
chmod 666 /data/gps1.log