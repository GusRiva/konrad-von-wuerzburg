import codecs
import json

#This script transforms the json output from collatex into a CVS file

#complete with the source path
source = "welt_lohn_collation1.json"
#complete with the name of the output file
output_file = "welt_lohn_full.csv"

data = codecs.open(source, 'r','utf-8-sig')
data = json.load(data)

outfile = codecs.open(output_file, 'w', 'utf-8')
index = 0
for wit in data['witnesses']:
	outfile.write(wit)
	outfile.write(',')
outfile.write('\n')

number_wits = len(data['witnesses'])
number_words = len(data['table'][0])
index = 1
for word in range(number_words):
	for wit in range(number_wits):
		token = data['table'][wit][word]
		if token != None:
			outfile.write(token[0]['t'])
			outfile.write(',')
		else:
			outfile.write(',')
	outfile.write('\n')
	index = index + 1
	



# 	for elem in data['table'][index]:
# 		if elem != None:
# 			outfile.write(elem[0]['t'])
# 			outfile.write(",")
# 		else:
# 			outfile.write(",")
# 	index = index + 1
# 	outfile.write("\n")
outfile.close()
