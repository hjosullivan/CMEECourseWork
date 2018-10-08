#!/bin/bash
# Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
# Script: csvtospace.sh
# Desc: substitute the commas in files with spaces.
# saves the output into a .txt file
# Arguments: 1-> txt
# Date: Oct 2018

#loops through all files in temperature

echo "Creating a tab delimited version of $1 ..."
filename="${1//.csv/.txt}"
cat $1 | tr -s "," "\t" >> $filename
echo "Done!"
exit
