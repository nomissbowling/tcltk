#!/bin/bash -e

## module
MODULE=postgres

## load defaults
. ./common.sh

## check debug switch
if [ -n "$SW_DEBUG" ]; then
    CONFIGURE_DEBUG="--enable-symbols"
fi

## check platform
if [ -z "$WINDIR" ]; then
    ## linux version
    echo "This compile script is for windows only." >&2; exit 1
fi

## print
echo "** Compiling $MODULE $CONFIGURE_DEBUG"

## delete whole compile sources and start from new
if [ -n "$SW_CLEANUP" ]; then
    echo -n "Deleting old sources ... "
    rm -rf $COMPILEDIR/$MODULE
    echo done
fi
## copy source to temp compile path
if [ ! -d $COMPILEDIR/$MODULE ] || [ -n "$SW_FORCECOPY" ]; then
    echo -n "Copying new sources ... "
    rsync -a $EXTSRCDIR/$MODULE $COMPILEDIR/
    echo done
fi

## change to compile dir
cd $COMPILEDIR/$MODULE
./configure --with-openssl --without-zlib --enable-thread-safety --with-libs="$OSSLDIR" --with-include="$OSSLDIR/include" $CONFIGURE_DEBUG
make

## copy licence file
cp -pv $COMPILEDIR/$MODULE/COPYRIGHT $iLICENCEDIR/$MODULE.licence

## fini
echo "** Finished compile-$MODULE."
