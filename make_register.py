import glob
import os

from slugify import slugify
from collections import defaultdict
import jinja2
from acdh_tei_pyutils.tei import TeiReader

files = glob.glob('./data/band_001/*.xml')


def slug(value):
    return slugify(value)


templateLoader = jinja2.FileSystemLoader(searchpath=".")
templateEnv = jinja2.Environment(loader=templateLoader)
templateEnv.filters["slugify"] = slugify

persons = defaultdict(list)
places = defaultdict(list)
indices = defaultdict(list)
for x in files:
    doc = TeiReader(x)
    title = "".join(doc.any_xpath('.//tei:title[@type="sub"]//text()'))
    f_name = os.path.split(x)[-1]
    for item in doc.any_xpath('.//tei:body//tei:persName[@key]/@key'):
        persons[item.strip()].append([item.strip(), title, f_name])
    for item in doc.any_xpath('.//tei:body//tei:placeName[@key]/@key'):
        places[item.strip()].append([item.strip(), title, f_name])
    for item in doc.any_xpath('.//tei:body//tei:index[@key]/@key'):
        indices[item.strip()].append([item.strip(), title, f_name])

template_name = "listperson.xml"
template = templateEnv.get_template(f'./templates_py/{template_name}')
context = {
    "objects": dict(persons)
}
template.stream(**context).dump(f"./data/register/{template_name}")

template_name = "listplace.xml"
template = templateEnv.get_template(f'./templates_py/{template_name}')
context = {
    "objects": dict(places)
}
template.stream(**context).dump(f"./data/register/{template_name}")
