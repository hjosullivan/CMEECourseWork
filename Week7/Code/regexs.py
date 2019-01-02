#!/usr/bin/env python3

"""

Regex examples

"""

import re

#assign string variable
my_string = "a given string"

#find a space in the string (\s)
match = re.search(r"\s", my_string)
print(match)

#to view match use:
match.group()

##find numeric characters (\d)
match = re.search(r"\d", my_string)
print(match)

#to know whether a pattern was matched, use if
MyStr = "an example"

#find the first word
match = re.search(r"\w*\s", MyStr)
if match:
    print("found a match:", match.group())
else:
    print("did not find a match")

match = re.search(r"2", "it takes 2 to tango")
match.group()

match = re.search(r"\d", "it takes 2 to tango")
match.group()

match = re.search(r"\d.*", "it takes 2 to tango")
match.group()

match = re.search(r"\s\w{1,3}\s", "once upon a time")
match.group()

match = re.search(r"\s\w*$", "once upon a time")
match.group()

#directly append group to result
re.search(r"\w*\s\d.*\d", "take 2 grams of H20"). group()

re.search(r"^\w*.*\s", "once upon a time"), group()

#*, +, {} are all "greedy" - they repeat the previous regex
#as many times possible
#this may result in matching more text that you want!

#to make it non-greedy use ?
re.search(r"^\w*.*?\s", "once upon a time").group()

#with an HTML tag:
re.search(r'<.+>', 'This is a <EM>first</EM> test').group()

re.search(r'<.+?>', 'This is a <EM>first</EM> test').group()

re.search(r'\d*\.?\d*','1432.75+60.22i').group()

re.search(r'[AGTC]+', 'the sequence ATTCGT').group()

re.search(r'\s+[A-Z]\w+\s*\w+', "The bird-shit frog's name is Theloderma asper.").group()

#finding email addresses in a string
#e.g. find academic name, email and research area
MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+",MyStr)
match.group()

MyStr = 'Samraat Pawar, s-pawar@imperial.ac.uk, Systems biology and ecological theory'

#does not match!
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s&]+",MyStr)
match.group()

#make the email regex more robust
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s&]+",MyStr)
match.group()

#yay
