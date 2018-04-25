#This script transforms the plain text transcriptions into a simple xml file structure

import codecs
from lxml import etree

#Complete with the path and name of the destination file
destination = "/Users/gusriva/Desktop/python-tesis/new_file.xml"

#Complete the witness abbreviation
witness = 'A'

with codecs.open('/Users/gusriva/Desktop/python-tesis/test.txt') as f:
	source = f.readlines()

#strip the line-breaks
source = [x.strip('\n') for x in source]
#Complete the initial verse number. Use 0 if the title has 1 line, negative numbers if more, and then correct on the resulting file
verse = 1

root = etree.Element("root")
for line in source:
	if line[0:2] == '//':
		if 'pb' in line:
			etree.SubElement(root,"pb", edRef = witness, facs= '#'+witness+'_'+line[5:-2])
		elif 'cb' in line:
			etree.SubElement(root,"cb", edRef = witness, facs= '#'+witness+'_'+line[5:-2])
	else:
		etree.SubElement(root,"rdg", n= str(verse), corresp= str(verse)).text = line
		verse = verse+1

tree = etree.ElementTree(root)
tree.write(destination)
