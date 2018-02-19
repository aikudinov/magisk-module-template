#!/system/bin/sh

MODDIR=${0%/*}

set -x

RESETPROP="resetprop -v -n"

if [ -f "/sbin/magisk" ]; then RESETPROP="/sbin/magisk $RESETPROP"
elif [ -f "/data/magisk/magisk" ]; then RESETPROP="/data/magisk/magisk $RESETPROP"
elif [ -f "/magisk/.core/bin/resetprop" ]; then RESETPROP=/magisk/.core/bin/$RESETPROP
elif [ -f "/data/magisk/resetprop" ]; then RESETPROP=/data/magisk/$RESETPROP; fi

FINGERPRINT=Xiaomi/sagit/sagit:7.1.1/NMF26X/V8.2.17.0.NCACNEC:user/release-keys
$RESETPROP "ro.build.fingerprint" "$FINGERPRINT"
$RESETPROP "ro.bootimage.build.fingerprint" "$FINGERPRINT"; }

# This is not needed on Xiaomi Mi6, but maybe it helps someone. 

VERIFYBOOT=$(getprop ro.boot.verifiedbootstate)
FLASHLOCKED=$(getprop ro.boot.flash.locked)
VERITYMODE=$(getprop ro.boot.veritymode)
KNOX1=$(getprop ro.boot.warranty_bit)
KNOX2=$(getprop ro.warranty_bit)
DEBUGGABLE=$(getprop ro.debuggable)
SECURE=$(getprop ro.secure)
BUILDTYPE=$(getprop ro.build.type)
BUILDTAGS=$(getprop ro.build.tags)
BUILDSELINUX=$(getprop ro.build.selinux)
RELOADPOLICY=$(getprop selinux.reload_policy)

[ "$VERIFYBOOT" ] && [ "$VERIFYBOOT" != "green" ] && $RESETPROP "ro.boot.verifiedbootstate" "green"
[ "$FLASHLOCKED" ] && [ "$FLASHLOCKED" != "1" ] && $RESETPROP "ro.boot.flash.locked" "1"
[ "$VERITYMODE" ] && [ "$VERITYMODE" != "enforcing" ] && $RESETPROP "ro.boot.veritymode" "enforcing"
[ "$KNOX1" ] && [ "$KNOX1" != "0" ] && $RESETPROP "ro.boot.warranty_bit" "0"
[ "$KNOX2" ] && [ "$KNOX2" != "0" ] && $RESETPROP "ro.warranty_bit" "0"
[ "$DEBUGGABLE" ] && [ "$DEBUGGABLE" != "0" ] && $RESETPROP "ro.debuggable" "0"
[ "$SECURE" ] && [ "$SECURE" != "1" ] && $RESETPROP "ro.secure" "1"
[ "$BUILDTYPE" ] && [ "$BUILDTYPE" != "user" ] && $RESETPROP "ro.build.type" "user"
[ "$BUILDTAGS" ] && [ "$BUILDTAGS" != "release-keys" ] && $RESETPROP "ro.build.tags" "release-keys"
[ "$BUILDSELINUX" ] && [ "$BUILDSELINUX" != "0" ] && $RESETPROP "ro.build.selinux" "0"
[ "$RELOADPOLICY" ] && [ "$RELOADPOLICY" != "1" ] && $RESETPROP "selinux.reload_policy" "1"

exit