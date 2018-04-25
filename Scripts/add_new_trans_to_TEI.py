#This script helps start a new numbering

import codecs
from lxml import etree

#Complete with the path and name of the destination file
destination = "/Users/gusriva/Desktop/python-tesis/new_TEI.xml"

TEI_file = '/Users/gusriva/Desktop/python-tesis/skeleton.xml'
witness_TEI = 'A'

to_add = '/Users/gusriva/Desktop/python-tesis/2nd_file_numb.xml'
witness_new = 'B'

def tei(tag):
    return "{http://www.tei-c.org/ns/1.0}%s" % tag

with codecs.open(TEI_file, 'r', 'utf-8') as f:
	tei_tree = etree.parse(f)

with codecs.open(to_add, 'r', 'utf-8') as f:
	new_tree = etree.parse(f)

last_compati = '1' #this number keeps track of the last time both editions coincided in corresp
list_of_orig_corresp = [] #this list keeps all the verses of the original file, to then add the missing in the new one
list_of_new_corresp = []

for rdg in tei_tree.iter(tei('rdg')):
	list_of_orig_corresp.append(rdg.attrib['corresp'])	

for rdg in new_tree.iter('rdg'):
	new_corresp = rdg.attrib['corresp']
	list_of_new_corresp.append(new_corresp)
	corresp_rdg = tei_tree.findall('//'+tei('rdg')+'[@corresp="'+new_corresp+'"]')
	if len(corresp_rdg) > 0:
		corresp_rdg = corresp_rdg[0]
		parent = corresp_rdg.find('..')
		parent.append(rdg)
		last_compati = new_corresp
	else:
		last_rdg = tei_tree.findall('//'+tei('rdg')+'[@corresp="'+last_compati+'"]')
		new_line = etree.Element(tei('l'))
		new_app = etree.Element(tei('app'))
		new_missing_rdg = etree.Element('rdg', wit= witness_TEI, corresp= rdg.attrib['corresp'], type='missing')
		last_rdg[0].find('../..').addnext(new_line)
		new_line.append(new_app)
		new_app.append(new_missing_rdg)
		new_rdg = etree.Element('{http://www.tei-c.org/ns/1.0}rdg', corresp= rdg.attrib['corresp'], n= rdg.attrib['n'], wit=witness_new)
		new_rdg.text = rdg.text
		new_app.append(new_rdg)
		last_compati = rdg.attrib['corresp']

for item in list_of_orig_corresp:
	if item not in list_of_new_corresp:
		old_rdg = tei_tree.findall('//{http://www.tei-c.org/ns/1.0}rdg[@corresp="'+item+'"]')
		new_rdg = etree.Element('{http://www.tei-c.org/ns/1.0}rdg', wit= witness_new, type='missing', corresp=item)
		old_rdg[0].addnext(new_rdg)

tei_tree.write(destination)