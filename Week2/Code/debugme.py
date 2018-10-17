#!/usr/bin/env python3

"""

Introduction to debugging using pdb

"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "debugme"
__version__ = "0.0.1"
__license__ = "I do not have one"

#A simple debugging function
def createabug(x):
    y = x**4
    z = 0.0
    y = y/z
    return y
createabug(25)

#Alternatively if you anticipate a bug...
#def createabug1(x):
#    y = x**4
#    z = 0.
#    import pdb; pdb.set_trace()
#    y = y/z
#    return y
#createabug2(25)

#Or..

#def createabug2(x):
#    y = x**4
#    z = 0.
#    if x = 2
#        import pdb; pdb.set_trace()
#    y = y/z
#    return y
#createabug2(25)

# Some notes:

# ipython run -d will start a debugging session from the first line of code
# You can also debug using an IDE like Spyder of PyCharm
