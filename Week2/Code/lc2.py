#!/usr/bin/env python3

"""

An exercise comparing the use of loops and
list comprehensions (part two).

"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "List Comprehension 2"
__version__ = "0.0.1"
__license__ = "I do not have one"

# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
raingreater100 = [i for i in rainfall if i[1] > 100]
print(raingreater100)

# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm.
rainless50 = [i for i in rainfall if i[1] < 50]
print(rainless50)


# (3) Now do (1) and (2) using conventional loops (you can choose to do
# this before 1 and 2 !).

#When rain was greater than 100mm
raingreater100 = []
for i in rainfall:
    if i[1] > 100:
        raingreater100.append(i)
print(raingreater100)

#When rain was less than 50mm
rainless50 = []
for i in rainfall:
    if i[1] < 50:
        rainless50.append(i)
print(rainless50)


# ANNOTATE WHAT EVERY BLOCK OR IF NECESSARY, LINE IS DOING!

# ALSO, PLEASE INCLUDE A DOCSTRING AT THE BEGINNING OF THIS FILE THAT
# SAYS WHAT THE SCRIPT DOES AND WHO THE AUTHOR IS
