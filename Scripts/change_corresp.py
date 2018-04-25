#This script helps start a new numbering

import codecs
from lxml import etree

#Complete with the path and name of the destination file
destination = "/Users/gusriva/Desktop/python-tesis/new_file_numb.xml"


with codecs.open('/Users/gusriva/Desktop/python-tesis/new_file.xml', 'r', 'utf-8') as f:
	tree = etree.parse(f)

#Complete the corresp number starting in which to change
orig_num = 7
#Complete the new number of that verse
new_num = 5

for rdg in tree.iter('rdg'):
	if rdg.attrib['corresp'] == str(orig_num):
		print(rdg)
		rdg.attrib['corresp'] = str(new_num)
		orig_num = orig_num + 1
		new_num = new_num + 1

tree.write(destination)