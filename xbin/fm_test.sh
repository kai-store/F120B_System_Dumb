#!/system/bin/sh
(
echo enable
sleep 2
echo 'setfreq 103900'
sleep 3
echo quit
)|fmconfig|busybox tee /data/fm.log

result=`cat /data/fm.log|grep "tuned freq: 103900"`
if [ "x$result" != "x" ]; then
	echo $result
	echo "FM test: Pass"
else
	echo "FM test fail"
fi
rm /data/fm.log