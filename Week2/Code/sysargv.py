#!/usr/bin/env python3

"""

Example system arguments

"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "System arguments"
__version__ = "0.0.1"
__license__ = "I do not have one"

import sys

print("This is the name of the script:", sys.argv[0])
print("Number of arguments: ", len(sys.argv))
print("The argumnts are:", str(sys.argv))
