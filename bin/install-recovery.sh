#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:8404992:73a92e76aeb7508935128ced4f9649999e1d85ff; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:7901184:678507b76b01cf876a46259b260c93efb4487d7c EMMC:/dev/block/bootdevice/by-name/recovery 73a92e76aeb7508935128ced4f9649999e1d85ff 8404992 678507b76b01cf876a46259b260c93efb4487d7c:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
