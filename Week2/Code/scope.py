#!/usr/bin/env python3

"""

An example script to demonstrate usage of global
and local variables in python

"""

## Try this first

_a_global = 10

def a_function():
    """ print global/local variables """
    _a_global = 5
    _a_local = 4
    print "Inside the function, the value is ", _a_global
    print "Inside the function, the value is ", _a_local
    return None

a_function()

print "Outside the function, the value is", _a_global

## Now this

_a_global = 10

def a_function():
    """ print whether a variable is local or global"""
    global _a_global
    _a_global = 5
    _a_local_ = 4
    print "Inside the function, the value is ", _a_global
    print "Inside the function, the value is ", _a_local
    return None

    a_function()
    print "Outside the function, the value is ", _a_global
