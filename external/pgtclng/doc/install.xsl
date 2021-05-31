<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">
<!-- $Id: install.xsl 61 2007-07-05 23:15:49Z lbayuk $ -->
<!-- Docbook XML Style sheet for pgtcl INSTALL file -->
<!-- This is the main stylesheet for the stand-alone INSTALL file.
     Unlike the manual stylesheet, it does not do Docbook chunking so
     output is in a single file. 
-->

<!-- Load the DocBook XML Style sheet.
     If your XML catalog system is set up right, this URL will map into a
     local file path to the correct/latest XSL stylesheets.
     If not, you can replace this http:// URL with a file:/// URL.
-->
<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/xhtml/docbook.xsl"/>

<!-- Load the local parameters stylesheet -->
<xsl:import href="local.xsl"/>

<xsl:param name="chapter.autolabel" select="0" />
<xsl:param name="section.autolabel" select="0" />
<xsl:param name="section.label.includes.component.label" select="0" />
<xsl:param name="generate.toc">
article   nop
chapter   nop
sect1     nop
sect2     nop
sect3     nop
</xsl:param>

<!-- Hack: supress horizontal rule below empty title page -->
<xsl:template name="article.titlepage.separator">
</xsl:template>


</xsl:stylesheet>
