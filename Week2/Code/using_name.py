#!/usr/bin/env python3

"""

A script to clarify the use of __name__ == __main__

"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "Using name"
__version__ = "0.0.1"
__license__ = "I do not have one"


if __name__ == '__main__':
    print ('This program is being run by itself')
else:
    print ('I am being imported from another module')
