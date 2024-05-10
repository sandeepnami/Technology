from math import factorial as fac

from urllib.request	import urlopen 
url_list=['http://sixty-north.com/c/t.txt','https://www.sanskritdictionary.com/?iencoding=iast&q=stupid&lang=sans&action=Search']
print(url_list[1])
story=urlopen(url_list[1])
story_words=[]

for line in story:
	linewords=line.split()
	linewords=line.decode('utf8').split()
	for word in linewords:
		story_words.append(word)

for word in story_words:
	print(word)



