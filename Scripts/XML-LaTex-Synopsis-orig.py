import codecs
from lxml import etree
import re

text_title = "Heinrich von Kempten"

source = "/Applications/XAMPP/xamppfiles/htdocs/konrad/TEI/Herz_Synoptische_Transkription.xml"

destination = "/Users/gusriva/konrad-git/konrad-von-wuerzburg/LaTex/Latex_Herz_Critical_V.txt"

text = ""

with codecs.open(source, 'r', 'utf-8') as file:
	full_tree = etree.parse(file)
	

def tei(tag):
    return "{http://www.tei-c.org/ns/1.0}%s" % tag


for l in full_tree.iter(tei('l')):
	line = ""
	if l.getchildren() != []:
		#First write the entire line
		for orig_pc in l.iter():
			if orig_pc.tag == tei('orig') or orig_pc.tag == tei('pc'):
				if orig_pc.findall('../..')[0].tag != tei('rdg'):
					line = line + orig_pc.text
			elif orig_pc.tag == tei('c'):
				line = line + " "
		#algo add the verse number at the end
		verse = l.attrib['{http://www.w3.org/XML/1998/namespace}id']
		verse = verse.split("_",1)[1]
		line = line + '\hfill' + verse + "&"+ "\n"
		#Then check if there is an apparatus
		for app in l.iter(tei('app')):
			#get the variant readings in a tuple (witnesses,text, verse)
			readings = []
			for rdg in app.iter(tei('rdg')):
				witnesses = rdg.attrib['wit']
				witnesses = witnesses.replace('#','')
				reading = rdg.findall('./'+tei('w')+'/'+tei('orig'))
				reading_string = ""
				for element in reading:
					reading_string = reading_string + element.text + " "
				readings.append((witnesses,reading_string, verse))
				readings_string = readings[0][1]
				if readings_string == '':
					readings_string = 'om.'
				readings_string = readings_string + ' ' + readings[0][0]
			#get the lemmas
			for lem in app.iter(tei('lem')):
				lemma_list = []
				lemma = ''
				for word in lem.iter(tei('orig')):
					lemma_list.append(word.text)
					lemma = ' '.join(lemma_list)
				if lemma != "":
					#replace the lemma with the apparatus reference

					line = line.replace(lemma, r"\edtext{\textit{"+lemma+r"}}{\lemma{"+lemma+r"}\Afootnote{"+ readings_string +"}}")
				else:
					#when the lemma is empty
					for reading in readings:
						line = line.replace(reading[1], r"\edtext{\textit{"+reading[1]+r"}}{\lemma{"+reading[0]+r"}\Afootnote{Palabra sacada}}")

						# line = line + r"\edtext{}{\Afootnote[nosep]{om.}}"
				
			#\edtext{\textit{daz}}{\lemma{daz}\Afootnote{Some comments}}
	text = text + line	

with codecs.open(destination, 'w', 'utf-8') as outfile:
	outfile.write(text)

keep_verses = []
all_verse_num = re.findall(r'\d+',text)
for index, number in enumerate(all_verse_num):
	if index < len(all_verse_num)-1 and index > 0:
		if int(number) % 5 == 0 or int(number) + 1 != int(all_verse_num[index+1]) or int(number) - 1 != int(all_verse_num[index-1]):
			keep_verses.append(number)
	else:
		keep_verses.append(number)


# #text is complete, correct the line-numbers
with codecs.open(destination, 'r', 'utf-8') as outfile:
	text_lines = outfile.readlines()

text = ''
for line in text_lines:
	verse = re.findall(r'\d',line)
	verse = ''.join(verse)
	if verse in keep_verses:
		text = text + line
	else:
		line = line.replace('\hfill' + verse,'')
		text = text + line

#change the font size

text = text.replace("\hfill",r"\hfill{\footnotesize")
text = re.sub(r'(\d)&',r'\1}&',text)
# text = text.replace("&","}&")
# text = text.replace(" }&"," &")
# text = text.replace(" .",".")
# text = text.replace(" ,",",")
# text = text.replace(" :",":")
# text = text.replace(' "','"')
# text = text.replace(" ;",";")
# text = text.replace(" ?","?")
# text = text.replace(" !","!")
# text = text.replace('  ',' ')
# text = text.replace("“ ","“")
# text = text.replace(" ”","”")

print(text)

#write the final version
with codecs.open(destination, 'w', 'utf-8') as outfile:
	outfile.write(text)


