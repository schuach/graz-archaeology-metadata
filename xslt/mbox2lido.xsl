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
      <lido:lidoRecID lido:type="http://terminology.lido-schema.org/lido00100" lido:source="GrazMuseum">{@id}</lido:lidoRecID>
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
          <lido:objectMeasurementsWrap>
            <lido:objectMeasurementsSet>
              <lido:displayObjectMeasurements xml:lang="de">{
                  mbox:field[@name="Maße"]/mbox:text
                }</lido:displayObjectMeasurements>
            </lido:objectMeasurementsSet>
          </lido:objectMeasurementsWrap>
          <lido:objectMaterialsTechWrap>
            <lido:objectMaterialsTechSet>
              <lido:displayMaterialsTech>{
                mbox:field[@name="Material"]/mbox:text}, {mbox:field[@name="Technik"]/mbox:text
              }</lido:displayMaterialsTech>
              <lido:materialsTech>
                <!-- Medium -->
                <lido:termMaterialsTech lido:type="http://terminology.lido-schema.org/lido00513">
                  <lido:term xml:lang="de">{mbox:field[@name="Material"]/mbox:text}</lido:term>
                </lido:termMaterialsTech>
                <!-- Technique -->
                <lido:termMaterialsTech lido:type="http://terminology.lido-schema.org/lido00131">
                  <lido:term xml:lang="de">{mbox:field[@name="Technik"]/mbox:text}</lido:term>
                </lido:termMaterialsTech>
              </lido:materialsTech>
            </lido:objectMaterialsTechSet>
          </lido:objectMaterialsTechWrap>
          <lido:repositoryWrap>
            <xsl:call-template name="makeRepositorySet" />
          </lido:repositoryWrap>
        </lido:objectIdentificationWrap>
        <lido:objectDescriptionWrap>
          <xsl:call-template name="makeDescriptionSet" />
        </lido:objectDescriptionWrap>
        <lido:eventWrap>
          <!-- creation event -->
          <lido:eventSet>
            <lido:event>
              <lido:eventType>http://terminology.lido-schema.org/lido00007</lido:eventType>
              <lido:eventDate>
                <lido:displayDate>{
                  mbox:field[@name="Datierung"]/mbox:text
                }</lido:displayDate>
              </lido:eventDate>
            </lido:event>
          </lido:eventSet>
          <!-- aquisition -->
          <lido:eventSet>
            <lido:event>
              <!-- Change of physical control and legal title (en) -->
              <lido:eventType>http://terminology.lido-schema.org/lido01184</lido:eventType>
              <lido:eventDesriptionSet>
                  <xsl:call-template name="makeAcqNote" />
              </lido:eventDesriptionSet>
            </lido:event>
          </lido:eventSet>
        </lido:eventWrap>
      </lido:descriptiveMetadata>
      <lido:administrativeMetadata xml:lang="de">
        <lido:recordWrap>
          <lido:recordID lido:type="http://terminology.lido-schema.org/lido00100">{@id}</lido:recordID>
          <lido:recordType>
            <lido:term>single object</lido:term>
          </lido:recordType>
          <lido:recordSource>
            <!-- <lido:legalBodyID lido:type="URI" lido:source="ISIL (ISO 15511)">info:isil/DE-Mb112</lido:legalBodyID> -->
            <lido:legalBodyName>
              <lido:appellationValue>{mbox:field[@name="Institution"]/mbox:text}</lido:appellationValue>
            </lido:legalBodyName>
            <lido:legalBodyWeblink>https://www.grazmuseum.at/</lido:legalBodyWeblink>
          </lido:recordSource>
        </lido:recordWrap>
      </lido:administrativeMetadata>
    </lido:lido>
  </xsl:template>


  <!-- Information about the repository -->
  <xsl:template name="makeRepositorySet">
    <xsl:variable name="institution" select="mbox:field[@name='Institution']/mbox:text" />
    <xsl:variable name="invNr" select="mbox:field[@name='Inventarnummer']/mbox:text" />
    <xsl:variable name="objLoc" select="mbox:field[@name='Objektstandort Gebäude/Raum']" />
    <xsl:variable name="objSubLoc" select="mbox:field[@name='Objektstandort Aufstellungseinheit']" />
    <xsl:variable name="objContainer" select="mbox:field[@name='Objektstandort Verpackungseinheit']" />

    <!-- current repository -->
    <lido:repositorySet type="http://terminology.lido-schema.org/lido01018">
      <lido:displayRepository xml:lang="de">{
        $institution || ": " || string-join(($objLoc, $objSubLoc, $objContainer), ", ")
      }</lido:displayRepository>

      <!-- repository name -->
      <lido:repositoryName>
        <lido:legalBodyName>
          <lido:appellationValue>{mbox:field[@name="Institution"]/mbox:text}</lido:appellationValue>
        </lido:legalBodyName>
        <lido:legalBodyWeblink>https://www.grazmuseum.at/</lido:legalBodyWeblink>
      </lido:repositoryName>

      <!-- Inventory number http://terminology.lido-schema.org/lido00113 -->
      <lido:workId type="http://terminology.lido-schema.org/lido00113">{
        $invNr
      }</lido:workId>

      <!-- repositoryLocation -->
    </lido:repositorySet>

  </xsl:template>

  <xsl:template name="makeAcqNote">
    <xsl:for-each select="mbox:field[@name=(
                          'Eingangsart',
                          'Eingangsdatum',
                          'Status',
                          'Voreigentümer*in Name',
                          'Voreigentümer*in Ort',
                          'Voreigentümer*in Rolle'
                          )]">
      <lido:descriptiveNoteValue xml:lang="de">{
        string-join((@name, mbox:text), ": ")
      }</lido:descriptiveNoteValue>
    </xsl:for-each>
  </xsl:template>

  <!-- Descriptive metadata with no explicit target. -->
  <xsl:template name="makeDescriptionSet">
    <xsl:for-each select="mbox:field[@name=(
                       'Bez., Signaturen, Punzen, Marken',
                       'Objektbeschreibung',
                       'Objektbiografie',
                       'Identifizierungsgrad',
                       'Objektzustand Allgemein',
                       'Schäden',
                       'Provenienzbewertung',
                       'Provenienzbewertung Begründung'
                       )]" >
      <xsl:if test="mbox:text != ''">
        <lido:objectDescriptionSet>
          <lido:descriptiveNoteValue xml:lang="de">{
         @name || ": " || mbox:text
      }</lido:descriptiveNoteValue>
        </lido:objectDescriptionSet>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
