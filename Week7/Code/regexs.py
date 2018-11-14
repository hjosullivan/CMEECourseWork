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
