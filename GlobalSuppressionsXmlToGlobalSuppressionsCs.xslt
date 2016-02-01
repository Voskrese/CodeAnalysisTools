<?xml version="1.0" encoding="Windows-1251"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 

	<xsl:template match="*" mode="x">
		<xsl:text>!@@!</xsl:text>
		<xsl:value-of select="name()"/>
	</xsl:template>

	<xsl:template match="*[name() = 'SuppressMessage']">
		<xsl:text>[assembly: System.Diagnostics.CodeAnalysis.SuppressMessage("</xsl:text>
		<xsl:value-of select="@Category" />
		<xsl:text>", "</xsl:text>
		<xsl:value-of select="@Rule" />
		<xsl:text>"</xsl:text>
		<xsl:if test="not(@MessageId = '')">
			<xsl:text>, MessageId="</xsl:text>
			<xsl:value-of select="@MessageId" />
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:if test="not(@Scope = '')">
			<xsl:text>, Scope="</xsl:text>
			<xsl:value-of select="@Scope" />
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:if test="not(@Target = '')">
			<xsl:text>, Target="</xsl:text>
			<xsl:value-of select="@Target" />
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text>)]</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:template>

	<xsl:template match="/">
		<xsl:apply-templates select="//SuppressMessage">
			<xsl:sort select="@Rule" />
			<xsl:sort select="current()[number(@MessageId) != @MessageId]/@MessageId" />
			<xsl:sort select="@Target" />
		</xsl:apply-templates>
	</xsl:template>

</xsl:stylesheet>