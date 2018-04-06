import codecs
from lxml import etree
import re

text_title = "Heinrich von Kempten"

source = "/Applications/XAMPP/xamppfiles/htdocs/konrad/TEI/DWL_Trad.xml"

destination = "/Users/gusriva/konrad-git/konrad-von-wuerzburg/LaTex/Latex_DWL_trad.txt"



text = ""

with codecs.open(source, 'r', 'utf-8') as file:
	full_tree = etree.parse(file)
	

def tei(tag):
    return "{http://www.tei-c.org/ns/1.0}%s" % tag


for l in full_tree.iter(tei('l')):
	if l.text:
		line = l.text
		#add the verse number at the end
		# verse = l.attrib['{http://www.w3.org/XML/1998/namespace}id']
		# verse = verse.split("_",1)[1]
		# line = line + '\hfill' + verse + "&"+ "\n"
		text = text + line + '&\n'	


# with codecs.open(destination, 'w', 'utf-8') as outfile:
# 	outfile.write(text)

# keep_verses = []
# all_verse_num = re.findall(r'\d+',text)
# for index, number in enumerate(all_verse_num):
# 	if index < len(all_verse_num)-1 and index > 0:
# 		if int(number) % 5 == 0 or int(number) + 1 != int(all_verse_num[index+1]) or int(number) - 1 != int(all_verse_num[index-1]):
# 			keep_verses.append(number)
# 	else:
# 		keep_verses.append(number)

#text is complete, correct the line-numbers
# with codecs.open(destination, 'r', 'utf-8') as outfile:
# 	text_lines = outfile.readlines()

# text = ''
# for line in text_lines:
# 	verse = re.findall(r'\d',line)
# 	verse = ''.join(verse)
# 	if verse in keep_verses:
# 		text = text + line +" "
# 	else:
# 		line = line.replace('\hfill' + verse,'')
# 		text = text + line + " "

#change the font size

# text = text.replace("\hfill",r"\hfill{\scriptsize")

# text = text.replace("&","}&")
# text = text.replace(" }&"," &")
# text = re.sub(r'([0123456789])&',r'\1}&',text)
# print(text)
text = text.replace(" .",".")
text = text.replace(" ,",",")
text = text.replace(" :",":")
#text = text.replace(' "','"')
text = text.replace(" ;",";")
text = text.replace('  ',' ')
text = text.replace("“ ","“")
text = text.replace(" ”","”")
print(text)


#write the final version
with codecs.open(destination, 'w', 'utf-8') as outfile:
	outfile.write(text)


