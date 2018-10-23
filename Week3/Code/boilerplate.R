##########################
## A boilerplate script ##
##########################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: boilerplate.R
## Desc: Introduction to writing R functions
## Date: October 2018

#clean environment
rm(list = ls())

MyFunction <- function(Arg1, Arg2){
  #statements involving Arg1, Arg2:
  print(paste("Argument", as.character(
    Arg1), "is a", class(Arg1)))
  #print Arg1 type
  print(paste("Argument", as.character(
    Arg2), "is a", class(Arg2)))
  #print Arg2 type
  
  return(c(Arg1, Arg2))
}

#Test the function
MyFunction(1, 2)
# numeric

MyFunction("Riki", "Tiki")
#character
