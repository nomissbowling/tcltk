# $Id: Makefile 391 2017-11-14 00:50:13Z lbayuk $
# Makefile for Pgtcl reference manual (DocBook-XML version)
# This uses xsltproc for HTML. No PDF at this time.

# === Makefile Configuration ===

# Package name:
PACKAGE=pgtcldocs
# Version for the release package and to be included in the manual:
VERSION=20171113

# XSL Style Sheet for HTML generation of the manual:
XSL_HTML=manual.xsl
# XSL Style Sheet for single-file output of INSTALL:
XSL_INSTALL=install.xsl

# XSL Transformation Processor program:
XSLTPROC=xsltproc

# Command to turn HTML into text, used for stand-alone INSTALL file.
# Could be lynx or links.
# If lynx:
#   Some versions of lynx default to trying to justify all text,
#   which looks ugly (2.8.5 does this) and there is no command-line option
#   to turn it off. You must place JUSTIFY:FALSE in lynx.cfg to make it
#   work like the older version.
#HTML2TXT=lynx -force_html -dump -nolist
# links seems to do a better job here, putting more spaces around things.
HTML2TXT=links -force-html -width 78 -dump

# === End of Makefile Configuration ===

# Primary source file, which includes the others:
MAIN=pgtcl.xml

# List of all source files:
SRC=$(MAIN) $(XSL_HTML) $(XSL_INSTALL) local.xsl \
 building.xml examples.xml legalinfo.xml \
 loading.xml overview.xml reference.xml

# File to add to release, in addition to *.html:
ALSO=stylesheet.css

# Release base name:
RELEASE=$(PACKAGE)-$(VERSION)

default: html
html: html.mark

# Version date stamp file, depends on this Makefile which contains the version:
version.xml: Makefile
	echo $(VERSION) |\
		sed 's/\(....\)\(..\)\(.*\)/<!ENTITY version "\1-\2-\3">/' > $@

# Build XHTML Manual. The html.mark file is just used for dependency checking.
html.mark: $(SRC) $(ALSO) version.xml
	$(XSLTPROC) $(XSLTPROCFLAGS) $(XSL_HTML) $(MAIN)
	touch html.mark

# Build the stand-alone INSTALL file. This uses a special conditional
# markup defined in style.xsl and controlled with the isalone parameter.
# Using /dev/stdin to lynx/links almost works, but has problems, so use
# a temporary file install.
INSTALL: INSTALL.xml building.xml version.xml
	$(XSLTPROC) --param isalone 1 $(XSL_INSTALL) INSTALL.xml > INSTALL.html
	$(HTML2TXT) INSTALL.html > INSTALL
	#rm INSTALL.html

# Special version of the manual with required logo for
# Sourceforge project web pages. See the XSLT style sheet for details.
sfhtml:
	$(MAKE) -$(MAKEFLAGS) XSLTPROCFLAGS='--param footerlogo 1' html

clean:
	-rm -f HTML.index *.html *.htm html.mark version.xml INSTALL

# Make a documentation release:
release: html
	mkdir $(RELEASE)
	cp *.html  $(ALSO) $(RELEASE)
	zip -r $(RELEASE).zip $(RELEASE)
	rm -rf $(RELEASE)
	@echo Created release $(RELEASE)
