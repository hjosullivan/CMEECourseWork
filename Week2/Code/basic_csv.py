#!/usr/bin/env python3

"""

An exercise in manipulating csv files with the csv
package.

"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "basic_csv"
__version__ = "0.0.1"
__license__ = "I do not have one"

import csv

# Read a file containing:
# 'Species', 'Intraorder', 'Family', 'Distribution', 'Body mass male(Kg)'

f = open('../Data/testcsv.csv', 'r')

csvread = csv.reader(f)
temp = []
for row in csvread:
    temp.append(tuple(row))
    print(row)
    print("The species is", row[0])

f.close()

# Write a file containing only species name and body mass
f = open('../Data/testcsv.csv', 'r')
g = open('../Results/bodymass.csv', 'w')

csvread = csv.reader(f)
csvwrite = csv.writer(g)
for row in csvread:
    print(row)
    csvwrite.writerow([row[0], row[4]])

f.close()
g.close()
