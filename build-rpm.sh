#!/bin/bash -e
## exit on non-zero status
set -e

## info
VERSION=1.4
MANUFACT="(c) 2018 ATOS"
AUTHORS="Thomas Perschak"

## helper functions
##
function printHelp {
    echo "RPM package compile script."
    echo "$MANUFACT, $AUTHORS"
    echo "Script version: $VERSION"
    echo ""
    echo "Syntax:"
    echo " build-rpm.sh [<options>]"
    echo "Options:"
    echo " -title <name>: Additional title to be added to the filename."
    echo " -skey <key>: Key to sign the package."
    echo " -changelog: Update changelog file."
    echo " -h(elp): Print this help text."
}
##
## helper functions

## switch into script directory
SCRIPTDIR=$(cd $(dirname $0); pwd)
cd $SCRIPTDIR

## forward options
FOPTIONS=""

## allow to switch between release and debug compilation
BINFOLDER=release

## read command line parameters
INDEX=1
while [ $INDEX -le $# ]; do
    case ${!INDEX} in
        "-title")
            let INDEX+=1
            TITLE=${!INDEX}
            ;;
        "-debug")
            DEBUG=1
            BINFOLDER=debug
            ;;
        "-skey")
            let INDEX+=1
            FOPTIONS="$FOPTIONS -skey ${!INDEX}"
            ;;
        "-changelog")
            ACTIONCHANGELOG=1
            ;;
        "-h"*)
            printHelp
            exit 1
            ;;
        *)
            echo "Unknown parameter '${!INDEX}', type -help for more information." >&2; exit 1
            ;;
    esac
    let INDEX+=1
done

## check if gse4-service directory exists
if [ ! -d ../gse4-service ]; then
    echo "Missing ../gse4-service" >&2
    echo "Clone /cmdata/git/products/gse4-service.git into ../gse4-service to get the build environment." >&2
    exit 1
fi

## update the changelog file
if [ -n "$ACTIONCHANGELOG" ]; then
    echo "Updating changelog file ..."
    ../gse4-service/scripts/git-change.sh -dir .
fi

## create a new rpmspec from template
echo -n "Collecting build information ... "

## get TCL version = version + patch + release
echo "package re GSE; puts \${tcl_patchLevel}" > ./temp
RPMVERSION=$(./$BINFOLDER/bin/tclsh ./temp)
echo "package re GSE; puts \${gse::tcl_release}" > ./temp
RPMRELEASE=$(./$BINFOLDER/bin/tclsh ./temp)
rm ./temp

## get TCL pointer size which indicates 32bit or 64bit builds
echo "puts \$tcl_platform(pointerSize)" > ./temp
POINTSIZE=$(./$BINFOLDER/bin/tclsh ./temp)
rm ./temp

## get installed libraries
TCLLIBS=$(cd ./$BINFOLDER/lib; for i in $(ls -d */); do echo -n "${i%%/} "; done)

## get build information
BUILDKERNELNAME=$(uname)
BUILDKERNELRELEASE=$(uname -r)
BUILDKERNELVERSION=$(uname -v)
BUILDNODENAME=$(uname -n)
if [ -z "$WINDIR" ]; then
    BUILDMACHINE=$(uname -m)
    BUILDOS=$(lsb_release -sd)
    BUILDOS="${BUILDOS//\"}"
else
    if [ "$POINTSIZE" -eq 8 ]; then
        BUILDMACHINE="x86_64"
    else
        BUILDMACHINE=$(uname -m)
    fi
    BUILDOS="Windows"
fi
GITHASH=$(git log -n 1 --pretty=format:%H)
GITBRANCH=$(git branch | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

## replace in rpmspec
cp ./rpmspec.template ./rpmspec
sed -i "s|%rpm_version%|$RPMVERSION|g" ./rpmspec
sed -i "s|%rpm_release%|$RPMRELEASE|g" ./rpmspec
sed -i "s|%tcl_libraries%|$TCLLIBS|g" ./rpmspec
sed -i "s|%build_os%|$BUILDOS|g" ./rpmspec
sed -i "s|%build_kernelname%|$BUILDKERNELNAME|g" ./rpmspec
sed -i "s|%build_kernelrelease%|$BUILDKERNELRELEASE|g" ./rpmspec
sed -i "s|%build_kernelversion%|$BUILDKERNELVERSION|g" ./rpmspec
sed -i "s|%build_nodename%|$BUILDNODENAME|g" ./rpmspec
sed -i "s|%build_machine%|$BUILDMACHINE|g" ./rpmspec
sed -i "s|%git_hash%|$GITHASH|g" ./rpmspec
sed -i "s|%git_branch%|$GITBRANCH|g" ./rpmspec
sed -i "s|%bin_folder%|$BINFOLDER|g" ./rpmspec

## collect rpm infos as is
RPMNAME=$(awk -F' ' '{if($1=="%define" && $2=="name") print $3}' ./rpmspec)
RPMVERSION=$(awk -F' ' '{if($1=="%define" && $2=="version") print $3}' ./rpmspec)
RPMRELEASE=$(awk -F' ' '{if($1=="%define" && $2=="release") print $3}' ./rpmspec)
RPMARCH=$(awk -F' ' '{if($1=="%define" && $2=="buildarch") print $3}' ./rpmspec)
RPMFILE=$RPMNAME-$RPMVERSION-$RPMRELEASE.$BUILDMACHINE.$GITBRANCH
if [ -n "$TITLE" ]; then RPMFILE=$RPMFILE.$TITLE; fi
PREFIX=/home
POSTFIX=$RPMNAME

## replace in rpmspec
sed -i "s|%prefix%|$PREFIX|g" ./rpmspec
sed -i "s|%postfix%|$POSTFIX|g" ./rpmspec

## done collecting build infos
echo done

## do some cleanup
find ./$BINFOLDER -name "*~" | xargs rm -f

## plattform specific
if [ -z "$WINDIR" ]; then
    ## execute build
    mkdir -p ../rpm
    cp -r ./config ./$BINFOLDER/share/
    ../gse4-service/scripts/build-rpm.sh -indir ./$BINFOLDER -outdir ../rpm -rpm ./rpmspec -file $RPMFILE -prefix $PREFIX -postfix $POSTFIX $FOPTIONS
else
    POSTFIX=$RPMNAME-$RPMVERSION-$RPMRELEASE
    ## name folder to release version
    mv -f ./$BINFOLDER ./$POSTFIX | true
    
    ## compress to tgz file
    echo -n "Compressing ../rpm/$RPMFILE.tgz ... "
    mkdir -p ../rpm
    tar -czf ../rpm/$RPMFILE.tgz ./$POSTFIX | true
    echo done

    ## undo folder renaming
    mv -f ./$POSTFIX ./$BINFOLDER
fi

## delete old rpmspec
rm ./rpmspec
