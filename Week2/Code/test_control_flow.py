#!/usr/bin/env python3

"""Some functions exemplifying the use
of control statements"""
# Docstrings are considered part of the running code
# (Normal comments are stripped).
# Hence you can access your docstrings at the run time.

__author__ = 'Hannah O Sullivan (h.osullivan18@imperial.ac.uk)'
__appname__ = 'Test Control Flow'
__version__ = '0.0.1'
__license__ = "I do not have one"

#import sys
import sys
import doctest #import the doctest module

#create new function "even or odd"
def even_or_odd(x = 0): # if not specified x should = 0
    """Find whether a number is even or odd

    >>> even_or_odd (10)
    '10 is Even!'

    >>> even_or_odd (5)
    '5 is Odd!'

    whenever a float is provided, the the closest integer is used:
    >>> even_or_odd (3.2)
    '3 is Odd!'

    in case of negative numbers, the positive is taken:
    >>> even_or_odd (-2)
    '-2 is Even!'

    """

    #Define function to be tested

    if x % 2 == 0: #The conditional if - an implicit loop
        return "%d is Even!" % x #%d formatting the number as a string
    return "%d is Odd!" % x


### suppress this block ###

# def main(argv):
        # print(even_or_odd(22))
        # print(even_or_odd(33))
        # print(largest_divisor_five(120))
        # print(largest_divisor_five(121))
        # print(is_prime(60))
        # print(is_prime(59))
        # print(find_all_primes(100))
        # return 0

# if (__name__ == "__main__"):
        # status = main(sys.argv)
        # sys.exit(status)
    ###

doctest.testmod()
