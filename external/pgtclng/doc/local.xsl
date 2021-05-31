<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">
<!-- $Id: local.xsl 285 2011-09-16 19:00:18Z lbayuk $ -->
<!-- Docbook XML Style sheet for pgtcl Reference Manual -->
<!-- This contains the local parameter settings, and is imported from
     a main stylesheet. The main stylesheet first imports a DocBook
     stylesheet (chunking or whole) and then imports this file.
-->


<!-- Encoding now defaults to utf-8; change it back to normal. -->
<xsl:param name="chunker.output.encoding" select="'ISO-8859-1'" />

<!-- Use meaningful output filenames -->
<xsl:param name="use.id.as.filename" select="'1'" />

<!-- Reference the HTML stylesheet -->
<xsl:param name="html.stylesheet" select="'stylesheet.css'" />

<!-- Move the copyright notice to a separate file -->
<xsl:param name="generate.legalnotice.link" select="1" />

<!-- Number sections, and include parent number -->
<xsl:param name="section.autolabel" select="'1'" />
<xsl:param name="section.label.includes.component.label" select="'1'" />

<!-- Other style controls -->
<xsl:param name="callout.graphics" select="'0'" />
<xsl:param name="generate.index" select="0" />
    <!-- The default anyway for XHTML? -->
<xsl:param name="make.valid.html" select="1" />
<xsl:param name="refentry.xref.manvol" select="0" />
<!-- These put the function name, not NAME, at the top of the ref page -->
<xsl:param name="refentry.generate.name" select="0" />
<xsl:param name="refentry.generate.title" select="1" />

<!-- TOC controls
  Note the following trick is used. In reference, I want a TOC in each
  top-level section, but not in the other chapters. So reference uses
  <section>, and the other chapters use <sect1> <sect2> etc. That way
  the TOCs can be  turned on for section, and off for sect#.
 -->
<xsl:param name="generate.toc">
appendix  toc,title
book      toc,title
chapter   nop
part      toc,title
component toc
preface   toc,title
reference toc,title
sect1     nop
sect2     nop
sect3     nop
sect4     nop
sect5     nop
section   toc
division  toc
</xsl:param>
<xsl:param name="generate.section.toc.level" select="1" />

<!-- This is used to conditionally select text from building.xml
     based on whether a stand-alone INSTALL file is being created,
     or INSTALL is part of the manual.
 -->
<xsl:param name="isalone" select="0"/>
<xsl:template match="ifalone">
  <xsl:if test="$isalone != 0">
    <xsl:call-template name="inline.charseq"/>
  </xsl:if>
</xsl:template>
<xsl:template match="ifnotalone">
  <xsl:if test="$isalone = 0">
    <xsl:call-template name="inline.charseq"/>
  </xsl:if>
</xsl:template>

<!-- Use Tcl conventions for optional arguments -->
<xsl:param name="arg.choice.opt.open.str" select="'?'" />
<xsl:param name="arg.choice.opt.close.str" select="'?'" />

<!-- Conditional inclusion of extra footer content. This is needed to comply
     with Sourceforge.net rules for use of project web space.
     If  footerlogo=1 option is used on the xsltproc command line,
     then the extra content will be included.
   NOTE: This is very specific to this project (see group_id).
-->
<xsl:param name="footerlogo" select="0"/>  <!-- Default value -->
<xsl:template name="user.footer.navigation">
  <xsl:if test="$footerlogo != 0">
<div><a href="http://sourceforge.net/projects/pgtclng/"><img
  src="http://sflogo.sourceforge.net/sflogo.php?group_id=516797&amp;type=10"
  width="80" height="15" border="0" alt="SourceForge.net Logo"
  align="left" /></a>
<p style="font-size: 50%">This version of the manual was produced for the
Pgtcl-ng Sourceforge project web service site, which requires the logo on each
page.<br />To download a logo-free copy of the manual, see the
<a href="http://sourceforge.net/projects/pgtclng/">Pgtcl-ng project</a>
downloads area.</p></div>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
