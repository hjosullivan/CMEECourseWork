####################
## Pre-allocation ##
####################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: preallocate.R
## Desc: Introduction to preallocation
## Date: October 2018

#clean environment
rm(list = ls())

#first
#a <- NA
#for (i in 1:100000) {
#  a <- c(a, i)
#}
#print(a)

#function 1
a <- NA
myfunc1 <- function(a) {
  for(i in 1:100000) {
    a <- c(a, i)
  }
print(a)
}

myfunc1(a)
print(system.time(myfunc1(a)))

#second
#a <- rep(NA, 1000000)

#for (i in 1:1000000) {
#  a[i] <- i
#}
#print(a)

#function 2
b <- rep(NA, 100000)
myfunc2 <- function(b) {
  for (i in 1:100000) {
    b[i] <- i
  }
print(b)
}
myfunc2(b)
print(system.time(myfunc2(b)))

