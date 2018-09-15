#!/system/bin/sh

camera_pid=$!
(
  if [ $1 = 0 ] ; then
  echo "4"; 
  else
  echo "5"; 
  fi
)|mm-qcamera-app > /dev/null
/system/bin/save_pic $1
echo kill_self
