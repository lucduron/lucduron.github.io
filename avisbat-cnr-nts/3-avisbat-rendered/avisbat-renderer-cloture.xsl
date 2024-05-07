<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="avisbat-main.xsl"/>

  <xsl:template match="RIS_Message">
    <html lang="fr">
      <xsl:call-template name="head" />
      <body>
        <xsl:call-template name="menu"/>
        <p style="border-bottom: 1px solid black;">
          <strong>
            AVIS A LA BATELLERIE N° <xsl:call-template name="number" />
            <br/>
            <span style="font-size: 0.85rem;">Cloturant l'avis n° FR/<xsl:value-of select="ftm/nts_number/year"/>/<xsl:value-of select="format-number(ftm/nts_number/number, '00000')"/></span>
          </strong>
        </p>
        <xsl:call-template name="reglements"/>
        <h1>Décrue (<xsl:call-template name="title" />)</h1>

        <xsl:call-template name="incidence">
          <xsl:with-param name="limitationCode">NOLIM</xsl:with-param>
          <xsl:with-param name="directionCode">DWN</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="incidence">
          <xsl:with-param name="limitationCode">NOLIM</xsl:with-param>
          <xsl:with-param name="directionCode">ALL</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="incidence">
          <xsl:with-param name="limitationCode">NOLIM</xsl:with-param>
          <xsl:with-param name="directionCode">UPS</xsl:with-param>
        </xsl:call-template>

        <dl>
          <dt>Commentaire :</dt>
          <dd><xsl:apply-templates select="ftm/contents"/></dd>
          <dt>
            Des pièces jointes sont attachées à cet avis.
            Vous pouvez les consulter sur notre site internet (www.vnf.fr)
          </dt>
          <dd></dd>
          <dt>Service(s) à contacter :</dt>
          <dd>
            CNR, 2 rue André Bonin, 69316 LYON Cedex 04<br/>
            Tél : 0472006969 - Fax : 0478299617<br/>
            Service Fluvial Lyonnais, 4, rue Jonas Salk, 69007 LYON<br/>
            Tél : 04 78 69 60 70
          </dd>
          <dt>Date limite d'affichage :</dt>
          <dd>Prochain avis.</dd>
        </dl>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="date">02/01/2024 à 15:30</xsl:template>

</xsl:stylesheet>
