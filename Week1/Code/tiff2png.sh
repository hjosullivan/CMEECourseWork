#!/bin/#!/

# Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
# Script: tiff2png.sh
# Desc: convert tiff to png
# Arguments: --
# Date: Oct 2018

for f in *.tif;
    do
        echo "Converting $f";
        convert "$f" "$(basename "$f".tif).jpg";
    done
