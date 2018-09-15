#!/system/bin/sh

insmod /system/lib/modules/wlan.ko
cp /system/etc/wifi/wpa_supplicant.conf /data/wifi_wpa_supplicant.conf
chmod 666 /data/wifi_wpa_supplicant.conf

# kill wpa_supplicant
pid=`ps|grep wpa_supplicant|grep -v grep |busybox awk '{print $2}'`

if [ "x$pid" != "x" ]; then
	echo kill $pid
fi

rm /data/wifi.log

wpa_supplicant -iwlan0 -Dnl80211 -c/data/wifi_wpa_supplicant.conf -O/data/misc/wifi/sockets -ddd &

sleep 1

touch /data/wifi.log
chmod 666 /data/wifi.log
(
echo scan
sleep 2
echo scan_result
echo quit

)|wpa_cli -i wlan0 -p /data/misc/wifi/sockets|busybox tee /data/wifi.log
echo "\nWIFI test end" >> /data/wifi.log
rm /data/wifi_wpa_supplicant.conf
rm /data/misc/wifi/sockets