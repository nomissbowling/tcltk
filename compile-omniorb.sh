#!/bin/bash -e

## module
MODULE=omniORB-4.1.4

## load defaults
. ./common.sh

## print
echo "** Compiling $MODULE"

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

## configure and make
./configure --prefix=$INSTALLDIR/$MODULE
make
make install

ln -s $INSTALLDIR/$MODULE $INSTALLDIR/omniORB

## fini
echo "** Finished compile-$MODULE."
