CHAPTER="$1"
PACKAGE="$2"

echo "Preparing to install $PACKAGE for Chapter $CHAPTER..."

cat $PACKAGES | grep -i "^$PACKAGE;" | grep -v -i "\.patch;" | while read line; do
    
    # NAME="`echo $line | cut -d\; -f1`"
    VERSION="`echo $line | cut -d\; -f2`"
    URL="`echo $line | cut -d\; -f3 | sed "s/@/$VERSION/g"`"
    # MD5SUM="`echo $line | cut -d\; -f4`"
    CACHEFILE="$(basename "$URL")"
    DIRNAME="$(echo $CACHEFILE | sed 's/\(.*\)\.tar\..*/\1/')"

    if [ -d "$DIRNAME" ]; then
        echo "Removing old $DIRNAME..."
        rm -rvf "$DIRNAME"
    fi
    
    mkdir -pv "$DIRNAME"

    echo "Extracting $CACHEFILE..."
    tar -xvf "$CACHEFILE" -C "$DIRNAME"

    pushd "$DIRNAME"

        if [ "$(ls -1A | wc -l)" == "1" ]; then
            mv $(ls -1A)/* ./
        fi

        echo "Compiling $PACKAGE..."
        sleep 5

        mkdir -pv "../log/chapter$CHAPTER/"

        if ! source "../chapter$CHAPTER/$PACKAGE.sh" 2>&1 | tee "../log/chapter$CHAPTER/$PACKAGE.log" ; then
            echo "Compiling $PACKAGE failed!"
            popd
            exit 1
        fi

        echo "Done compiling $PACKAGE!"

    popd

done
