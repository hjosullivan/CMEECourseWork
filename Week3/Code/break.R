###########################
## Breaking out of loops ##
###########################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: break.R
## Desc: Breaking out of loops
## Date: October 2018

#sometimes it is useful to break out of a loop when some condition is met.
#use break in situations when you cannot set a target number of iterations.

#clear environment
rm(list = ls())

i <- 0 #initialize i
    while(i < Inf){
      if (i == 20){
        break} #break freeeeee
      else {
        cat("i equals ", i, " \n"
)
        i <- i + 1 #update i
      }
    }