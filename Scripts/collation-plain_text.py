from collatex import *
import codecs
import os

#Select the path to the source file
source_path = "/Users/gusriva/konrad-git/konrad-von-wuerzburg/Scripts/generated/"
text = 'hvk'
output_file = 'hvk_collation_frag.json'

#Create collation object
collation = Collation()

for filename in os.listdir(source_path):
	if filename.split('_')[0] == text:
		wit_sigla = filename.split('_')[1]
		if len(wit_sigla) < 4: #in case there are weird files
			file = codecs.open(source_path + text + "_"+ wit_sigla +"_reg.txt", 'r', 'utf-8')
			collation.add_plain_witness(wit_sigla, file.read())


table = collate(collation, segmentation = False, near_match = True, output="json")
outfile = open(output_file, 'w', encoding='utf-8')
print(table, file=outfile)


