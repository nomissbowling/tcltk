# Makefile for binary release
VERSION=2.1.1
PACKAGE=pgtcl
ARCH=win32
# There should be a - between package and version, but the
# TEA Makefile doesn't do it for source distributions, so we
# leave it out here too.
DISTNAME=$(PACKAGE)$(VERSION)-$(ARCH)
DISTDIR=/tmp/dist
DIST=$(DISTDIR)/$(DISTNAME)
FILES=README.txt COPYRIGHT pkgIndex.tcl libpgtcl.dll

default: all

README.txt: README
	todos < README > README.txt

all: $(FILES)
	-mkdir -p $(DIST)
	cp $(FILES) $(DIST)
	cd $(DISTDIR); zip -r $(DISTNAME).zip $(DISTNAME)
	rm -rf $(DIST)
