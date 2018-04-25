import codecs
from lxml import etree
import re

text_title = "Heinrich von Kempten"

source = "/Applications/XAMPP/xamppfiles/htdocs/konrad/TEI/Herz_syn.xml"

destination = "/Applications/XAMPP/xamppfiles/htdocs/konrad/TEI/Herz_syn1.xml"


with codecs.open(source, 'r', 'utf-8') as file:
	full_tree = etree.parse(file)
	

def tei(tag):
    return "{http://www.tei-c.org/ns/1.0}%s" % tag

verse_number = 1
for elem in full_tree.iter(tei('l')):
	elem.attrib['{http://www.w3.org/XML/1998/namespace}id'] = "v_" + str(verse_number)
	verse_number = verse_number + 1
		


#write the final version
full_tree.write(destination, encoding="UTF-8")


