# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Overdose R3 - Reborn From Grave
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# Backup init.rc
backup_file init.rc;

# init.d patch
append_file init.rc "init.d support" init_patch;
append_file default.prop "sys.init.d.loop=on" init_prop_patch;
mkdir /system/etc/init.d
chmod -R 755 /system/etc/init.d
cp /tmp/anykernel/tools/busybox /system/xbin
chmod 755 /system/xbin/busybox

# Overdose Configuration
remove_line init.rc "import /init.graphene.rc"
remove_line init.rc "import /init.overdose.rc"
insert_line init.rc "import /init.overdose.rc" after "import /init.usb.configfs.rc" "import /init.overdose.rc";

# spectrum support
remove_line init.rc "import /init.spectrum.rc"
insert_line init.rc "import /init.spectrum.rc" after "import /init.overdose.rc" "import /init.spectrum.rc";


# end ramdisk changes

write_boot;
## end install

