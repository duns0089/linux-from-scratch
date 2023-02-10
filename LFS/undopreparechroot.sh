#!/bin/bash

export LFS="$1"

if [ "$LFS" == "" ]; then
    exit 1
fi

# changing ownership
chown -R johndunstan:johndunstan $LFS/tools
chown -R johndunstan:johndunstan $LFS/boot
chown -R johndunstan:johndunstan $LFS/etc
chown -R johndunstan:johndunstan $LFS/bin
chown -R johndunstan:johndunstan $LFS/lib
chown -R johndunstan:johndunstan $LFS/sbin
chown -R johndunstan:johndunstan $LFS/usr
chown -R johndunstan:johndunstan $LFS/var

case $(uname -m) in
    x86_64) chown -R johndunstan:johndunstan $LFS/lib64 ;;
esac

rm -r $LFS/{dev,proc,sys,run}

# # preparing virtual kernel file systems
# mkdir -pv $LFS/{dev,proc,sys,run}

# mknod -m 600 $LFS/dev/console c 5 1 
# mknod -m 666 $LFS/dev/null c 1 3 

# # mounting and popularing /dev
# mount -v --bind /dev $LFS/dev

# # mounting virtual kernel file systems
# mount -v --bind /dev/pts $LFS/dev/pts
# mount -vt proc proc $LFS/proc
# mount -vt sysfs sysfs $LFS/sys
# mount -vt tmpfs tmpfs $LFS/run

# if [ -h $LFS/dev/shm ]; then
#  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
# fi





