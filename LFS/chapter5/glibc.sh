case $(uname -m) in
    i?86) ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

patch -Np1 -i ../glibc-2.36-fhs-1.patch

mkdir -v build
cd build

echo "rootsbindir=/usr/sbin" > configparms

../configure                            \
    --prefix=/usr                       \
    --host=$LFS_TGT                     \
    --build=$(../scripts/config.guess)  \
    --enable-kernel=3.2                 \
    --with-headers=$LFS/usr/include     \
    libc_cv_slibdir=/usr/lib


# ignore the following
# configure: WARNING:
# *** These auxiliary programs are missing or
# *** incompatible versions: msgfmt
# *** some features will be disabled.
# *** Check the INSTALL file for required versions.

make

make DESTDIR=$LFS install

$LFS/tools/libexec/gcc/$LFS_TGT/12.2.0/install-tools/mkheaders

