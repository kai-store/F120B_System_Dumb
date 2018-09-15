
IS_DDR3=F
IS_FERRITE=F
IS_DISCRETE=F
IS_SMART_PA=F
IS_SMART_PA_CAPACITE=F

#check if is lpddr3
if [ "x`getprop ro.boot.ldrt`" == "x1" ] ; then
	IS_DDR3=T
fi

#check if is ferrite
if [ "x`getprop ro.boot.ferrite`" == "x1" ] ; then
	IS_FERRITE=T
fi

#check if is discrete ddr and emmc
if [ "x`getprop ro.boot.discrete`" == "x1" ] ; then
	IS_DISCRETE=T
fi

# check if is smart pa
if [ -d  /sys/bus/i2c/drivers/tfa98xx/2-0034  ] ; then
	IS_SMART_PA=T
fi

# check if smart PA with capacitor
if [ "x`getprop ro.boot.tfa`" == "x1" ] ; then
	IS_SMART_PA_CAPACITE=T
fi


#Discrete DDR2/Ferrite/Audio PA with capacitor			 V7
if [ "$IS_DISCRETE" == "T" -a "$IS_DDR3" == "F" -a "$IS_FERRITE" == "T"   -a  "$IS_SMART_PA" == "T"  -a "$IS_SMART_PA_CAPACITE" == "T" ] ; then
	setprop ro.product.model.name "Mars01_V7"
	exit 0
fi

#Discrete DDR3/Ferrite/Audio PA with capacitor			 V6
if [ "$IS_DISCRETE" == "T" -a "$IS_DDR3" == "T" -a "$IS_FERRITE" == "T"   -a  "$IS_SMART_PA" == "T"  -a "$IS_SMART_PA_CAPACITE" == "T" ] ; then
	setprop ro.product.model.name "Mars01_V6"
	exit 0
fi


#DDR3/Ferrite/Audio PA with capacitor			 V5
if [ "$IS_DDR3" == "T" -a "$IS_FERRITE" == "T"   -a  "$IS_SMART_PA" == "T"  -a "$IS_SMART_PA_CAPACITE" == "T" ] ; then
	setprop ro.product.model.name "Mars01_V5"
	exit 0
fi

#DDR3/Ferrite/Audio PA			 V4
if [ "$IS_DDR3" == "T" -a "$IS_FERRITE" == "T"   -a  "$IS_SMART_PA" == "T"  ] ; then
	setprop ro.product.model.name "Mars01_V4"
	exit 0
fi


#DDR3/Ferrite/Non Audio PA			 V3
if [ "$IS_DDR3" == "T"  -a "$IS_FERRITE" == "T"  -a   "$IS_SMART_PA" == "F"  ] ; then
	setprop ro.product.model.name "Mars01_V3"
	exit 0
fi
#DDR3/Non Ferrite/Non Audio PA	 V2
if [ "$IS_DDR3" == "T"  -a "$IS_FERRITE" == "F" -a  "$IS_SMART_PA" == "F"  ] ; then
	setprop ro.product.model.name "Mars01_V2"
	exit 0
fi


#DDR2/Non Ferrite/Non Audio PA Mars01 V1
if [ "$IS_DDR3" == "F"  -a "$IS_FERRITE" == "F"  -a "$IS_SMART_PA" == "F" ] ; then
	setprop ro.product.model.name "Mars01_V1"
	exit 0
fi



setprop ro.product.model.name "Mars01_${IS_DISCRETE}${IS_DDR3}${IS_FERRITE}${IS_SMART_PA}${IS_SMART_PA_CAPACITE}"
