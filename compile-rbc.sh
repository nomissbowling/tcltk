#!/bin/bash -e

## module
MODULE=rbctoolkit

## load defaults
. ./common.sh

## check debug switch
if [ -n "$SW_DEBUG" ]; then
    CONFIGURE_SWITCH+="--enable-symbols"
fi
## check symbol switch
if [ -n "$SW_SYMBOLS" ]; then
    CFLAGS="-g"
fi
## check 64bit platform
if [ "$BARCH" == "x86_64" ]; then
    CONFIGURE_SWITCH+="--enable-64bit "
fi

## print
echo "** Compiling $MODULE $CONFIGURE_SWITCH"

## delete whole compile sources and start from new
if [ -n "$SW_CLEANUP" ]; then
    echo -n "Deleting old sources ... "
    rm -rf $COMPILEDIR/$MODULE
    echo done
fi
## copy source to temp compile path
if [ ! -d $COMPILEDIR/$MODULE ] || [ -n "$SW_FORCECOPY" ]; then
    echo -n "Copying new sources ... "
    rsync -a --exclude "*/.svn" $EXTSRCDIR/$MODULE $COMPILEDIR/
    ## copy some missing files to header search path
    cp -pv $TCLDIR/generic/tclInt.h $TCLDIR/generic/tclIntDecls.h $TCLDIR/generic/tclIntPlatDecls.h $TCLDIR/generic/tclPort.h $TCLDIR/win/tclWinPort.h $TCLDIR/unix/tclUnixPort.h $INSTALLDIR/include
    cp -p $TCLDIR/unix/tclUnixPort.h $TCLDIR/generic
    cp -p $TCLDIR/win/tclWinPort.h $TCLDIR/generic
    cp -p $TKDIR/win/tkWinPort.h $COMPILEDIR/tk/generic
    cp -p $TKDIR/win/tkWinInt.h $COMPILEDIR/$MODULE/rbc/generic
    cp -p $TKDIR/win/tkWin.h $COMPILEDIR/$MODULE/rbc/generic
    rsync -a $PATCHDIR/$MODULE/*.c $COMPILEDIR/$MODULE/rbc/generic
    rsync -a $PATCHDIR/$MODULE/configure $COMPILEDIR/$MODULE/rbc
    echo done
fi

## change to compile dir
cd $COMPILEDIR/$MODULE/rbc

## configure and make
(CFLAGS="$CFLAGS" ./configure --prefix=$INSTALLDIR $CONFIGURE_SWITCH)
## --with-tcl=$INSTALLDIR/lib --with-tk=$INSTALLDIR/lib 
make
make install

echo -n "Copying extras ... "
## copy licence file
cp -pv $COMPILEDIR/$MODULE/rbc/license.terms $iLICENCEDIR/$MODULE.licence
echo done

## fini
echo "** Finished compile-$MODULE."
