#############
## Apply 1 ##
#############

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: apply1.R
## Desc: Applying functions to rows/columns
## Date: October 2018


## apply: applying the same function to rows/colums of a matrix

#clear environment
rm(list = ls())

## Build a random matrix
M <- matrix(rnorm(100), 10, 10)

## Take the mean of each row
RowMeans <- apply(M, 1, mean)
print (RowMeans)

## Now the variance
RowVars <- apply(M, 1, var)
print (RowVars)

## By column
ColMeans <- apply(M, 2, mean)
print (ColMeans)
