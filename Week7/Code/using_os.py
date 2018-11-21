#!/usr/bin/env python3

"""

Using OS practical

"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "Using os practical"
__version__ = "0.0.1"
__date__ = "November 2018"
__license__ = "I do not have one"

# Hint: look in subprocess.os and/or subprocess.os.path and/or
# subprocess.os.walk for helpful functions

#import modules
import subprocess
import re

#################################
# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Use the subprocess.os module to get a list of files and  directories
# in your ubuntu home directory

# Use a for loop to walk through the home directory.
allfiles = []
for(dir, subdir, files) in subprocess.os.walk(home):
    for i in subdir + files:
        allfiles += re.findall(r"\w*", i)
print("Number of directories and files in home directory:")
print(len(allfiles))
allfiles

# Get files and directories in your home/ that start with an
# upper case 'C'
Cfiles = []
for(dir, subdir, files) in subprocess.os.walk(home):
    for i in subdir + files:
        Cfiles += re.findall(r"^C\w*", i)
print("Number of directories and files in home directory starting with C:")
print(len(Cfiles))
Cfiles

#################################
# Get files and directories in your home/ that start with either an
# upper or lower case 'C'

Ccfiles = []
for(dir, subdir, files) in subprocess.os.walk(home):
    for i in subdir + files:
        Ccfiles += re.findall(r"^[Cc]\w*", i)
print("Number of directories and files in home directory starting with C or c:")
print(len(Ccfiles))
Ccfiles

#################################
# Get only directories in your home/ that start with either an upper or
#~lower case 'C'

GetCDirfiles = []
for(dir, subdir, files) in subprocess.os.walk(home):
    for i in subdir:
        GetCDirfiles += re.findall(r"^[Cc]\w*", i)
print("Number of directories in home directory starting with C or c:")
print(len(GetCDirfiles))
GetCDirfiles
