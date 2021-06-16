#!/bin/bash -e

## module
MODULE=fftw

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
    rsync -a $INTSRCDIR/$MODULE $COMPILEDIR/
    echo done
fi

## change to compile dir
cd $COMPILEDIR/$MODULE

## export INSTALLDIR and MODULE for the Linux/Windows make files
export INSTALLDIR

if [ -z "$WINDIR" ]; then
    ## linux
    make -f Makefile.linux
    ## copy licence file
    if [ -e /usr/share/doc/libfftw3-dev/copyright ]; then
        rsync -a /usr/share/doc/libfftw3-dev/copyright $iLICENCEDIR/libfftw.licence
    elif [ -e /usr/share/doc/packages/fftw3-devel/COPYRIGHT ]; then
        rsync -a /usr/share/doc/packages/fftw3-devel/COPYRIGHT $iLICENCEDIR/libfftw.licence
    fi
else
    ## windows
    mkdir -p $COMPILEDIR/$MODULE/libfftw
    cp $PATCHDIR/fftw/fftw3.h $COMPILEDIR/$MODULE/libfftw/
    cp $PATCHDIR/fftw/x64/libfftw3-3.dll $COMPILEDIR/$MODULE/libfftw/
    rsync -a $PATCHDIR/fftw/x64/*.dll $iSHARELIB64DIR
    make -f Makefile.win32
fi

## get version number of module
echo -n "Loading $MODULE package ... "
cd $COMPILEDIR/$MODULE
echo "set libPath [file join [file dirname [file dirname [info nameofexecutable]]] share lib64]" > ./info.tcl
echo "append env(PATH) \";[file nativename \$libPath]\"" >> ./info.tcl
echo "load [file join [pwd] tclfftw$LIBEXT] fftw" >> ./info.tcl
echo "puts [package re fftw]" >> ./info.tcl
echo "exit" >> ./info.tcl
VERSION=$($INSTALLDIR/bin/$TCLSH ./info.tcl)
rm ./info.tcl
echo done

## install module
echo -n "Installing ... "
mkdir -p $INSTALLDIR/lib/fftw$VERSION
cd $INSTALLDIR/lib/fftw$VERSION
echo "package ifneeded fftw $VERSION [list load [file join \$dir tclfftw$LIBEXT] fftw]" > pkgIndex.tcl
rsync -a $COMPILEDIR/$MODULE/tclfftw$LIBEXT ./
echo done

## run small test script
cd $COMPILEDIR/$MODULE
$INSTALLDIR/bin/$TCLSH fftw-test.tcl

## copy licence file
echo -n "Copying extras ... "
rsync -a $COMPILEDIR/$MODULE/COPYRIGHT $iLICENCEDIR/$MODULE.licence
rsync -a $PATCHDIR/fftw/*.licence $iLICENCEDIR

## GNU GPL copy source files
mkdir -p $iSHAREDIR/source
tar -czf $iSHAREDIR/source/$MODULE.tgz -C $INTSRCDIR/ $MODULE
echo done

## fini
echo "** Finished compile-$MODULE."
