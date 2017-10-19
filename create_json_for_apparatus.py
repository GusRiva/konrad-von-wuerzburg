from lxml import etree
import re
import codecs

output = {}

source = "/Applications/XAMPP/xamppfiles/htdocs/konrad/TEI/Herz_tokenized-reg2.xml"
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
print(output)

# test_dict = [{"1" : [{"edition": "Edition1","text":"Diz ist der welt mere"},{"edition":"Edition2","text":"Ditz ist welt maere"}], "age" : "32"}]
# print(test_dict)