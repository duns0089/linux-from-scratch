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
mkdir -pv $LFS/tools # intemmediate cross-compiler from A -> b

# fsh linux folders - chapter 4.4
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

cp -rf *.sh packages.csv "$LFS/sources"
cd "$LFS/sources"
echo "Now we are at: $(pwd)"
export PATH="$LFS/tools/bin:$PATH"

source download.sh