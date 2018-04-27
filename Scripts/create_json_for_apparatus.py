from lxml import etree
import re
import codecs
import json

maere = 'herz' # possibilities: herz, dwl, hvk

path = '/Applications/XAMPP/xamppfiles/htdocs/konrad/'

if maere == 'herz':
    source = path + "TEI/Herz_syn.xml"
elif maere == 'dwl':
    source = path + "TEI/DWL_syn.xml"
elif maere == 'hvk':
    source = path + "TEI/HvK_syn.xml"

output = {}

with codecs.open(source, "r", 'utf-8') as f:
    full_tree = etree.parse(f)

def tei(tag):
    return "{http://www.tei-c.org/ns/1.0}%s" % tag

def get_words_reg(elem):
    text = ""
    for word in elem.iter():
    	if word.tag == tei('reg'):
    		if word.text:
    			text = text + word.text + " "
    return text

def get_words_orig(elem):
    text = ""
    for levelOneEl in elem.findall("./"):
        if levelOneEl.tag == tei('w'):
            for orig in levelOneEl:
                if orig.tag == tei('orig'):
                    if orig.text:
                        text = text + orig.text
                    for child in orig:
                        text = text + dig_orig(child)
        elif levelOneEl.tag == tei('c'):
            text = text + ' '
        elif levelOneEl.tag == tei('add') or levelOneEl.tag == tei('hi') or levelOneEl.tag == tei('choice') or levelOneEl.tag == tei('subst'):
            text = text + dig_orig(levelOneEl)
    text = re.sub('\n','',text)
    return text

def dig_orig(elem):
    text = ''
    if elem.tag == tei('w'):
        for child in elem:
            text = text + dig_orig(child)
        return text
    elif elem.tag == tei('orig'):
        if elem.text:
            text = text + elem.text
        for child in elem:
            text = text + dig_orig(child)
        return text
    elif elem.tag == tei('choice') or elem.tag == tei('subst'):
        for child in elem:
            if child.tag == tei('expan') or child.tag == tei('add'):
                text = text + dig_orig(child)
        return text
    elif elem.tag == tei('expan') or elem.tag == tei('add'):
        if elem.text:
            text = text + elem.text
        for child in elem:
            if child.tag == tei('w'):
                text = text + dig_orig(child)
        return text
    elif elem.tag == tei('ex'):
        if elem.text:
            text = text + elem.text
        if elem.tail:
            text = text + elem.tail
        return text
    elif elem.tag == tei('abbr') or elem.tag == tei('am') or elem.tag == tei('del') or elem.tag == tei('sic') or elem.tag == tei('reg'):
        return ''  
    elif elem.tag == tei('corr'):
        if elem.text:
            text = text + elem.text
        for child in elem:
            text = text + dig_orig(child)
            if child.tail:
                text = text + child.tail
        return text
    elif elem.tag == tei('hi') or elem.tag == tei('metamark'):
        if elem.text:
            text = text + elem.text
        for child in elem:
            text = text + dig_orig(child)
            if child.tail:
                text = text + child.tail
        if elem.tail:
            text = text + elem.tail
        return text
    else:
        return text

#REGULARIZED
for line in full_tree.iter(tei('l')):
    line_num = line.attrib['{http://www.w3.org/XML/1998/namespace}id']
    line_num = line_num[2:]
    output[line_num]=[]
    count = 0
    for rdg in line[0]:
        if rdg.tag == tei('rdg'):
            witness = rdg.attrib["wit"]
            output[line_num].append({"edition": witness})
            output[line_num][count]["text"] = get_words_reg(rdg)
            count = count + 1

output = [output]
output = str(output)
file = codecs.open(path + "preproc_json.txt", "w", "utf-8")
file.write(output)
file.close()


with codecs.open(path + "preproc_json.txt", encoding="utf-8") as file:
    text = file.read()
    text = text.replace("'",'"')
    text = str(text)

output_file = maere + "_apparatus_reg.js"
with codecs.open( path + output_file, "w", encoding="utf-8") as new_file:
    new_file.write("data_reg = '" + text + "'")


#ORIGINAL
output={}
for line in full_tree.iter(tei('l')):
    line_num = line.attrib['{http://www.w3.org/XML/1998/namespace}id']
    line_num = line_num[2:]
    output[line_num]=[]
    count = 0
    for rdg in line[0]:
        if rdg.tag == tei('rdg'):
            witness = rdg.attrib["wit"]
            output[line_num].append({"edition": witness})
            output[line_num][count]["text"] = get_words_orig(rdg)
            count = count + 1

output = [output]
output = str(output)
file = codecs.open(path + "preproc_json.txt", "w", "utf-8")
file.write(output)
file.close()


with codecs.open(path + "preproc_json.txt", encoding="utf-8") as file:
    text = file.read()
    text = text.replace("'",'"')
    text = str(text)

output_file = maere + "_apparatus_orig.js"
with codecs.open( path + output_file, "w", encoding="utf-8") as new_file:
    new_file.write("data_orig = '" + text + "'")

