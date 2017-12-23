import codecs
import json

#This script transforms the json output from collatex into a CVS file

#complete with the source path
source = "welt_lohn_collation1.json"
#complete with the name of the output file
output_file = "welt_lohn_collation1.csv"

data = json.load(codecs.open("welt_lohn_collation1.json", 'r', 'utf-8'))
outfile = codecs.open(output_file, 'w', 'utf-8')
index = 0
for wit in data['witnesses']:
	outfile.write(wit)
	outfile.write(",")
	for elem in data['table'][index]:
		if elem != None:
			outfile.write(elem[0]['t'])
			outfile.write(",")
		else:
			outfile.write(",")
	index = index + 1
	outfile.write("\n")
outfile.close()
