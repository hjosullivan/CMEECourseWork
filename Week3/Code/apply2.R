#############
## Apply 2 ##
#############

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: apply2.R
## Desc: Using apply to define functions
## Date: October 2018

#clear environment
rm(list = ls())

SomeOperation <- function(v){ # (What does this function do?)
  if (sum(v) > 0){
    return (v * 100)
  }
  return (v)
}

M <- matrix(rnorm(100), 10, 10)
print (apply(M, 1, SomeOperation))