export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/dev/sdb

if ! grep -q "$LFS" /proc/mounts; then
    # source ./setupdisk.sh "$LFS_DISK"
    # sudo mkdir $LFS # make mount destination
    sudo mount "${LFS_DISK}2" "$LFS" # mount usb part 2 to $LFS
    sudo chown -v $USER "$LFS" # set owner before making folders
fi

mkdir -pv $LFS/sources # for lfs build system
mkdir -pv $LFS/tools # intermmediate cross-compiler from A -> b

# CHAPTER 4.4 - fsh linux folders 
mkdir -pv $LFS/boot
mkdir -pv $LFS/etc
mkdir -pv $LFS/bin
mkdir -pv $LFS/lib
mkdir -pv $LFS/sbin
mkdir -pv $LFS/usr
mkdir -pv $LFS/var
case $(uname -m) in
    x86_64) mkdir -pv $LFS/lib64 ;;
esac

# usb stick is now formated, mount and directories created

cp -rf *.sh chapter* packages.csv "$LFS/sources"
cd "$LFS/sources"
echo "Now we are at: $(pwd)"
export PATH="$LFS/tools/bin:$PATH"
echo "PATH: $PATH"

# CHAPTER 3
source download.sh # won't redownload

# # CHAPTER 5 
# source packageinstall.sh 5 binutils
# source packageinstall.sh 5 gcc
# source packageinstall.sh 5 linux
# source packageinstall.sh 5 glibc
# source packageinstall.sh 5.6 gcc # source packageinstall.sh 5 libstdc++ 1 ## following pass 2 gcc replacing this call

# # CHAPTER 6
# for p in m4 ncurses bash coreutils diffutils file findutils gawk grep gzip make patch sed tar xz binutils gcc; do
#     source packageinstall.sh 6 $p
# done

# CHAPTER 7
chmod ugo+x preparechroot.sh
chmod ugo+x insidechroot.sh
sudo ./preparechroot.sh "$LFS"
echo "Entering CHROOT ENVIRONMENT..."
sleep 3


sudo chroot "$LFS" /usr/bin/env -i             \
    HOME=/root                              \
    TERN="$TERM"                            \
    PS1='(lfs chroot) \u:\w\$ '             \
    PATH="/bin:/usr/bin:/sbin:/usr/sbin"    \
    /bin/bash --login +h -c "/source/insidechroot.sh"









