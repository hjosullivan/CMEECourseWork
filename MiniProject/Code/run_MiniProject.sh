#!/bin/bash

# Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
# Script: run_MiniProject.sh
# Desc: simple shellscript to tie together the project
# Arguments: none
# Date: Feb 2019

# Run data wrangling Rscript
Rscript BT_datawrang.R

# Install python requirements
#pip install -r requirements.txt --no-index --find-links file:///tmp/packages

# Run NLLS fitting python script
python3 pipeline.py

# Run NLLS plotting Rscript
Rscript plotting.R

# Compile latex document
bash CompileLatex.sh WriteUp.tex
