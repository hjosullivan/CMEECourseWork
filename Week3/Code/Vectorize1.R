#################
## Vectorize 1 ##
#################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: Vectorize1.R
## Desc: An exercise in vectorization
## Date: October 2018

#clear environment
rm(list = ls())

M <- matrix(runif(1000000),1000,1000)

SumAllElements <- function(M){
  Dimensions <- dim(M)
  Tot <- 0
  for (i in 1:Dimensions[1]){
    for (j in 1:Dimensions[2]){
      Tot <- Tot + M[i,j]
    }
  }
  return (Tot)
}

# Time this function
# Start the clock!
start_time <- as.numeric(proc.time()[3])

# Run function... tick tock
total <- (SumAllElements(M)) 

# Stop the clock!
end_time <- as.numeric(proc.time()[3])

# Get the elapsed time
elapsed_time <- end_time - start_time 

# Print the elapsed time. 
sprintf("The sum of all elements takes %ss to run.", round(elapsed_time, digits = 3))


