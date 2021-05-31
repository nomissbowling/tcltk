#!/bin/bash -e

## module
MODULE=libxslt-1.1.26

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

## configure and build png
./configure --prefix=$INSTALLDIR --with-libxml-prefix=$INSTALLDIR
make
make install

## copy licence file
cp -pv $EXTSRCDIR/$MODULE/COPYING $iLICENCEDIR/$MODULE.licence

## fini
echo "** Finished compile-$MODULE."
