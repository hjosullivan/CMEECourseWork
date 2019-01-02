#!/usr/bin/env python

"""

A python script to run fmr.R
using the subprocess module

"""

#import modules
import subprocess

#open and run Rscript
subprocess.Popen("/usr/bin/env Rscript --verbose fmr.R > \
../Results/fmr.Rout 2> ../Results/fmr_errFile.Rout",\
 shell=True).wait()
