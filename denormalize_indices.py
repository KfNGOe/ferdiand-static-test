import glob
import os
import lxml.etree as ET
from collections import defaultdict
from acdh_tei_pyutils.tei import TeiReader

ns = {'tei': "http://www.tei-c.org/ns/1.0"}
doc_ents = defaultdict(set)

for x in glob.glob('./data/register/*.xml'):
    doc = TeiReader(x)
    for ent in doc.any_xpath('.//tei:ptr'):
        doc_id = ent.get('target').split(':')[-1]
        index_node = ent.xpath(
            './/ancestor::tei:*[@xml:id][1]',
            namespaces=ns
        )[0]
        doc_ents[doc_id].add(index_node)

for x in glob.glob('./data/band_001/*.xml'):
    f_name = os.path.split(x)[-1]
    doc = TeiReader(x)
    text = doc.any_xpath('.//tei:text')[0]
    for bad in doc.any_xpath('.//tei:back'):
        bad.getparent().remove(bad)
    back = ET.Element('{http://www.tei-c.org/ns/1.0}back')
    text.append(back)
    list_person = ET.Element('{http://www.tei-c.org/ns/1.0}listPerson')
    list_place = ET.Element('{http://www.tei-c.org/ns/1.0}listPlace')
    for el in [list_person, list_place]:
        back.append(el)
    for ent in doc_ents[f_name]:
        if ent.tag.endswith('person'):
            list_person.append(ent)
        elif ent.tag.endswith('place'):
            list_place.append(ent)
        else:
            pass
    doc.tree_to_file(x)
