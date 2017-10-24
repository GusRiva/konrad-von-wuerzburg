from lxml import etree
import re
import codecs
import json

output = {}

source = "/Applications/XAMPP/xamppfiles/htdocs/konrad/TEI/Herz_tokenized-reg.xml"
with codecs.open(source, "r", 'utf-8') as f:
    full_tree = etree.parse(f)
def tei(tag):
    return "{http://www.tei-c.org/ns/1.0}%s" % tag

def get_words(elem):
    text = ""
    for word_or_space in elem.iter():
    	if word_or_space.tag == tei('reg'):
    		if word_or_space.text:
    			text = text + word_or_space.text
    	elif word_or_space.tag == tei('space'):
    		text = text + " "
    return text

for line in full_tree.iter(tei('l')):
    line_num = line.attrib['{http://www.w3.org/XML/1998/namespace}id']
    line_num = line_num[2:]
    output[line_num]=[]
    count = 0
    for rdg in line[0]:
        if rdg.tag == tei('rdg'):
            witness = rdg.attrib["wit"]
            output[line_num].append({"edition": witness})
            output[line_num][count]["text"] = get_words(rdg)
            count = count + 1




output = [output]
output = str(output)
file = codecs.open("/Applications/XAMPP/xamppfiles/htdocs/konrad_clone/preproc_json.txt", "w", "utf-8")
file.write(output)
file.close()


with codecs.open("preproc_json.txt", encoding="utf-8") as file:
    text = file.read()
    text = text.replace("'",'"')
    text = str(text)

with codecs.open("apparatus.json", "w", encoding="utf-8") as new_file:
    new_file.write("data = '" + text + "'")


