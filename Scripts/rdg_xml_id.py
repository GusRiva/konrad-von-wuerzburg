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

# C_139r-a.v_31_line_25

# # First, create a dictionary - list of tuples with cb: [(verse_number,position_after_cb)]
# for elem in full_tree.iter():

list_lines = {}

counter = 0
for rdg in full_tree.iter(tei('rdg')):
	witness = rdg.attrib['wit'][1:]
	folio = rdg.xpath('(preceding::tei:cb[@edRef="#'+witness+'"])[last()]/@facs', namespaces={'tei': 'http://www.tei-c.org/ns/1.0'})
	#if there is no cb, then len == 0, so do again with pb
	if len(folio) == 0:
		folio = rdg.xpath('(preceding::tei:pb[@edRef="#'+witness+'"])[last()]/@facs', namespaces={'tei': 'http://www.tei-c.org/ns/1.0'})
	# folio = folio[0][3:]
	if counter == 0:
		list_lines[folio[0]] = []
	
	print(list_lines)
	# print(list_lines)
	verse = rdg.xpath('../../@xml:id')
	
	line = 0

	counter = counter + 1


#write the final version
# full_tree.write(destination, encoding="UTF-8")


