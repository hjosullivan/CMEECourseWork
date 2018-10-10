#!/bin/bash

# Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
# Script: ConcateTwoFiles.sh
# Desc: Merging two files
# Arguments: --
# Date: Oct 2018

cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3
