#!/usr/bin/env python3

"""

A python script to calculate tree height.

Takes input from an external file and saves tree heights to a new
file.

Output: filename_TreeHeight.txt

"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "Get Tree Heights"
__version__ = "0.0.1"
__license__ = "I do not have one"

#should run using:
#$python get_TreeHeight.py Trees.csv/arg1

#function to caluclate tree heights
#uses distance from base of tree and angle to the top
#trigonometric formula
#height = distance * tan(radians)

#ARGUMENTS
#degrees: The angle of elevation of tree
#distance: The distance from the base of tree (e.g. meters)

#OUTPUT
#The heights of the tree, same units as "distance"

#import useful modules
import sys
import numpy as np
import csv

def TreeHeight(degrees, distance):
    """Calculates tree heights
        Arguments:
        1. degrees: The angle of elevation of the tree
        2. distance: The distance from the base of the tree in meters
        Outputs:
        Tree heights, same units as distance"""
    radians = degrees * np.pi/180
    height = distance * np.tan(radians)
    return(height)


#set default arguments using trees.csvfiles
if len(sys.argv) == 1:
    Trees = "../Data/trees.csv"
    print("No arguments provided, using default.")
elif len(sys.argv) == 2:
    Trees = sys.argv[1]
    print("Calculating tree heights")

#open file
f = open(Trees, 'r')
csvread = csv.reader(f)
csvdata = [i for i in csvread]
c = 0
for i in csvdata:
    c += 1
    if c == 1:
        i.append("Height.m")
        continue
    species = i[0]
    distance = float(i[1])
    degrees = float(i[2])
    height = TreeHeight(distance, degrees)
    i.append(height)
print(csvdata)

outpath ="../Results/{}_treeheights.csv".format(Trees.split("/")[-1].replace(".csv", ""))
with open(outpath,'w') as resultFile:
    wr = csv.writer(resultFile, dialect='excel')
    wr.writerows(csvdata)


#import pandas as pd
# read csv file in
#df = pd.read_csv(Trees)
# make a new column for tree height and vectorize the function TreeHeight
#df["Height.m"] = TreeHeight(degrees=df["Angle.degrees"], distance=df["Distance.m"])
# set path you want to save to
#outpath ="../Results/{}_treeheights.csv".format(Trees.split("/")[-1].replace(".csv", ""))
# write file to csv
#df.to_csv(outpath, index=False)
