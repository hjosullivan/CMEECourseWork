#!/bin/bash

# Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
# Script: csvtospace.sh
# Desc: substitute the commas in files with spaces.
# saves the output into a .txt file
# Arguments: 1-> csv
# Date: Oct 2018


#bash csvtospace.sh ../Data/Temperatures/<filename>

#print what you are doing
echo "Creating a tab delimited version of $1 ..."

#remove .csv and replace with .txt
filename="${1//.csv/.txt}"

#remove commas, replace with spaces and
cat $1 | tr -s "," "\t" >> $filename

#use basename to get the filename without path
newname=$(basename $filename)

#move .txt to results directory
mv $filename ../Results/$newname

#tada
echo "Done!"

exit
