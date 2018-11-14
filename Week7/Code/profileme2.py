#!/usr/bin/env python3

"""

A python script that halves the time taken to
compute profileme.py

"""

def my_squares(iters):
    """ Squares the values in a list """
    out = [i ** 2 for i in range(iters)] #replace loop with lc
    return out

def my_join(iters, string):
    """ Build a string the length of iters"""
    out = " " #a string
    for i in range(iters):
        out += ", " + string #concatenate
    return out

def run_my_funcs(x,y):
    """ Run functions """
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

#run with arbitrary values
run_my_funcs(10000000, "My string")
