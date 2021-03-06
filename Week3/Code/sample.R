###################
## sample script ##
###################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: sample.R
## Desc: A sampling example
## Date: October 2018


## run a simulation that involves sampling from a population

#clean environment
rm(list = ls())

#generate your population
x <- rnorm(50)
doit <- function(x){
  x <- sample(x, replace = TRUE)
  if(length(unique(x)) > 30) { #only take mean if sample was sufficient
    print(paste("Mean of this sample was:", as.character(mean(x))))
  } 
}

#run 100 iterations using vectorization:
result <- lapply(1:100, function(i) doit(x))

#or using a for loop:
result <- vector("list", 100) #Preallocate/Initialize
for(i in 1:100) {
  result[[i]] <- doit(x)
}