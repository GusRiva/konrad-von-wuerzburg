from lxml import etree
import re
import codecs

'''
THIS SCRIPT STRIPS THE XML ELEMENTS FROM THE SYNOPTIC TRANSCRIPTION AND RETURNS A .TXT FOR EACH WITNESS.
IT SELECTS THE EXPANDED VERSION AND WITHOUT MOST PALEOGRAPHICAL DIFFERENCES
'''

source = "/Applications/XAMPP/xamppfiles/htdocs/konrad/TEI/DWL_Synoptische_Transkription.xml"
text_name = "dwl"


with codecs.open(source, "r", 'utf-8') as f:
    full_tree = etree.parse(f)


def tei(tag):
    return "{http://www.tei-c.org/ns/1.0}%s" % tag

def create_txt(full_tree):
    '''
    Creates txt files of all the witnesses in a TEI file. 
    Those files names are "text_witness" on the same location as this python script
    '''
    for wit in full_tree.iter(tei('witness')):
        witness = '#'+wit.attrib["{http://www.w3.org/XML/1998/namespace}id"]
        #Run the XSL to order the witness
        xslt1 = etree.parse("/Applications/XAMPP/xamppfiles/htdocs/konrad/XSLT/isolate_witness.xsl")
        xslt2 = etree.parse("/Applications/XAMPP/xamppfiles/htdocs/konrad/XSLT/order_witness.xsl")
        transform = etree.XSLT(xslt1)
        newdom = transform(full_tree, manuscript = etree.XSLT.strparam(witness))
        transform = etree.XSLT(xslt2)
        newdom = transform(newdom)
        

        #Create the new file
        writing = ""
        for line in newdom.iter(tei('l')):
            if line.attrib:
                writing = writing + line.attrib['{http://www.w3.org/XML/1998/namespace}id'] + ' '                
            for w in line.iter(tei('w')):
                for reg in w.iter(tei('reg')):
                    if reg.text:
                        writing = writing + reg.text + ' '
        
        #Created the file and writes the text. CHECK THE DIRECTORY TO WRITE IN!!
        with codecs.open("generated/" + text_name + "_" + witness[1:] + "_reg.txt", "w", "utf-8") as new_file:
            new_file.write(writing)

create_txt(full_tree)
