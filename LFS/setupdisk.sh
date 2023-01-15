
LFS_DISK="$1"

# Following fdisk commands
# o # create an empty DOS partition
# n # add a new partition
# p # primary partition type
# 1 # partition number 1, then select default first sector location

# +100M # sector size = 100M
# Y # confirm yes
# a # toggle bootable flag
# n # make second partition for rest of usb
# p
# 2


# p # print
# w # write
# q # quit

sudo fdisk "$LFS_DISK" << EOF
o
n
p
1

+100M
a
n
p
2


p
w
q
EOF

## Create ext 2 final systems on each partition
sudo mkfs -t ext2 -F "${LFS_DISK}1"
sudo mkfs -t ext2 -F "${LFS_DISK}2"


