#!/system/bin/sh
rm /data/nfc_test.log
rm /data/nfc_test1.log
touch /data/nfc_test.log
chmod 666 /data/nfc_test.log
pnscr_ac -t 1 -d nq-nci -f /system/xbin/Card_Mode.txt > /data/nfc_test1.log
result=`cat /data/nfc_test1.log|grep "Card_Mode PASSED"`
if [ "x$result" != "x" ]; then
	echo $result
	echo "NFC test Pass" >> /data/nfc_test.log
else
	echo "NFC test fail" >> /data/nfc_test.log
fi
echo "\nNFC test end" >> /data/nfc_test.log
chmod 666 /data/nfc_test1.log