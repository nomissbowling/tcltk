#!/bin/bash -e

## package dependencies:  uuid-dev

## usage:   package require zmq

## module
MODULE=tclzmq

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
echo installing into  $INSTALLDIR using $INSTALLDIR/bin/tclsh ...

$INSTALLDIR/bin/tclsh build.tcl install -zmq $INSTALLDIR

## copy licence file
cp -pv $EXTSRCDIR/$MODULE/COPYING.LESSER  $iLICENCEDIR/$MODULE.LESSER.licence
cp -pv $EXTSRCDIR/$MODULE/COPYING.BSD  $iLICENCEDIR/$MODULE.BSD.licence

## fini
echo "** Finished compile-$MODULE."
