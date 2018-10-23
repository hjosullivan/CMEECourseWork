##########################################
## Skip to the next iteration of a loop ##
##########################################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: next.R
## Desc: Skipping to the next iteration of a loop
## Date: October 2018

#both next and {\tt break} can be used within other loops

#clear environment
rm(list = ls())

#next example
for (i in 1:10) {
  if ((i %% 2) == 0)
    next #pass to the next iteration
  print(i)
}