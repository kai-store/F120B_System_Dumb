#!/system/bin/sh
# usage:
echo "save log to $1 storage"
PRODUCTNAME=`getprop ro.product.model`
PRODUCTVER=`getprop ro.bluebank.iver`
echo $PRODUCTVER
ZIP_FILE_NAME=LOG_${PRODUCTNAME}_${PRODUCTVER}_`getprop ro.build.type`_`date +%Y%m%d.%H%M%S`.zip
SAVEPATH=
SAVE_TO_SD=`getprop sys.save_log_sd`
if [ "${SAVE_TO_SD}" = "1" ] ;then 

	SAVEPATH=/sdcard/${PRODUCTNAME}_LOGS
	mkdir $SAVEPATH

else

	SAVEPATH=/storage/emulated/0/${PRODUCTNAME}_LOGS
	mkdir $SAVEPATH

fi
SAVE_LOG_FILE_PATH=${SAVEPATH}/${ZIP_FILE_NAME}
echo "save log path:${SAVE_LOG_FILE_PATH}"
zip -qry9 $SAVE_LOG_FILE_PATH /data/tombstones /data/logs /cache/recovery
setprop sys.save_log 0
exit
