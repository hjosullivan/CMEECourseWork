####################
## Pre-allocation ##
####################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: boilerplate.R
## Desc: Introduction to writing R functions
## Date: October 2018

#clean environment
rm(list = ls())

#function 1 (loop)
a <- NA
for (i in 1:100000) {
  a <- c(a, i)
}
print(a)


#function 2 (pre-allocated vector)
a <- rep(NA, 1000000)

for (i in 1:1000000) {
  a[i] <- i
}
print(a)

system.time()