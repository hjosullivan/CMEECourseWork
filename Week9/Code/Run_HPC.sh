#!/usr/bin/env bash

# Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
# Script: Run_HPC.sh
# Desc: Script for running simulations on HPC
# Arguments: none
# Date: Nov 2018

#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R is about to run"
R --vanilla < $HOME/Code/Run_HPC.R
mv HJO17_* $HOME/Results
echo "R has finished running"
