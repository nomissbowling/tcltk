#!/bin/bash -e

## module
if [ -z "$WINDIR" ]; then
    MODULE=tclxml
else
    MODULE=tclxml-combo-3.1
fi

## load defaults
. ./common.sh

## print
echo "** Compiling $MODULE"

## on linux compile, on windows simple copy
if [ -z "$WINDIR" ]
then
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
    cd $COMPILEDIR/$MODULE/trunk

    ## configure and make
    ./configure --with-tcl=$INSTALLDIR/lib --enable-threads 
    #--with-xml2-config=$INSTALLDIR/lib --with-xslt-config=$INSTALLDIR/lib --with-xml-static=0

    ## install
    make
    make install

    ## copy licence file
    cp -pv $EXTSRCDIR/$MODULE/LICENSE $iLICENCEDIR/$MODULE.licence
else
    echo .
    cp -pv $EXTSRCDIR/$MODULE/lib/* $INSTALLDIR/lib/
fi

## fini
echo "** Finished compile-tclxml."
