#!/usr/bin/env python
import subprocess

"""

Basic subprocess example

"""

#open and run Rscript
subprocess.Popen("/usr/bin/env Rscript --verbose TestR.R > \
../Results/TestR.Rout 2> ../Results/TestR_errFile.Rout",\
shell=True).wait()
