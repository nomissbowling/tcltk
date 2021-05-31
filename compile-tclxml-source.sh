#!/bin/bash -e

## module
MODULE=tclxml

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
cd $COMPILEDIR/$MODULE/trunk
## on linux compile, on windows simple copy

## configure and make
LDFLAGS=-L$INSTALLDIR/lib
./configure --with-tcl=$INSTALLDIR/lib --enable-threads --with-xml2-config=$INSTALLDIR/lib/xml2Conf.sh --with-xslt-config=$INSTALLDIR/lib/xsltConf.sh
#--with-xml-static=0
make
make install

## copy licence file
cp -pv $EXTSRCDIR/$MODULE/LICENSE $iLICENCEDIR/$MODULE.licence

## fini
echo "** Finished compile-tclxml-source."
