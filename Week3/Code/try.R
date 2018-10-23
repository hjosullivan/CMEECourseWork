#####################
## Catching errors ##
#####################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: try.R
## Desc: Catching errors with "try"
## Date: October 2018


#Modify sample.R
#"catch" bugs using try function
#run a simulation that involves sampling from a population

#clean environment
rm(list = ls())

x <- rnorm(50) #Generate your population
doit <- function(x){
  x <- sample(x, replace = TRUE)
  if(length(unique(x)) > 30) {#only take mean if sample was sufficient
    print(paste("Mean of this sample was:", as.character(mean(x))))
  } 
  else {
    stop("Couldn't calculate mean: too few unique points!")
  }
}

## Try using "try" with vectorization:
result <- lapply(1:100, function(i) try(doit(x), FALSE))

## Or using a for loop:
result <- vector("list", 100) #Preallocate/Initialize
for(i in 1:100) {
  result[[i]] <- try(doit(x), FALSE)
}
