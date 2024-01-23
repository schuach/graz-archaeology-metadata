<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:mbox="http://www.m-box.at/schema/archive"
  xmlns:lido="http://lido-schema.org"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:skos="http://www.w3.org/2004/02/skos/core#"
  expand-text="yes"
  version="3.0">

  <xsl:output indent="yes" />
  <xsl:template match="/mbox:root/mbox:archive/mbox:item">
    <lido:lido>
      <lido:lidoRecID lido:type="http://terminology.lido-schema.org/lido00100"
        lido:source="GrazMuseum">
        <xsl:value-of select="@id" />
      </lido:lidoRecID>
      <lido:category>
          <skos:Concept rdf:about="http://terminology.lido-schema.org/lido00096">
              <skos:prefLabel xml:lang="en">Human-made object</skos:prefLabel>
          </skos:Concept>
      </lido:category>
    <lido:descriptiveMetadata xml:lang="de">
        <lido:objectClassificationWrap>
            <lido:objectWorkTypeWrap>
              <xsl:for-each select="mbox:field[@name='Schlagworte'] => tokenize('; *')">
                <lido:objectWorkType>{.}</lido:objectWorkType>
              </xsl:for-each>
            </lido:objectWorkTypeWrap>
        </lido:objectClassificationWrap>
        <lido:objectIdentificationWrap>
            <lido:titleWrap>
                <lido:titleSet>
                    <lido:appellationValue>{
                      mbox:field[@name="Titel"]/mbox:text
                    }</lido:appellationValue>
                </lido:titleSet>
            </lido:titleWrap>
        </lido:objectIdentificationWrap>
    </lido:descriptiveMetadata>
    <lido:administrativeMetadata xml:lang="de">
        <lido:recordWrap>
            <lido:recordID lido:type="xxx"></lido:recordID>
            <lido:recordType></lido:recordType>
            <lido:recordSource></lido:recordSource>
        </lido:recordWrap>
    </lido:administrativeMetadata>
    </lido:lido>
  </xsl:template>



</xsl:stylesheet>
