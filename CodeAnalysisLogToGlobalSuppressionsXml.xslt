<?xml version="1.0" encoding="Windows-1251"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 

	<xsl:template match="Module" mode="Scope" />

	<xsl:template match="Namespace" mode="Scope">namespace</xsl:template>

	<xsl:template match="Type" mode="Scope">type</xsl:template>

	<xsl:template match="Member" mode="Scope">member</xsl:template>

	<xsl:template match="Accessor" mode="Scope">member</xsl:template>

	<xsl:template match="Module" mode="Target" />

	<xsl:template match="Namespace" mode="Target">
		<xsl:value-of select="@Name" />
	</xsl:template>

	<xsl:template match="Type" mode="Target">
		<xsl:apply-templates select="../.." mode="Target" />.<xsl:value-of select="@Name" />
	</xsl:template>

	<xsl:template match="Member" mode="Target">
		<xsl:apply-templates select="../.." mode="Target" />.<xsl:value-of select="@Name" />
	</xsl:template>

	<xsl:template match="Accessor" mode="Target">
		<xsl:apply-templates select="../.." mode="Target" />
	</xsl:template>

	<xsl:template match="Message">
		<SuppressMessage>
			<xsl:attribute name="Category"><xsl:value-of select="@Category" /></xsl:attribute>
			<xsl:attribute name="Rule"><xsl:value-of select="@CheckId" />:<xsl:value-of select="@TypeName" /></xsl:attribute>
			<xsl:attribute name="MessageId"><xsl:value-of select="@Id" /></xsl:attribute>
			<xsl:attribute name="Scope"><xsl:apply-templates select="../.." mode="Scope" /></xsl:attribute>
			<xsl:attribute name="Target"><xsl:apply-templates select="../.." mode="Target" /></xsl:attribute>
		</SuppressMessage>
	</xsl:template>

	<xsl:template match="/">
		<Suppressions>
			<xsl:apply-templates select="//Message" />
		</Suppressions>
	</xsl:template>

</xsl:stylesheet>