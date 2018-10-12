#!/usr/bin/env python3

"""Even more control flow fun! """

__author__ = 'Hannah O Sullivan (h.osullivan18@imperial.ac.uk)'
__appname__ = 'Control flow exercise 2'
__version__ = '0.0.1'
__license__ = "I do not have one"


#What does each of foo_x do?
#import sys
import sys

#an exponent
def foo_1(x):
    """ Solves x to the 0.5"""
    return x ** 0.5

#returns the greatest value out of x and y
def foo_2(x,y):
    """ Returns the greatest value between x and y"""
    if x > y:
        return x
    return y

#moves largest variable to the end of vector
def foo_3(x, y, z):
    """ Moves the largest variable to the end of the vector"""
    if x > y: #if x is greater than y
        tmp = y #create a temporary value for y
        y = x #tmp y = # x
        x = tmp #
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

# ???
def foo_4(x):
    """ I have no idea what this does """
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

#A recursive function that calculates factorial of x
def foo_5(x):
    """ A recurssive function to calculate a factorial of x"""
    if x == 1:
        return 1
    return x * foo_5(x - 1)

#Calculate the factorial of x in a different way
def foo_6(x=0):
    """ A none recurssive function to calculate a
        factorial of x """
    facto = 1
    while x >=1:
        facto = facto * x
        x = x - 1
    return facto


def main(argv):
        print(foo_1(22))
        print(foo_1(13))
        print(foo_2(5,9))
        print(foo_2(17,12))
        print(foo_3(15,3,6))
        print(foo_3(7,19,8))
        print(foo_4(5))
        print(foo_4(8))
        print(foo_5(6))
        print(foo_5(13))
        print(foo_6(4))
        print(foo_6(3))
        return 0

if (__name__ == "__main__"):
        status = main(sys.argv)
        sys.exit(status)
