#!/usr/bin/env python3

"""

A python script to exemplify profiling
alongside profileme2.py

"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "Profileme"
__version__ = "0.0.1"
__date__ = "November 2018"
__license__ = "I do not have one"

def my_squares(iters):
    """ Squares the values in a list"""
    out = [] #list
    for i in range(iters): #loop is expensive
        out.append(i**2)
    return out

def my_join(iters, string):
    """ build a massive string """
    out = " " #a string
    for i in range(iters):
        out += string.join(", ") #expensive to use .join
    return out

def run_my_funcs(x,y):
    """ run functions """
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000, "My string")
