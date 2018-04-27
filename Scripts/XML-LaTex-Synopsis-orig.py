from lxml import etree
import re
import codecs

'''
NOT READY!!!!!!!!
THIS SCRIPT STRIPS THE XML ELEMENTS FROM THE SYNOPTIC TRANSCRIPTION AND RETURNS A .TXT FOR EACH WITNESS.
EACH VERSE IN A DIFFERENT LINE AND READY FOR THE LATEX TEMPLATE WITH RELEDMAC.
IT SELECTS THE EXPANDED VERSION AND ADDS SIGNS FOR DEL, ADD, HI = BOLD
'''

source = "/Applications/XAMPP/xamppfiles/htdocs/konrad/TEI/DWL_syn.xml"
text_name = "dwl"


with codecs.open(source, "r", 'utf-8') as f:
    full_tree = etree.parse(f)


def tei(tag):
    return "{http://www.tei-c.org/ns/1.0}%s" % tag

def dive(elem):
    text = ""
    if elem.tag != tei("reg") and elem.tag != tei("abbr") and elem.tag != tei("am"):
        if elem.text:
            text = text + elem.text
        if elem.tag == tei("choice") or elem.tag == tei("corr") or elem.tag == tei("w") or elem.tag == tei("orig"):
            for child in elem:
                text = text + dive(child)
        elif elem.tag == tei("add"):
            for child in elem:
                text = text + '[' + dive(child) + ']'
        elif elem.tag == tei("del"):
            for child in elem:
                text = text + r"\st{" + dive(child) + '}'
        elif elem.tag == tei('hi'):
            for child in elem:
                text = text + r"\textbf{" + dive(child) + '}'
        if elem.tail:
            text = text + elem.tail
        text = text.replace("\n", "")
        text = re.sub("\s{2:}", " ", text)
    return text

def create_txt(full_tree):
    '''
    Creates txt files of all the witnesses in a TEI file. 
    Those files names are "text_witness" on the same location as this python script
    '''
    for wit in full_tree.iter(tei('witness')):
        witness = '#' + wit.attrib["{http://www.w3.org/XML/1998/namespace}id"]
        #Create the new file
        writing = ""
        for element in full_tree.iter():
            if element.tag == tei("cb"):
                if element.attrib['edRef'] == witness:
                    writing = writing + "\ledouternote{"+ element.attrib['facs']+"}"
            if element.tag == tei("pb"):
                if element.attrib['edRef'] == witness:
                    writing = writing + "\ledouternote{"+ element.attrib['facs']+"}"
            if element.tag == tei("rdg"):
                

        
        # for rdg in newdom.iter(tei('rdg')):
        #     for child in rdg:
        #         writing = writing + dive(child)
        #     writing = writing + "\n"

                
            
        #When the variable writing has the whole text, the following lines remove all the superfluos whitespaces and empty lines
        # lines = re.findall(".+", writing)
        # clean_lines = []
        # for line in lines:
        #     clean_line = re.findall("\w+\s*",line)
        #     clean_line = "".join(clean_line)
        #     if len(clean_line) > 1:
        #         clean_lines.append(clean_line)
        # final_text = "&\n".join(clean_lines)
        #Created the file and writes the text. CHECK THE DIRECTORY TO WRITE IN!!
        with codecs.open("origs/" + text_name + "_" + witness + ".txt", "w", "utf-8") as new_file:
            new_file.write(writing)

create_txt(full_tree)
