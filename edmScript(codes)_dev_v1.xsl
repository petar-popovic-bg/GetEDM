<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:edm="http://www.europeana.eu/schemas/edm/"
xmlns:ore="http://www.openarchives.org/ore/terms/"
xmlns:owl="http://www.w3.org/2002/07/owl#"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:rdau="http://www.rdaregistry.info/Elements/u/"
xmlns:crm="http://www.cidoc-crm.org/rdfs/cidoc-crm#"
xmlns:cc="https://creativecommons.org/ns#"
xmlns:odrl="http://www.w3.org/ns/odrl/2/inheritFrom"
version="1.0">
<xsl:output method="xml" indent="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//record">
					<xsl:variable name="textLang">
						<xsl:choose>
							<xsl:when test="datafield[@tag=101]/subfield[@code='a']='srp'">
								<xsl:value-of select="'sr'"/>
							</xsl:when>
							<xsl:when test="datafield[@tag=101]/subfield[@code='a']='scr'">
								<xsl:value-of select="'hr'"/>
							</xsl:when>
							<xsl:when test="datafield[@tag=101]/subfield[@code='a']='ger'">
								<xsl:value-of select="'de'"/>
							</xsl:when>
							<xsl:when test="datafield[@tag=101]/subfield[@code='a']='eng'">
								<xsl:value-of select="'en'"/>
							</xsl:when>
							<xsl:when test="datafield[@tag=101]/subfield[@code='a']='fra'">
								<xsl:value-of select="'fr'"/>
							</xsl:when>
							<xsl:when test="datafield[@tag=101]/subfield[@code='a']='fre'">
								<xsl:value-of select="'fr'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'sr'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="catLang">
						<xsl:if test="datafield[@tag=100]/subfield[@code='h']='srp'">
							<xsl:value-of select="'sr'"/>
						</xsl:if>
					</xsl:variable>
					
					<edm:providedCHO rdf:about="{datafield[@tag=856]/subfield[@code='u']}">
					
					<!-- dc:contributor -->
						<xsl:for-each select="datafield[@tag=702]">
							<xsl:variable name="contributor">
								<xsl:if test="subfield[@code='c']">
									<xsl:value-of select="concat(' ',subfield[@code='c'])"/>
								</xsl:if>
								<xsl:if test="subfield[@code='b']">
									<xsl:value-of select="concat(' ',subfield[@code='b'])"/>
								</xsl:if>
								<xsl:if test="subfield[@code='d']">
									<xsl:value-of select="concat(' ',subfield[@code='d'])"/>
								</xsl:if>
								<xsl:if test="subfield[@code='a']">
									<xsl:value-of select="concat(' ',subfield[@code='a'])"/>
								</xsl:if>
							</xsl:variable>
							<dc:contributor xml:lang="{$catLang}">
								<xsl:value-of select="normalize-space($contributor)"/>
							</dc:contributor>
						</xsl:for-each>
						
					<!-- dc:coverage // !deprecated -->

					<!-- dc:creator -->
						<xsl:for-each select="datafield[@tag=700]">
							<xsl:variable name="creator">
								<xsl:if test="subfield[@code='c']">
									<xsl:value-of select="concat(' ',subfield[@code='c'])"/>
								</xsl:if>
								<xsl:if test="subfield[@code='b']">
									<xsl:value-of select="concat(' ',subfield[@code='b'])"/>
								</xsl:if>
								<xsl:if test="subfield[@code='d']">
									<xsl:value-of select="concat(' ',subfield[@code='d'])"/>
								</xsl:if>
								<xsl:if test="subfield[@code='a']">
									<xsl:value-of select="concat(' ',subfield[@code='a'])"/>
								</xsl:if>
							</xsl:variable>
							<dc:creator xml:lang="{$catLang}">
								<xsl:value-of select="normalize-space($creator)"/>
							</dc:creator>
						</xsl:for-each>

					<!-- dc:date // dcterms:created, dcterms:issued -->
					
					<!-- dc:description -->
						<xsl:for-each select="datafield[@tag=300]/subfield">
							<dc:description xml:lang="{$catLang}">
								<xsl:value-of select="text()"/>
							</dc:description>
						</xsl:for-each>
						<xsl:for-each select="datafield[@tag=330]/subfield[@code='a']">
							<dc:description xml:lang="{$catLang}">
								<xsl:value-of select="text()"/>
							</dc:description>
						</xsl:for-each>
											
					<!-- dc:format -->
						<xsl:for-each select="datafield[@tag=215]/subfield">
							<dc:format xml:lang="{$catLang}">
								<xsl:value-of select="text()"/>
							</dc:format>
						</xsl:for-each>
						
					<!-- dc:identifier -->
						<dc:identifier>
							<xsl:value-of select="datafield[@tag=000]/subfield[@code='x']"/>
						</dc:identifier>
					
					<!-- dc:language -->
						<xsl:for-each select="datafield[@tag=101]/subfield[@code='a']">
							<dc:language>
								<xsl:value-of select="text()"/>
							</dc:language>
						</xsl:for-each>
						
					<!-- dc:publisher -->
						<xsl:for-each select="datafield[@tag=210]/subfield[@code='c']">
							<dc:publisher xml:lang="{$textLang}">
								<xsl:value-of select="text()"/>
							</dc:publisher>
						</xsl:for-each>
						
					<!-- dc:relation -->
						<!--
						<xsl:for-each select="//record/datafield[@tag=856]/subfield[@code='u']">
							<dc:relation rdf:resource="text()"/>
						</xsl:for-each>
						-->
						
					<!-- dc:rights // Rightsholder name -->
						<!--
						<dc:rights>Copyright © British Library Board</dc:rights>
						-->
						
					<!-- dc:source -->
						<!--
						<dc:source>Security Magazine pp 3-12</dc:source>
						-->
						
					<!-- dc:subject // Predmetne odrednice -->
					
							
						<xsl:for-each select="datafield[@tag=600]/subfield[@code='a']">
							<dc:subject xml:lang="{$catLang}">
								<xsl:value-of select="normalize-space(concat(../subfield[@code='b'],' ',text(),' ',../subfield[@code='d'],' ',../subfield[@code='c']))"/>
							</dc:subject>
						</xsl:for-each>
						<xsl:for-each select="datafield[@tag=601]/subfield">
							<dc:subject xml:lang="{$catLang}">
								<xsl:value-of select="text()"/>
							</dc:subject>
						</xsl:for-each>
						<xsl:for-each select="datafield[@tag=602]/subfield">
							<dc:subject xml:lang="{$catLang}">
								<xsl:value-of select="text()"/>
							</dc:subject>
						</xsl:for-each>
						<xsl:for-each select="datafield[@tag=605]/subfield">
							<dc:subject xml:lang="{$catLang}">
								<xsl:value-of select="text()"/>
							</dc:subject>
						</xsl:for-each>
						<xsl:for-each select="datafield[@tag=606]/subfield">
							<dc:subject xml:lang="{$catLang}">
								<xsl:value-of select="text()"/>
							</dc:subject>
						</xsl:for-each>
						<xsl:for-each select="datafield[@tag=609]/subfield">
							<dc:subject xml:lang="{$catLang}">
								<xsl:value-of select="text()"/>
							</dc:subject>
						</xsl:for-each>
						
					<!-- dc:title -->
							<xsl:choose>
								<xsl:when test="datafield[@tag=200]/subfield[@code='e']">
									<dc:title xml:lang="{$textLang}">
										<xsl:value-of select="concat(datafield[@tag=200]/subfield[@code='a'],': ',datafield[@tag=200]/subfield[@code='e'])"/>
									</dc:title>
								</xsl:when>
								<xsl:when test="datafield[@tag=200]/subfield[@code='i']">
									<dc:title xml:lang="{$textLang}">
										<xsl:value-of select="concat(datafield[@tag=200]/subfield[@code='a'],': ',datafield[@tag=200]/subfield[@code='i'])"/>
									</dc:title>
								</xsl:when>
								<xsl:when test="(datafield[@tag=200]/subfield[@code='i']) and (datafield[@tag=200]/subfield[@code='i'])">
									<dc:title xml:lang="{$textLang}">
										<xsl:value-of select="concat(datafield[@tag=200]/subfield[@code='a'],': ',datafield[@tag=200]/subfield[@code='e'],': ',datafield[@tag=200]/subfield[@code='i'])"/>
									</dc:title>
								</xsl:when>
								<xsl:otherwise>
								<!--
									<xsl:if test="datafield[@tag=200]/subfield[@code='a']">
										<dc:title xml:lang="{$textLang}">
											<xsl:value-of select="datafield[@tag=200]/subfield[@code='a']"/>
										</dc:title>
									</xsl:if>
								-->
									<xsl:for-each select="datafield[@tag=200]/subfield[@code='a']">
										<dc:title xml:lang="{$textLang}">
											<xsl:value-of select="text()"/>
										</dc:title>
									</xsl:for-each>
								</xsl:otherwise>
							</xsl:choose>
	
					<!-- dc:type -->
						
				<xsl:choose>
					<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'a'">
						<xsl:choose>
							<xsl:when test="datafield[@tag='001']/subfield[@code='c'] = 'm'">
								<dc:type xml:lang="{$catLang}">monografska publikacija</dc:type>
								<dc:type xml:lang="en">monographic publication</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='001']/subfield[@code='c'] = 's'">
								<xsl:choose>
									<xsl:when test="datafield[@tag='110']/subfield[@code='a'] = 'a'">
										<dc:type xml:lang="{$catLang}">periodična publikacija</dc:type>
										<dc:type xml:lang="en">periodical publication</dc:type>
									</xsl:when>
									<xsl:when test="datafield[@tag='110']/subfield[@code='a'] = 'b'">
										<dc:type xml:lang="{$catLang}">knjižna zbirka</dc:type>
										<dc:type xml:lang="en">book collection</dc:type>
									</xsl:when>
									<xsl:when test="datafield[@tag='110']/subfield[@code='a'] = 'c'">
										<dc:type xml:lang="{$catLang}">novine</dc:type>
										<dc:type xml:lang="en">newspaper</dc:type>
									</xsl:when>
									<xsl:when test="datafield[@tag='110']/subfield[@code='a'] = 'e'">
										<dc:type xml:lang="{$catLang}">nepovezani listovi sa zamenljivim sadržajem</dc:type>
										<dc:type xml:lang="en">unlinked newspapers with interchangeable content</dc:type>
									</xsl:when>
									<xsl:when test="datafield[@tag='110']/subfield[@code='a'] = 'f'">
										<dc:type xml:lang="{$catLang}">baza podataka</dc:type>
										<dc:type xml:lang="en">database</dc:type>
									</xsl:when>
									<xsl:when test="datafield[@tag='110']/subfield[@code='a'] = 'g'">
										<dc:type xml:lang="{$catLang}">web mesto/strana</dc:type>
										<dc:type xml:lang="en">website/webpage</dc:type>
									</xsl:when>
									<xsl:when test="datafield[@tag='110']/subfield[@code='a'] = 'z'">
										<dc:type xml:lang="{$catLang}">drugo</dc:type>
										<dc:type xml:lang="en">other</dc:type>
									</xsl:when>
									<xsl:otherwise>
										<dc:type xml:lang="{$catLang}">serijska publikacija</dc:type>
										<dc:type xml:lang="{$catLang}">serial publication</dc:type>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<dc:type xml:lang="{$catLang}">tekstualna građa, štampana</dc:type>
								<dc:type xml:lang="{$catLang}">textual material, printed</dc:type>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'b'">
						<xsl:choose>
							<xsl:when test="datafield[@tag='001']/subfield[@code='c'] = 'm'">
								<dc:type xml:lang="{$catLang}">monografska publikacija</dc:type>
								<dc:type xml:lang="en">monographic publication</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='001']/subfield[@code='c'] = 's'">
								<xsl:choose>
									<xsl:when test="datafield[@tag='110']/subfield[@code='a'] = 'a'">
										<dc:type xml:lang="{$catLang}">periodična publikacija</dc:type>
										<dc:type xml:lang="en">periodical publication</dc:type>
									</xsl:when>
									<xsl:when test="datafield[@tag='110']/subfield[@code='a'] = 'b'">
										<dc:type xml:lang="{$catLang}">knjižna zbirka</dc:type>
										<dc:type xml:lang="en">book collection</dc:type>
									</xsl:when>
									<xsl:when test="datafield[@tag='110']/subfield[@code='a'] = 'c'">
										<dc:type xml:lang="{$catLang}">novine</dc:type>
										<dc:type xml:lang="en">newspaper</dc:type>
									</xsl:when>
									<xsl:when test="datafield[@tag='110']/subfield[@code='a'] = 'e'">
										<dc:type xml:lang="{$catLang}">nepovezani listovi sa zamenljivim sadržajem</dc:type>
										<dc:type xml:lang="en">unlinked newspapers with interchangeable content</dc:type>
									</xsl:when>
									<xsl:when test="datafield[@tag='110']/subfield[@code='a'] = 'f'">
										<dc:type xml:lang="{$catLang}">baza podataka</dc:type>
										<dc:type xml:lang="en">database</dc:type>
									</xsl:when>
									<xsl:when test="datafield[@tag='110']/subfield[@code='a'] = 'g'">
										<dc:type xml:lang="{$catLang}">web mesto/strana</dc:type>
										<dc:type xml:lang="en">website/webpage</dc:type>
									</xsl:when>
									<xsl:when test="datafield[@tag='110']/subfield[@code='a'] = 'z'">
										<dc:type xml:lang="{$catLang}">drugo</dc:type>
										<dc:type xml:lang="en">other</dc:type>
									</xsl:when>
									<xsl:otherwise>
										<dc:type xml:lang="{$catLang}">serijska publikacija</dc:type>
										<dc:type xml:lang="en">serial publication</dc:type>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<dc:type xml:lang="{$catLang}">tekstualna građa, rukopis</dc:type>
								<dc:type xml:lang="en">textual material, manuscript</dc:type>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'c'">
						<dc:type xml:lang="{$catLang}">muzikalije, štampane</dc:type>
						<dc:type xml:lang="en">music sources, printed</dc:type>
					</xsl:when>
					<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'd'">
						<dc:type xml:lang="{$catLang}">muzikalije, rukopis</dc:type>
						<dc:type xml:lang="en">music sources, manuscript</dc:type>
					</xsl:when>
					<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'e'">
						<xsl:choose>
							<xsl:when test="datafield[@tag='124']/subfield[@code='b'] = 'a'">
								<dc:type xml:lang="{$catLang}">atlas</dc:type>
								<dc:type xml:lang="en">atlas</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='124']/subfield[@code='b'] = 'b'">
								<dc:type xml:lang="{$catLang}">dijagram</dc:type>
								<dc:type xml:lang="en">diagram</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='124']/subfield[@code='b'] = 'c'">
								<dc:type xml:lang="{$catLang}">globus</dc:type>
								<dc:type xml:lang="en">globe</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='124']/subfield[@code='b'] = 'd'">
								<dc:type xml:lang="{$catLang}">geografska karta</dc:type>
								<dc:type xml:lang="en">geographic map</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='124']/subfield[@code='b'] = 'e'">
								<dc:type xml:lang="{$catLang}">model</dc:type>
								<dc:type xml:lang="en">model</dc:type>
							</xsl:when>
							<xsl:otherwise>
								<dc:type xml:lang="{$catLang}">kartografska građa, štampana</dc:type>
								<dc:type xml:lang="{$catLang}">cartographic material, printed</dc:type>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'f'">
						<xsl:choose>
							<xsl:when test="datafield[@tag='124']/subfield[@code='b'] = 'a'">
								<dc:type xml:lang="{$catLang}">atlas</dc:type>
								<dc:type xml:lang="en">atlas</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='124']/subfield[@code='b'] = 'b'">
								<dc:type xml:lang="{$catLang}">dijagram</dc:type>
								<dc:type xml:lang="en">diagram</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='124']/subfield[@code='b'] = 'c'">
								<dc:type xml:lang="{$catLang}">globus</dc:type>
								<dc:type xml:lang="en">globe</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='124']/subfield[@code='b'] = 'd'">
								<dc:type xml:lang="{$catLang}">geografska karta</dc:type>
								<dc:type xml:lang="en">geographic map</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='124']/subfield[@code='b'] = 'e'">
								<dc:type xml:lang="{$catLang}">model</dc:type>
								<dc:type xml:lang="en">model</dc:type>
							</xsl:when>
							<xsl:otherwise>
								<dc:type xml:lang="{$catLang}">kartografska građa, rukopis</dc:type>
								<dc:type xml:lang="en">cartographic material, manuscript</dc:type>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'g'">
						<dc:type xml:lang="{$catLang}">građa za video projekcije, videosnimci i filmovi</dc:type>
						<dc:type xml:lang="en">video projection materials, video recordings and motion pictures</dc:type>
					</xsl:when>
					<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'i'">
						<dc:type xml:lang="{$catLang}">zvučni snimci, nemuzički</dc:type>
						<dc:type xml:lang="en">sound recordings, non-musical</dc:type>
					</xsl:when>
					<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'j'">
						<dc:type xml:lang="{$catLang}">zvučni snimci, muzički</dc:type>
						<dc:type xml:lang="en">sound recordings, musical</dc:type>
					</xsl:when>
					<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'k'">
						<xsl:choose>
							<xsl:when test="datafield[@tag='116']/subfield[@code='a'] = 'a'">
								<dc:type xml:lang="{$catLang}">kolaž</dc:type>
								<dc:type xml:lang="еn">collage</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='116']/subfield[@code='a'] = 'b'">
								<dc:type xml:lang="{$catLang}">crtež</dc:type>
								<dc:type xml:lang="en">drawing</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='116']/subfield[@code='a'] = 'c'">
								<dc:type xml:lang="{$catLang}">slika</dc:type>
								<dc:type xml:lang="en">painting</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='116']/subfield[@code='a'] = 'd'">
								<dc:type xml:lang="{$catLang}">fotomehanička reprodukcija</dc:type>
								<dc:type xml:lang="en">photomechanical reproduction</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='116']/subfield[@code='a'] = 'e'">
								<dc:type xml:lang="{$catLang}">fotonegativ</dc:type>
								<dc:type xml:lang="en">photonegative</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='116']/subfield[@code='a'] = 'f'">
								<dc:type xml:lang="{$catLang}">fotootisak</dc:type>
								<dc:type xml:lang="en">photo print</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='116']/subfield[@code='a'] = 'h'">
								<dc:type xml:lang="{$catLang}">vizuelni prikaz</dc:type>
								<dc:type xml:lang="en">visual representation</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='116']/subfield[@code='a'] = 'i'">
								<dc:type xml:lang="{$catLang}">grafički otisak</dc:type>
								<dc:type xml:lang="en">graphic print</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='116']/subfield[@code='a'] = 'k'">
								<dc:type xml:lang="{$catLang}">tehnički crtež</dc:type>
								<dc:type xml:lang="en">technical drawing</dc:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='116']/subfield[@code='a'] = 'z'">
								<dc:type xml:lang="{$catLang}">druga vrsta grafike koja se vizuelno ne projektuje</dc:type>
								<dc:type xml:lang="en">other types of graphics that are not visualy projected</dc:type>
							</xsl:when>
							<xsl:otherwise>
								<dc:type xml:lang="{$catLang}">dvodimenzionalna grafika</dc:type>
								<dc:type xml:lang="{$catLang}">two-dimensional graphics</dc:type>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'l'">
						<dc:type xml:lang="{$catLang}">elektronski izvori</dc:type>
						<dc:type xml:lang="en">electronic resource</dc:type>
					</xsl:when>
					<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'm'">
						<dc:type xml:lang="{$catLang}">multimedijska građa</dc:type>
						<dc:type xml:lang="en">multimedia</dc:type>
					</xsl:when>
					<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'r'">
						<dc:type xml:lang="{$catLang}">trodimenzionalni proizvodi i predmeti</dc:type>
						<dc:type xml:lang="en">three-dimensional objects</dc:type>
					</xsl:when>
					<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'u'">
						<dc:type xml:lang="{$catLang}">događaji</dc:type>
						<dc:type xml:lang="en">events</dc:type>
					</xsl:when>
					<xsl:when test="datafield[@tag='200']/subfield[@code='b']">
					<dc:type xml:lang="{$catLang}">
						<xsl:value-of select="datafield[@tag='200']/subfield[@code='b']"/>
					</dc:type>
					</xsl:when>
					<xsl:otherwise>
						<dc:type xml:lang="{$catLang}">drugo</dc:type>
						<dc:type xml:lang="en">other</dc:type>
					</xsl:otherwise>
				</xsl:choose>
					<!--	
						<dc:type xml:lang="{datafield[@tag=100]/subfield[@code='h']}">
							<xsl:value-of select="datafield[@tag=200]/subfield[@code='b']"/>
						</dc:type>
					-->
					
					<!-- dcterms:alternative -->
						<xsl:for-each select="datafield[@tag=200]/subfield[@code='d']">
							<dcterms:alternative xml:lang="{../subfield[@code='z']}">
								<xsl:value-of select="text()"/>
							</dcterms:alternative>
						</xsl:for-each>
						<xsl:for-each select="datafield[@tag=517]/subfield[@code='a']">
							<dcterms:alternative xml:lang="{$catLang}">
								<xsl:value-of select="text()"/>
							</dcterms:alternative>
						</xsl:for-each>
						<xsl:for-each select="datafield[@tag=541]/subfield[@code='a']">
							<dcterms:alternative xml:lang="{../subfield[@code='z']}">
								<xsl:value-of select="text()"/>
							</dcterms:alternative>
						</xsl:for-each>
					
					<!-- dcterms:conformsTo -->
					
					<!-- dcterms:created -->
						<xsl:for-each select="datafield[@tag=210]/subfield[@code='h']">
							<dcterms:created>
								<xsl:value-of select="text()"/>
							</dcterms:created>
						</xsl:for-each>
					
					<!-- dcterms:extent -->
					
					
					<!-- dcterms:hasFormst -->
					
					<!-- dcterms:hasPart -->
						<!-- Periodicals??? -->
					
					<!-- dcterms:hasVersion -->
					
					<!-- dcterms:isFormatOf -->
					
					<!-- dcterms:isPartOf -->
						<!-- Periodicals??? -->
					
					<!-- dcterms:isReferencedBy -->
					
					<!-- dcterms:isReplacedBy -->
					
					<!-- dcterms:isRequiredBy -->
						
					<!-- dcterms:issued -->
						<xsl:for-each select="datafield[@tag=210]/subfield[@code='d']">
							<dcterms:issued>
								<xsl:value-of select="text()"/>
							</dcterms:issued>
						</xsl:for-each>
					
					<!-- dcterms:isVersionOf -->
					
					<!-- dcterms:medium -->
					
					<!-- dcterms:provenance -->
						<!--
						<dcterms:provenance>Donated to the National library of Serbia in 2010</dcterms:provenance>
						-->
						
					<!-- dcterms:references -->
					
					<!-- dcterms:replaces -->
					
					<!-- dcterms:requires -->
					
					<!-- dcterms:spatial -->
						<xsl:for-each select="datafield[@tag=607]/subfield[@code='a']">
							<dcterms:spatial xml:lang="{$catLang}">
								<xsl:value-of select="text()"/>
							</dcterms:spatial>
						</xsl:for-each>
					
					<!-- dcterms:tableOfContents -->
					
					<!-- dcterms:temporal -->
						<xsl:for-each select="datafield[@tag=608]/subfield">
							<dcterms:temporal xml:lang="{$catLang}">
								<xsl:value-of select="text()"/>
							</dcterms:temporal>
						</xsl:for-each>
						
					<!-- edm:currentLocation -->
						<edm:currentLocation rdf:resource="http://sws.geonames.org/792680/"/>
					
					<!-- edm:hasMet -->
					
					<!-- edm:hasType -->
					
					<!-- edm:incorporates -->
					
					<!-- edm:isDerivativeOf -->
					
					<!-- edm:isNextInSequence -->
					
					<!-- edm:isRelatedTo -->
					
					<!-- edm:isRepresentationOf -->
					
					<!-- edm:isSimilarTo -->
					
					<!-- edm:isSuccessorOf -->
					
					<!-- edm:realizes -->
						
					<!-- edm:type literal: IMAGE/TEXT -->
						<xsl:choose>
							<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'k'">
								<edm:type>IMAGE</edm:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'e'">
								<edm:type>IMAGE</edm:type>
							</xsl:when>
							<xsl:when test="datafield[@tag='001']/subfield[@code='b'] = 'f'">
								<edm:type>IMAGE</edm:type>
							</xsl:when>
							<xsl:otherwise>
								<edm:type>TEXT</edm:type>
							</xsl:otherwise>
						</xsl:choose>
							
					<!-- owl:sameAs -->
					
					</edm:providedCHO>
					<ore:Aggregation rdf:about="{datafield[@tag=856]/subfield[@code='u']}">
						<edm:aggregatedCHO rdf:resource="{datafield[@tag=856]/subfield[@code='u']}"/>
						<edm:dataProvider>National library of Serbia</edm:dataProvider>
						<edm:provider>National library of Serbia</edm:provider>
						<edm:rights rdf:resource="http://www.europeana.eu/rights/out-of-copyright-non-commercial/ THIS IS JUST AN EXAMPLE"/>
						<edm:isShownAt rdf:resource="{datafield[@tag=856]/subfield[@code='u']}"/>
					</ore:Aggregation>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>