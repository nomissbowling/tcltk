#!/bin/bash -e

## module
MODULE=pgtclng

## load defaults
. ./common.sh

## check debug switch
if [ -n "$SW_DEBUG" ]; then
    CONFIGURE_SWITCH+="--enable-symbols "
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
    echo done
fi

## change to compile dir
if [ -z "$WINDIR" ]; then
    ## linux version
    cd $COMPILEDIR/$MODULE/src
    ## configure and make
    autoconf
    #cp $COMPILEDIR/tcl/generic/tcl.h $COMPILEDIR/$MODULE/src/
    #cp $COMPILEDIR/tcl/generic/tclDecls.h $COMPILEDIR/$MODULE/src/
    ./configure --prefix=$INSTALLDIR $CONFIGURE_SWITCH
    make
    make install
else
    ## windows version
    if [ "$BARCH" == "x86_64" ]; then
        cd $COMPILEDIR/$MODULE/src
        if [ -n "$SW_DEBUG" ]; then
            rsync -a $PATCHDIR/${MODULE}/x64/mingw.debug.mak .
            sed -i "s|%installdir%|$INSTALLDIR|g" mingw.debug.mak
            sed -i "s|%tcllib%|tclstub85g|g" mingw.debug.mak
            sed -i "s|%pgdir%|$PGDIR|g" mingw.debug.mak
            make -f mingw.debug.mak
        else
            rsync -a $PATCHDIR/${MODULE}/x64/mingw.release.mak .
            sed -i "s|%installdir%|$INSTALLDIR|g" mingw.release.mak
            sed -i "s|%tcllib%|tclstub85|g" mingw.release.mak
            sed -i "s|%pgdir%|$PGDIR|g" mingw.release.mak
            make -f mingw.release.mak
        fi
    else
        ## copy pgtclng dll
        cd $PATCHDIR/${MODULE}/x32
        rsync -a libpgtcl.dll $COMPILEDIR/$MODULE/src
    fi
    ## copy important postgres libraries
    rsync -a $PATCHDIR/${MODULE}/x32/*.dll $iSHARELIB32DIR
    rsync -a $PATCHDIR/${MODULE}/x64/*.dll $iSHARELIB64DIR
        
    ## check version number
    echo -n "Loading $MODULE package ... "
    cd $COMPILEDIR/$MODULE/src
    echo "load [file join [pwd] libpgtcl.dll]" > ./info.tcl
    echo "puts [package re Pgtcl]" >> ./info.tcl
    if [ "$BARCH" == "x86_64" ]; then
        VERSION=$(env "PATH=$iSHARELIB64DIR:$PATH" $INSTALLDIR/bin/$TCLSH ./info.tcl)
    else
        VERSION=$(env "PATH=$iSHARELIB32DIR:$PATH" $INSTALLDIR/bin/$TCLSH ./info.tcl)
    fi
    rm ./info.tcl
    echo done
    
    ## copy package files
    echo -n "Installing ... "
    mkdir -p $INSTALLDIR/lib/$MODULE$VERSION
    rsync -a $COMPILEDIR/$MODULE/src/libpgtcl.dll $INSTALLDIR/lib/$MODULE$VERSION/
    rsync -a $COMPILEDIR/$MODULE/win/pkgIndex.tcl $INSTALLDIR/lib/$MODULE$VERSION/pkgIndex.tcl
    echo done
fi

echo -n "Copying extras ... "
## copy licence files
rsync -a $COMPILEDIR/$MODULE/src/COPYRIGHT $iLICENCEDIR/$MODULE.licence
rsync -a $PATCHDIR/postgresql/postgresql.licence $iLICENCEDIR/
echo done

## fini
echo "** Finished compile-pgtcl."
