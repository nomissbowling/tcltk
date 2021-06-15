#!/bin/bash -e

## module
MODULE=tkpath

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

## on linux compile, on windows simple copy
if [ -z "$WINDIR" ]; then
    ## delete whole compile sources and start from new
    if [ -n "$SW_CLEANUP" ]; then
        echo -n "Deleting old sources ... "
        rm -rf $COMPILEDIR/$MODULE
        echo done
    fi

    ## copy source to temp compile path
    if [ ! -d $COMPILEDIR/$MODULE ] || [ -n "$SW_FORCECOPY" ]; then
        echo -n "Copying new sources ... "
        rsync -a --exclude "*/CVS" $EXTSRCDIR/$MODULE $COMPILEDIR/
        echo done
    fi

    ## create a dummy file else the install script fails if dir is empty
    echo "dummy" >> $COMPILEDIR/$MODULE/doc/dummy.n
    ## change to compile dir
    cd $COMPILEDIR/$MODULE

    ## configure and make
    (CFLAGS="$CFLAGS" ./configure --prefix=$INSTALLDIR --with-tclinclude=$INSTALLDIR/include $CONFIGURE_SWITCH)
    make
    make install

    ## copy licence file
    echo -n "Copying extras ... "
    rsync -a $EXTSRCDIR/$MODULE/README.txt $iLICENCEDIR/$MODULE.licence
    echo done
else
    echo -n "Installing ... "
    rsync -a $INTSRCDIR/$MODULE $INSTALLDIR/lib/
    echo done
fi

## fini
echo "** Finished compile-$MODULE."
