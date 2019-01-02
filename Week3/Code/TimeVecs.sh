#!/bin/bash

# Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
# Script: TimeVecs.sh
# Desc: Times all Vectorize scripts from R and Python
# Arguments: none
# Date: Dec 2018

# Prints the elapsed time of each function to the
# terminal console.

echo "Timing Vectorize1.R..."
Rscript Vectorize1.R

echo "Timing Vectorize1.py..."
python Vectorize1.py

echo "Timing Vectorize2.R..."
Rscript Vectorize2.R

echo "Timing Vectorize2.py..."
python Vectorize2.py
