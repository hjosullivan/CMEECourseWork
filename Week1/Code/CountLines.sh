#!/bin/bash

# Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
# Script: CountLines/sh
# Desc: count the number of lines in a file
# Arguments: none
# Date: Oct 2018

#count the number of lines
NumLines=`wc -l < $1`

#print number of lines
echo "The file $1 has $NumLines lines"
echo
