mkdir -v build
cd build

../confiure --prefix=$LFS/tools \
            --with-sysroot=$LFS \
            --target=$LFS_TGT \ 
            --disable-nls \
            --enable-gprofng=no \
            --disable-werror

make
make install