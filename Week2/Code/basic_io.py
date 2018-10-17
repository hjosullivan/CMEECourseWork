#!/usr/bin/env python3

"""

A basic script to demonstrate input/output in python.

"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "basic_io"
__version__ = "0.0.1"
__license__ = "I do not have one"

################
## FILE INPUT ##
################

#Open a file for reading
f = open('../Sandbox/test.txt', 'r') # r indicates read
#Use "implicit" for loop:
#if the object is a file, python will cycle over the lines

for line in f:
    print(line)

# Close the file
f.close()

#Same example, skip blank lines
f = open('../Sandbox/test.txt', 'r')
for line in f:
    if len(line.strip()) > 0:
        print(line)

f.close()

#################
## FILE OUTPUT ##
#################

# Save the elements of a list to a file
list_to_save = range(100)

f = open('../Sandbox/testout.txt', 'w')
for i in list_to_save:
    f.write(str(i) + '\n') # Add new line at the end

f.close()

#####################
## STORING OBJECTS ##
#####################

# To save an object (even complex) for later use
my_dictionary = {"a key": 10, "another key": 11}
import pickle

f = open('../Sandbox/testp.p', 'wb')
# note the b: accept binary files
pickle.dump(my_dictionary, f)
f.close()

# Load data again
f = open('../Sandbox/testp.p', 'rb')
another_dictionary = pickle.load(f)
f.close()

print(another_dictionary)
