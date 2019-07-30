import xml.etree.ElementTree as ET
from xml.etree.ElementTree import Element, SubElement
import requests

comarcFileName = input('Address to COMARCXML file: ')
type = input('<dc:type> for whole set: ')
rightsStatement = input('<edm:rights> for whole set: ')
tree = ET.parse(comarcFileName)

root = tree.getroot()

edmrootAttributesDict = {'xmlns:rdf': 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
                         'xmlns:dc': 'http://purl.org/dc/elements/1.1',
                         'xmlns:dcterms': 'http://purl.org/dc/terms',
                         'xmlns:edm': 'http://www.europeana.eu/schemas/ed',
                         'xmlns:ore': 'http://www.openarchives.org/ore/terms'
                         }

edmroot = Element('rdf:RDF', edmrootAttributesDict)


def setTextLang(textLang):
    if textLang == 'srp' or textLang == 'scc':
        textLang = 'sr'
    elif textLang == 'ger':
        textLang = 'de'
    elif textLang == 'ita':
        textLang = 'it'
    elif textLang == 'lat':
        textLang = 'la'
    elif textLang == 'eng':
        textLang = 'en'
    elif textLang == 'rus':
        textLang = 'ru'
    elif textLang == 'hrv':
        textLang = 'hr'
    else:
        return textLang
    return textLang


for record in root.findall('record'):
    aggregates = Element('ore:aggregates')

    if record.find("datafield[@tag='856']/subfield[@code='u']") is not None:
        link = record.find("datafield[@tag='856']/subfield[@code='u']").text
        if requests.head(link).status_code == 200:
            pass
        else:
            link = link + ' ERROR!'
    else:
        link = ''

    providedCHO = SubElement(aggregates, 'edm:providedCHO', {'rdf:about': link})

    textLang = record.find("datafield[@tag='101']/subfield[@code='a']").text
    textLang = setTextLang(textLang)

    # dc:contributor
    for contrib in record.findall("datafield[@tag='702']"):
        dcContributor = SubElement(providedCHO, 'dc:contributor', {'xml:lang': 'sr'})
        dcContributor.text = ''
        if contrib.find("subfield[@code='c']") is not None:
            dcContributor.text += contrib.find("subfield[@code='c']").text
        if contrib.find("subfield[@code='b']") is not None:
            dcContributor.text += ' '
            dcContributor.text += contrib.find("subfield[@code='b']").text
        if contrib.find("subfield[@code='d']") is not None:
            dcContributor.text += ' '
            dcContributor.text += contrib.find("subfield[@code='d']").text
        if contrib.find("subfield[@code='a']") is not None:
            dcContributor.text += ' '
            dcContributor.text += contrib.find("subfield[@code='a']").text
        dcContributor.text = dcContributor.text.lstrip()

    # dc:creator
    for creator in record.findall("datafield[@tag='700']"):
        dcCreator = SubElement(providedCHO, 'dc:creator', {'xml:lang': 'sr'})
        dcCreator.text = ''
        if creator.find("subfield[@code='c']") is not None:
            dcCreator.text += creator.find("subfield[@code='c']").text
        if creator.find("subfield[@code='b']") is not None:
            dcCreator.text += ' '
            dcCreator.text += creator.find("subfield[@code='b']").text
        if creator.find("subfield[@code='d']") is not None:
            dcCreator.text += ' '
            dcCreator.text += creator.find("subfield[@code='d']").text
        if creator.find("subfield[@code='a']") is not None:
            dcCreator.text += ' '
            dcCreator.text += creator.find("subfield[@code='a']").text
        dcCreator.text = dcCreator.text.lstrip()

    # dc:description
    for description in record.findall("datafield[@tag='300']/subfield"):
        dcDescription = SubElement(providedCHO, 'dc:description', {'xml:lang': 'sr'})
        dcDescription.text = description.text
    for description in record.findall("datafield[@tag='330']/subfield[@code='a']"):
        dcDescription = SubElement(providedCHO, 'dc:description', {'xml:lang': 'sr'})
        dcDescription.text = description.text

    # dc:format
    for format in record.findall("datafield[@tag='215']/subfield"):
        dcFormat = SubElement(providedCHO, 'dc:format', {'xml:lang': 'sr'})
        dcFormat.text = format.text

    # dc:identifier
    dcIdentifier = SubElement(providedCHO, 'dc:identifier')
    dcIdentifier.text = record.find("datafield[@tag='000']/subfield[@code='x']").text

    # dc:language
    for language in record.findall("datafield[@tag='101']/subfield[@code='a']"):
        dcLanguage = SubElement(providedCHO, 'dc:language')
        dcLanguage.text = setTextLang(language.text)

    # dc:publisher
    for publisher in record.findall("datafield[@tag='210']/subfield[@code='c']"):
        dcPublisher = SubElement(providedCHO, 'dc:publisher', {'xml:lang': 'sr'})
        dcPublisher.text = publisher.text

    # dc:subject
    for subject in record.findall("datafield[@tag='600']"):
        dcSubject = SubElement(providedCHO, 'dc:subject', {'xml:lang': 'sr'})
        dcSubject.text = ''
        subjects = []
        if subject.find("subfield[@code='b']") is not None:
            subjects.append(subject.find("subfield[@code='b']").text)
        if subject.find("subfield[@code='a']") is not None:
            subjects.append(' ')
            subjects.append(subject.find("subfield[@code='a']").text)
        if subject.find("subfield[@code='d']") is not None:
            subjects.append(' ')
            subjects.append(subject.find("subfield[@code='d']").text)
        if subject.find("subfield[@code='c']") is not None:
            subjects.append(' ')
            subjects.append(subject.find("subfield[@code='c']").text)
        dcSubject.text = ''.join(subjects)

    for subject in record.findall("datafield[@tag='601']/subfield"):
        dcSubject = SubElement(providedCHO, 'dc:subject', {'xml:lang': 'sr'})
        dcSubject.text = subject.text
    for subject in record.findall("datafield[@tag='602']/subfield"):
        dcSubject = SubElement(providedCHO, 'dc:subject', {'xml:lang': 'sr'})
        dcSubject.text = subject.text
    for subject in record.findall("datafield[@tag='605']/subfield"):
        dcSubject = SubElement(providedCHO, 'dc:subject', {'xml:lang': 'sr'})
        dcSubject.text = subject.text
    for subject in record.findall("datafield[@tag='606']/subfield"):
        dcSubject = SubElement(providedCHO, 'dc:subject', {'xml:lang': 'sr'})
        dcSubject.text = subject.text
    for subject in record.findall("datafield[@tag='609']/subfield"):
        dcSubject = SubElement(providedCHO, 'dc:subject', {'xml:lang': 'sr'})
        dcSubject.text = subject.text

    # dc:title
    if record.find("datafield[@tag='200']/subfield[@code='e']") is not None:
        dcTitle = SubElement(providedCHO, 'dc:title', {'xml:lang': textLang})
        dcTitle.text = ''.join([record.find("datafield[@tag='200']/subfield[@code='a']").text,
                                ' : ', record.find("datafield[@tag='200']/subfield[@code='e']").text])
    elif record.find("datafield[@tag='200']/subfield[@code='i']") is not None:
        dcTitle = SubElement(providedCHO, 'dc:title', {'xml:lang': textLang})
        dcTitle.text = ''.join([record.find("datafield[@tag='200']/subfield[@code='a']").text,
                                ' : ', record.find("datafield[@tag='200']/subfield[@code='i']").text])
    elif record.find("datafield[@tag='200']/subfield[@code='e']") is not None and record.find(
            "datafield[@tag='200']/subfield[@code='i']"):
        dcTitle = SubElement(providedCHO, 'dc:title', {'xml:lang': textLang})
        dcTitle.text = ''.join([record.find("datafield[@tag='200']/subfield[@code='a']").text,
                                ' : ', record.find("datafield[@tag='200']/subfield[@code='e']").text,
                                ' : ', record.find("datafield[@tag='200']/subfield[@code='i']").text])
    else:
        for title in record.findall("datafield[@tag='200']/subfield[@code='a']"):
            dcTitle = SubElement(providedCHO, 'dc:title', {'xml:lang': textLang})
            dcTitle.text = title.text

    # dcterms:alternative
    for element in record.findall("datafield[@tag='200']/subfield[@code='d']"):
        try:
            xlang = record.find("datafield[@tag='200']/subfield[@code='z']").text
        except:
            xlang = 'sr'
        dctermsAlternative = SubElement(providedCHO, 'dcterms:alternative', {'xml:lang': xlang})
        dctermsAlternative.text = element.text
    for element in record.findall("datafield[@tag='517']/subfield[@code='a']"):
        dctermsAlternative = SubElement(providedCHO, 'dcterms:alternative', {'xml:lang': 'sr'})
        dctermsAlternative.text = element.text
    for element in record.findall("datafield[@tag='541']/subfield[@code='a']"):
        try:
            xlang = record.find("datafield[@tag='541']/subfield[@code='z']")
        except:
            xlang = 'sr'
        dctermsAlternative = SubElement(providedCHO, 'dcterms:alternative', {'xml:lang': xlang})
        dctermsAlternative.text = element.text

    # dcterms:created
    for created in record.findall("datafield[@tag='210']/subfield[@code='h']"):
        dctermsCreated = SubElement(providedCHO, 'dcterms:created')
        dctermsCreated.text = created.text

    # dcterms:issued
    for issued in record.findall("datafield[@tag='210']/subfield[@code='d']"):
        dctermsIssued = SubElement(providedCHO, 'dcterms:issued')
        dctermsIssued.text = issued.text

    # dcterms:spatial
    for spatial in record.findall("datafield[@tag='607']/subfield[@code='a']"):
        dctermsSpatial = SubElement(providedCHO, 'dcterms:spatial', {'xml:lang': 'sr'})
        dctermsSpatial.text = spatial.text

    # dcterms:temporal
    for temporal in record.findall("datafield[@tag='608']/subfield"):
        dctermsTemporal = SubElement(providedCHO, 'dcterms:temporal', {'xml:lang': 'sr'})
        dctermsTemporal.text = temporal.text

    # edm:currentLocation
    edmCurrentLocation = SubElement(providedCHO, 'edm:currentLocation',
                                    {'rdf:resource': 'http://sws.geonames.org/792680/'})

    # edm:type
    edmTypeVal = record.find("datafield[@tag='001']/subfield[@code='b']").text
    edmType = SubElement(providedCHO, 'edm:type')
    if edmTypeVal == 'k' or edmTypeVal == 'e' or edmTypeVal == 'f':
        edmType.text = 'IMAGE'
    else:
        edmType.text = 'TEXT'

    Aggregation = SubElement(aggregates, 'ore:Aggregation', {'rdf:about': link})

    aggregatedCHO = SubElement(Aggregation, 'edm:aggregatedCHO', {'rdf:resource': link})
    provider = SubElement(Aggregation, 'edm:provider')
    provider.text = 'National Library of Serbia'
    dataProvider = SubElement(Aggregation, 'edm:dataProvider')
    dataProvider.text = 'National Library of Serbia'
    rights = SubElement(Aggregation, 'edm:rights',
                        {'rdf:resource': rightsStatement})
    isShownAt = SubElement(Aggregation, 'edm:isShownAt', {'rdf:resource': link})
    isShownBy = SubElement(Aggregation, 'edm:isShownBy', {'rdf:resource': ''.join([link, '?pageIndex=00001'])})
    Object = SubElement(Aggregation, 'edm:Object', {'rdf:resource': ''.join([link, '?pageIndex=thumb'])})
    edmroot.append(aggregates)

for CHO in edmroot.iter('edm:providedCHO'):
    dcType = SubElement(CHO, 'dc:type', {'xml:lang': 'sr'})
    if type is not '':
        dcType.text = type
    else:
        dcType.text = 'insert dc:type here'
    # for subject in CHO.findall('dc:subject'):
    # wdataSubject = SubElement(CHO, 'dc:subject', {'rdf:resource': wdata.searchWikidata(subject.text)})

tree = ET.ElementTree(edmroot)
tree.write(input('EDM Collection filename: '), encoding='UTF-8')
print('\n\nFile droped!\n\n--- END ---\n\n')

input('Press enter to exit')
