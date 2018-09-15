#!/system/bin/sh
cache_recovery="/cache/recovery"
recovery_command="/cache/recovery/command"
if [ ! -e $cache_recovery ]; then
   mkdir $cache_recovery
fi
if [ ! -e $recovery_command ]; then
   touch $recovery_command
fi
echo "--wipe_data" > $recovery_command
reboot recovery