#!/usr/bin/env python3

""" An exercise exemplifying the use of tuples. """

__author__ = 'Hannah O Sullivan (h.osullivan18@imperial.ac.uk)'
__appname__ = 'Control flow exercise 2'
__version__ = '0.0.1'
__license__ = "I do not have one"


birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# write a (short) script to print these on a separate line or output block by species
# Hints: use the "print" command! You can use list comprehension!
#print(birds)

#using a loop
#for i in birds:
#    print(i)

for i in birds:
    print("{} {} {}".format(i[0], i[1], i[-1]))






# ANNOTATE WHAT EVERY BLOCK OR IF NECESSARY, LINE IS DOING!

# ALSO, PLEASE INCLUDE A DOCSTRING AT THE BEGINNING OF THIS FILE THAT
# SAYS WHAT THE SCRIPT DOES AND WHO THE AUTHOR IS
