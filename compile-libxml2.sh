#!/bin/bash -e

## module
MODULE=libxml2-2.7.7

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
./configure --prefix=$INSTALLDIR --with-iconv=$INSTALLDIR
make
make install

## copy licence file
cp -pv $EXTSRCDIR/$MODULE/COPYING $iLICENCEDIR/$MODULE.licence

## postprocess
## move the headers files up else tclxml fails to find these
mv $INSTALLDIR/include/libxml2/libxml $INSTALLDIR/include/
rmdir $INSTALLDIR/include/libxml2

## fini
echo "** Finished compile-$MODULE."
