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

cp -rf *.sh chapter* packages.csv "$LFS/sources"
cd "$LFS/sources"
echo "Now we are at: $(pwd)"
export PATH="$LFS/tools/bin:$PATH"
echo $PATH

source download.sh

## all packages downloaded

# CHAPTER 5 
# source packageinstall.sh 5 binutils
# source packageinstall.sh 5 gcc
# source packageinstall.sh 5 linux
# source packageinstall.sh 5 glibc
# # source packageinstall.sh 5 libstdc++ 1 ## following pass 2 gcc replacing this call
# source packageinstall.sh 5.6 gcc

# CHAPTER 6
# first pass
source packageinstall.sh 6 m4
# for p in ncurses bash coreutils diffutils file findutils gawk grep gzip make patch sed tar xz; do
#     source packageinstall.sh 6 $p
# done
# # second or more passes
# for p in binutils gcc; do
#     source packageinstall.sh 6 $p
# done



