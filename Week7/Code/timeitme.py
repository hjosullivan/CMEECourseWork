#!/usr/bin/env python3

"""

Quick profiling with timeit

"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "Profileme2"
__version__ = "0.0.1"
__date__ = "November 2018"
__license__ = "I do not have one"

#Loops vs. list comprehensions

iters = 1000000

import timeit

from profileme import my_squares as my_squares_loops

from profileme2 import my_squares as my_squares_lc

#%timeit my_squares_loops(iters)
#%timeit my_squares_lc(iters)

#Loops vs. join method for strings

from profileme import my_join as my_join_join

from profileme2 import my_join as my_join

#%timeit(my_join_join(iters, mystring))
#%timeit(my_join(iters,mystring))

#can also time functions like this:

import time

start = time.time()
my_squares_loops(iters)
print("my_squares_loops takes %f s to run." %
(time.time() - start))

start = time.time()
my_squares_lc(iters)
print("my_squares_lc takes %f s to run." %
(time.time() - start))
