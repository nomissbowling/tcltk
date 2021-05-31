#!/bin/bash -e

## module
MODULE=zeromq
### 4.x.x version needed for tclzmq 
VERSION=4.0.4
BDIR=zeromq-${VERSION}
BFILE=zeromq-${VERSION}.tar.gz

## load defaults
. ./common.sh

## check debug switch
#if [ -n "$SW_DEBUG" ]; then
#    CONFIGURE_DEBUG="--enable-symbols"
#fi

## print
echo "** Compiling $MODULE  in ${BASEDIR=.}"

## delete whole compile sources and start from new
if [ -n "$SW_CLEANUP" ]; then
    echo -n "Deleting old sources ... "
    rm -rf $COMPILEDIR/$BDIR $COMPILEDIR/$MODULE
    echo done
fi
## copy source to temp compile path
if [ ! -d $COMPILEDIR/$MODULE ] || [ -n "$SW_FORCECOPY" ]; then
    echo -n "Copying new sources ... "
    if [ -z "$WINDIR" ]; then
        tar -xzf $BASEDIR/backup/$BFILE -C $COMPILEDIR/
    else
        ## mingw throws a checksum error because it's still using 16 bit git_t - forward output to null
        tar -xzf $BASEDIR/backup/$BFILE -C $COMPILEDIR/ 2> /dev/null || true
    fi
    ## create link without version number
    cd $COMPILEDIR
    mv $BDIR $MODULE
    echo done
fi


## change to compile dir
cd $COMPILEDIR/${MODULE}
## prepare for compilation (default: --prefix=/usr/local)
./configure --prefix=$INSTALLDIR
## compile
make
## install 
make install

## copy licence file
cp -pv $COMPILEDIR/$MODULE/COPYING.LESSER $iLICENCEDIR/$MODULE.licence

## fini
echo "** Finished compile-$MODULE."
