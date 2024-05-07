<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template name="title">
    <xsl:value-of select="identification/preceding-sibling::comment()[1]" />
  </xsl:template>

  <xsl:template name="number">
    <xsl:value-of select="substring-before(substring-after(translate(preceding-sibling::comment()[1], '_', '/'), '/'), '.')" />
  </xsl:template>

  <xsl:template name="head">
    <head>
        <meta charset="utf-8" />
        <title><xsl:call-template name="number" /></title>
        <link href="avisbat-renderer.css" type="text/css" rel="stylesheet" />
      </head>
  </xsl:template>

  <xsl:template name="menu">
    <table style="background-color: silver; width: 100%; text-align: center;">
      <tr>
        <th>Type</th>
        <th>Secteur 1</th>
        <th>Secteur 2</th>
        <th>Secteur 3</th>
        <th>Secteur 4</th>
        <th>Secteur 5</th>
        <th>Secteur 6</th>
      </tr>
      <tr>
        <td>Avis de déclaration</td>
        <td><a href="FRA_FR_2024_00001.xml">00001</a></td>
        <td><a href="FRA_FR_2024_00002.xml">00002</a></td>
        <td><a href="FRA_FR_2024_00003.xml">00003</a></td>
        <td><a href="FRA_FR_2024_00004.xml">00004</a></td>
        <td><a href="FRA_FR_2024_00005.xml">00005</a></td>
        <td><a href="FRA_FR_2024_00006.xml">00006</a></td>
      </tr>
      <tr>
        <td>Avis de clôture</td>
        <td><a href="FRA_FR_2024_00007.xml">00007</a></td>
        <td><a href="FRA_FR_2024_00008.xml">00008</a></td>
        <td><a href="FRA_FR_2024_00009.xml">00009</a></td>
        <td><a href="FRA_FR_2024_00010.xml">00010</a></td>
        <td><a href="FRA_FR_2024_00011.xml">00011</a></td>
        <td><a href="FRA_FR_2024_00012.xml">00012</a></td>
      </tr>
      <tr>
        <td colspan="7">
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="concat('../2-avisbat-generated/', preceding-sibling::comment()[1])" />
            </xsl:attribute>
            Voir le XML (au format NtS-FTM)
         </a>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="reglements">
    <p style="margin-bottom: 0;">Pris en application :</p>
    <p style="margin-top: 0; padding-left: 4rem;">Décret n° 2012-1556 du 28 décembre 2012</p>
  </xsl:template>

  <xsl:template match="contents">
    <pre>
      <xsl:apply-templates/>
    </pre>
  </xsl:template>

  <xsl:template match="target_group">
    <xsl:choose>
      <xsl:when test="contains(target_group_code, 'ALL')">Tous les usagers</xsl:when>
      <xsl:when test="contains(target_group_code, 'PAX')">Bateaux à passagers</xsl:when>
      <xsl:when test="contains(target_group_code, 'PLE')">Bateaux de plaisance</xsl:when>
      <xsl:otherwise>
        ERROR
      </xsl:otherwise>
    </xsl:choose> -
    <xsl:choose>
      <xsl:when test="contains(direction_code, 'ALL')">dans les deux sens</xsl:when>
      <xsl:when test="contains(direction_code, 'UPS')">trafic montant</xsl:when>
      <xsl:when test="contains(direction_code, 'DWN')">trafic avalant</xsl:when>
      <xsl:otherwise>
        ERROR
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="position() != last()">, </xsl:if>
  </xsl:template>

  <xsl:template name="incidence">
    <xsl:param name="limitationCode" />
    <xsl:param name="directionCode" />
    <xsl:if test="ftm/*/limitation[limitation_code[contains(text(), $limitationCode)] and target_group/direction_code[contains(text(), $directionCode)]]">
      <h2>
        <xsl:attribute name="class"><xsl:value-of select="$limitationCode" /></xsl:attribute>
        <xsl:choose>
          <xsl:when test="contains($limitationCode, 'CAUTIO')">Modification des conditions de navigation</xsl:when>
          <xsl:when test="contains($limitationCode, 'OBSTRU')">Arrêt de navigation</xsl:when>
          <xsl:when test="contains($limitationCode, 'NOLIM')">Une reprise de la navigation</xsl:when>
          <xsl:otherwise>
            ERROR
          </xsl:otherwise>
        </xsl:choose>
          (<xsl:for-each select="ftm/*/limitation[limitation_code[contains(text(), $limitationCode)] and target_group/direction_code[contains(text(), $directionCode)]]">
             <xsl:if test="position() = 1">
               <xsl:apply-templates select="target_group"/>
             </xsl:if>
           </xsl:for-each>)
      </h2>
      <ul class="tirets">
        <li><strong>à partir du <xsl:call-template name="date" /></strong>
          <ul>
            <xsl:apply-templates select="ftm/*[limitation[limitation_code[contains(text(), $limitationCode)]]/target_group/direction_code[contains(text(), $directionCode)]]"/>
          </ul>
        </li>
      </ul>
    </xsl:if>
  </xsl:template>

  <xsl:template match="fairway_section">
    <li>
      <strong><xsl:value-of select="geo_object/name"/></strong><br/>
      <xsl:value-of select="geo_object/fairway_name"/>
      <xsl:call-template name="position" />
    </li>
  </xsl:template>

  <xsl:template match="object">
    <li>
      <strong><xsl:value-of select="geo_object/name"/></strong><br/>
      <xsl:value-of select="geo_object/fairway_name"/>
      <xsl:call-template name="position" />
    </li>
  </xsl:template>

  <xsl:template name="position">
    <xsl:if test="limitation/position_code">
      -
      <xsl:choose>
        <xsl:when test="limitation/position_code[contains(text(), 'AL')]">Tout le chenal</xsl:when>
        <xsl:otherwise>
          ERROR
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>