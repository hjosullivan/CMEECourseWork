#!/usr/bin/env python3

"""Missing oaks problem: exemplyfying the use of debugging"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "Oaks Debug me"
__version__ = "0.0.1"
__license__ = "I do not have one"

#import useful modules
import csv
import sys
import doctest #import the doctest module

#PROBLEM: does not find oaks!
#first insert a debugging breakpoint
#then use doctest to to find other bugs

#PROBLEM:
#also lists header as genus and species in the program
#modify the script to remove header
#include column headers in output file. "genus" and "species"

#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus'.

    >>> is_an_oak('Fagus sylvatica')
    False

    >>> is_an_oak('Quercus robur')
    True

    >>> is_an_oak('Quercuss robur')
    False

    >> is_an_oak('Robur quercus')
    False

    >>> is_an_oak(' Quercus robur')
    True

    """
    return name.lower().startswith('quercus')

def main(argv):
    f = open('../data/TestOaksData.csv','r') #open oaks csv
    g = open('../data/JustOaksData.csv','w') #write oaks csv with just oaks
    taxa = csv.reader(f) #import as taxa
    csvwrite = csv.writer(g) #export
    oaks = set() #create an expty set
    for row in taxa: #for each row in taxa
        print(row) #print that row
        print ("The genus is: ") #also print this bit
        print(row[0] + '\n') #plus new line
        if is_an_oak(row[0]): #if an oak is found
            print('FOUND AN OAK!\n') #also print FOUND AN OAK!
            csvwrite.writerow([row[0], row[1]]) #export


    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod()
