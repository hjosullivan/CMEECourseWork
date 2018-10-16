#!/usr/bin/env python3

"""

Missing oaks problem: a fun foray in debugging!

This script excludes the header row in its seach for oaks
and write a new file containing the names of just oaks.

Output: JustOaksData.csv

"""

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
    """ Returns True if name starts with 'quercus'.

    >>> is_an_oak('Fagus sylvatica')
    False

    >>> is_an_oak('Quercus robur')
    True

    >>> is_an_oak('Quercuss robur')
    False

    >> is_an_oak('Robur quercus')
    False

    """
    return name.lower().split(' ')[0] == 'quercus'

def main(argv):
    """ Find oaks and create a new csv file with just oaks"""
    f = open('../Data/TestOaksData.csv','r') #open oaks csv
    g = open('../Results/JustOaksData.csv','w') #write oaks csv with just oaks
    taxa = csv.reader(f) #import as taxa

    filelines = [i for i in taxa]

    oaks_str = "\n".join(["".join(i) for i in filelines[1:] if is_an_oak(i[0])])
    header_str = " ".join(["".join(i.strip()) for i in filelines[0]])
    print("The following are oaks:\n{}".format(oaks_str))
    g.write("{}\n{}".format(header_str, oaks_str))
    g.close()

if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod()
