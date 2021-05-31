<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">
<!-- $Id: manual.xsl 61 2007-07-05 23:15:49Z lbayuk $ -->
<!-- Docbook XML Style sheet for pgtcl Reference Manual -->
<!-- This is the main stylesheet for the manual. It brings in the DocBook
     chunking style sheet, then the local style sheet with parameters.
     (A separate main stylesheet is used for the INSTALL file.)
-->

<!-- Load the DocBook XML Style sheet for separate (chunked) XHTML output.
     If your XML catalog system is set up right, this URL will map into a
     local file path to the correct/latest XSL stylesheets.
     If not, you can replace this http:// URL with a file:/// URL.
-->
<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/xhtml/chunk.xsl"/>

<!-- Load the local parameters stylesheet -->
<xsl:import href="local.xsl"/>

</xsl:stylesheet>
