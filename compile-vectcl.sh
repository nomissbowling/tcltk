#!/bin/bash -e

## module
MODULE=vectcl

## load defaults
. ./common.sh

## check debug switch
if [ -n "$SW_DEBUG" ]; then
    CONFIGURE_SWITCH+="--enable-symbols "
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
if [ ! -d $COMPILEDIR/$MODULE ] || [ -n "$SW_FORCECOPY" ] ; then
    echo -n "Copying new sources ... "
    rsync -a --exclude "*/.git" $EXTSRCDIR/$MODULE $COMPILEDIR/
    echo done
fi

## change to compile dir
cd $COMPILEDIR/$MODULE

## configure and make
(CFLAGS="$CFLAGS" ./configure --prefix=$INSTALLDIR --enable-threads --mandir=$iSHAREDIR $CONFIGURE_SWITCH)
## --with-tcl=$INSTALLDIR/lib --disable-xft
make
make install

echo -n "Copying extras ... "
## postprocess
cd $INSTALLDIR/bin
if [ -z "$WINDIR" ]; then
    mv wish8.5 wish85
    rsync -a wish85 wish
else
    if [ -n "$SW_DEBUG" ]; then
        mv wish85g.exe wish85.exe
        rsync -a wish85.exe wish.exe
    else
        rsync -a wish85.exe wish.exe
    fi
fi
  
## copy licence file
rsync -a $EXTSRCDIR/$MODULE/license.terms $iLICENCEDIR/$MODULE.licence
rsync -a $EXTSRCDIR/$MODULE/COPYRIGHT.f2c $iLICENCEDIR/f2c.licence
rsync -a $EXTSRCDIR/$MODULE/COPYRIGHT.hsfft $iLICENCEDIR/hsfft.licence
rsync -a $EXTSRCDIR/$MODULE/COPYRIGHT.lapack $iLICENCEDIR/lapack.licence
echo done

## fini
echo "** Finished compile-$MODULE."
