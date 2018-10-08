#!/bin/bash
# Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
# Script: tabtocsv.sh
# Desc: substitute the tabs in the files with commas
# saves the output into a .csv file
# Arguments: 1-> tab delimited file
# Date: Oct 2018

echo "Creating a comma delimited version of $1 ..."
echo $0 #go to script
echo $1 #file
echo $2 #another random argument e.g.
cat $1 | tr -s "\t" "," >> $1.csv
# | send this argument to the next (pipe)
# > one arrow = make brand new file
# >> two arrows = replace old file with a new one
echo "Done!"
exit
