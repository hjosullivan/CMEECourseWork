#################
## Vectorize 2 ##
#################

## Author: Hannah O'Sullivan
## Script: Vectorize2.R
## Desc: Vectorization practical
## Date: October 2018


# Runs the stochastic (with gaussian fluctuations) Ricker Eqn.

# Clear environment
rm(list=ls())

# Original

#stochrick<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
#{
#  # Initialize
#  N<-matrix(NA,numyears,length(p0))
#  N[1,]<-p0
#  
#  for (pop in 1:length(p0)) # Loop through the populations
#  {
#    for (yr in 2:numyears) # For each pop, loop through the years
#    {
#      N[yr,pop]<-N[yr-1,pop]*exp(r*(1-N[yr-1,pop]/K)+rnorm(1,0,sigma))
#    }
#  }
# return(N)

#}


# Now write another function called stochrickvect that vectorizes the above 
# to the extent possible, with improved performance: 

# Remove outer loop and edit indexing.
stochrickvect<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  # Initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  
    for (yr in 2:numyears) # For each pop, loop through the years
    {
      N[yr,]<-N[yr-1,]*exp(r*(1-N[yr-1,]/K)+rnorm(length(p0),0,sigma))
    }
  return(N)
  
}


# Time the vectorized function

# Start the clock!
start_time <- as.numeric(proc.time()[3])

# Run function... tick tock
total <- (stochrickvect()) 

# Stop the clock!
end_time <- as.numeric(proc.time()[3])

# Get the elapsed time
elapsed_time <- end_time - start_time 

# Print the elapsed time. 
sprintf("The vectorized Richer equation takes %ss to run.", round(elapsed_time, digits = 3))

