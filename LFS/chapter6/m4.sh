./configure --prefix=/usr \
    --host=$LFS_TGT \
    --build=$(build-aux/config.guess)

make

make DESKDIR=$LFS install
