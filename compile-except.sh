#!/bin/bash -e

## module
MODULE=except

## load defaults
. ./common.sh "$@"

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
    rsync -a $INTSRCDIR/$MODULE $COMPILEDIR/
    echo done
fi

## get module version number
echo -n "Loading $MODULE package ... "
cd $COMPILEDIR/$MODULE
echo "set dir $COMPILEDIR/$MODULE" > ./info.tcl
echo "source pkgIndex.tcl" >> ./info.tcl
echo "puts [package re TclExcept]" >> ./info.tcl
VERSION=$($INSTALLDIR/bin/$TCLSH ./info.tcl)
rm ./info.tcl
echo done

## copy licence file
cp -pv $COMPILEDIR/$MODULE/license.txt $iLICENCEDIR/$MODULE.licence
## copy the change log
cp -pv $COMPILEDIR/$MODULE/changes.txt $iCHANGELOGDIR/$MODULE.changelog
## move doc
mkdir -p $SHAREDIR/doc/$MODULE
cp -pv $COMPILEDIR/$MODULE/doc/* $iSHAREDIR/doc/$MODULE/

## now copy to release
mkdir -p $INSTALLDIR/lib/$MODULE$VERSION
cp -pvr $COMPILEDIR/$MODULE/* $INSTALLDIR/lib/$MODULE$VERSION/

## fini
echo "** Finished compile-$MODULE."
