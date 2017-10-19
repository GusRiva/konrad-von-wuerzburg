import re
import codecs
import json

with codecs.open("preproc_json.txt", encoding="utf-8") as file:
	text = file.read()
	text = text.replace("'",'"')
	print(text[227650:227660])

