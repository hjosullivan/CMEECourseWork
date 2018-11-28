##########################################
## High Performance Computing Exercises ##
##########################################

# Author: Hannah O'Sullivan
# Script: hjo17.R
# Date: November 18
# Version: 0.1

###############################
## Neutral Theory Simulation ##
###############################

# Store the state of simulated system as a vector of individuals called "Community".
# Each entry in the vector is a number that tells you the species of the individual
# in that position. 

#clear environment
rm(list = ls())

## Question 1

# Define function for species richness
species_richness <- function(community){
  return(length(unique(community)))
}

# Test community
c1 <- (c(1,4,4,5,1,6,1))
species_richness(c1)
#4 yay

## Question 2

# Write a function "initilaise_max(size)" to generate initial state for simulation community
# With maximum possible number of speces for community size given by input number "size"

# Define function to initialise maximum community size
initialise_max <- function(size){
  max_size = seq(from = 1, to = size, by = 1)
  return(max_size)
}

# test initialise max
initialise_max(16)

## Question 3

# Consider the effect of the initial condition
# Write another function "initialise_min(size)" to generate an alternative initial state
# with the minimum possible number of species
# (this is monodominance of one species with the total number of individuals given by input size).
# Returns a vector e.g. (1,1,1,1)

# Define function to initialise minimum community size
initialise_min <- function(size){
  min_size <- rep(1, size)
  return(min_size)
}

# Test initialise_min(size)
initialise_min(4)

## Question 4

# Write a function "choose_two(x)"
# First choose a random number according to a uniform distribution between 1 and x (inclusive of
# endpoints).
# Also choose a second random number betwee 1 and x (inclusive of endpoints). 
# The second number should not equal be to the first number!!!
# Returns a vector of length 2.

# Define function to choose two random numbers between 1 and x.
choose_two <- function(x){
  return(sample(x, 2, replace = FALSE))
}

# Test choose_two(x)
choose_two(4)

## Question 5

# Write a function "neutral_step(community)" to perform a single step of a simple neutral model.
# Without speciation on a community vector.
# Pick an individual to die and another to reproduce - fill the gap left by the death!
# They should not be the same individual (could be the same species)
# E.g. neutral_step(c(10,5,13))
# Returns a random community state such as {5 5 13}

# Define function
neutral_step <- function(community){
  choose <- choose_two(length(community))
  community[choose[1]] <- community[choose[2]]
  #fill_gap <- replace(community, choose, community[choose[2]])
  return(community)
}

# Test neutral_step(community)
neutral_step(c(10,5,13))

## Question 6

# Write a function "neutral_generation(community)" to simulate SEVERAL neutral steps on a community.
# For one generation.
# If the community consists of x individuals, x/2 individual neutral steps = complete generation.
# One generation is the time expected between birth and reproduction.

# E.g. With 10 individuals in a system, 5 neutral steps = 5 births and 5 deaths
# Returns a vector giving the state of the community after a generation has passed.

# Define function
neutral_generation <- function(community){
  generation <- ceiling(length(community)/2)
  for (i in 1:generation){
    community <- neutral_step(community)
  }
  
  return(community)
}

# Test neutral_generation(community)
neutral_generation(c(10,5,13))

## Question 7 

# Write a function "neutral_time_series(inital, duration)" for a neutral theory simulation
# to return a time series of species richness in the system.
# The function should have two inputs:
# INITIAL: The inital condition community vector (also determines simulation size).
# DURATION: The number of generations that you want to run the simulation for.

#Define function
neutral_time_series <- function(initial, duration){
  time_series <- rep.int(0, duration +1)
  time_series[1] <- species_richness(initial)
  for (i in 1:duration){
    initial <- neutral_generation(community = initial)
    time_series[(i + 1)] <- species_richness(initial)
  }
  
  return(time_series)
}

# Test function
neutral_time_series(initial = initialise_max(7), duration = 20)


## Question 8

# Plot a time series graph of the neutral model simulation
# Max diversity: 100 individuals
# Run for 200 generations


#run neutral time series for 100 individuals over 200 generations
plot_ts <- neutral_time_series(initial = initialise_max(100), duration = 200)

plot(plot_ts, 
     xlab = "Generations", ylab = "Community Size",
     main = "Neutral Time Series",
     col = "Blue")

# What state will the sustem always converge to if you wait long enough?
# Why is this?

## Question 9

# Write a new function "neutral_step_speciation(community, v)"
# Performs a step of a neutral model including speciation!
# In each time step, speciation will replace a dead individual with a new species
# (with a probability of v).
# Otherwise the dead individual is replaced with the offspring of another individual as
# before in "neutral_step".

# Leave speciation rate (v) as a parameter in the function. 
# Define function
neutral_step_speciation <- function(community, nu){
  choose <- choose_two(length(community))
  probability <- runif(1)
  if (probability <= nu){
    speciation <- max(community) +1
    community[choose[1]] <- speciation
    #print("speciation!")
  }
  else{
    community[choose[1]] <- community[choose[2]]
    #print("neutral step!")
    
  }
  
  return(community)
}

# Test function
neutral_step_speciation(c(4,7,13,8), 0.2)

## Question 10

# Make a new function "neutral_generation_speciation(community,nu)"
# This uses a neutral simulation with speciation but otherwise is the same as neutral
# generation.
# Advance by one generation according to the rules of the model.
# Inputs:
# INITAL: Inital community vector
# NU: Speciation rate

# Returns the state of the community at the end of the generation.

# Define function
neutral_generation_speciation <- function(community, nu){
  generation <- ceiling(length(community)/2)
  for (i in 1:generation){
    community <- neutral_step_speciation(community, nu)
  }
  
  return(community)
}

# Test function
neutral_generation_speciation(c(4,7,13,8), 0.2)

## Question 11

# Make a new function "neutral_time_series_speciation(community, nu, duration)"
# Uses neutral simulation with speciation but otherwise is the same as neutral
# time series.
# Inputs:
# INITAL: Inital community vector
# NU: Speciation rate
# DURATION: Number of generations

# Returns the state of the community at the last generation.

#Define function
neutral_time_series_speciation <- function(community, nu, duration){
  time_series <- rep.int(0, duration +1)
  time_series[1] <- species_richness(community)
  for (i in 1:duration){
    community <- neutral_generation_speciation(community, nu)
    time_series[(i + 1)] <- species_richness(community)
  }
  
  return(time_series)
}

# Test function
neutral_time_series_speciation(community = c1, nu = 0.2, duration = 20)

## Question 12

ntss_sim1 <- neutral_time_series_speciation(community = initialise_min(100), nu = 0.1, duration = 200)

ntss_sim2 <- neutral_time_series_speciation(community = initialise_max(100), nu = 0.1, duration = 200)

plot(ntss_sim1, 
     xlab = "Generations", ylab = "Community Size",
     xlim = c(0, 200), ylim = c(0, 100),
     main = "Neutral Time Series with Speciation",
     col = "Blue")
points(ntss_sim2, 
     col = "Red")
legend("topright", title="Initial Conditions",
       c("Minimum","Maximum"), fill = c("Blue", "Red"))

## Question 13

# Study the species abundance distribution of the neutral simulations.
# First write a function called "species_abundance" to get the abundances of all
# species in the system from an input of the community vector.

# E.g. species_abundance(c(1, 5, 3, 6, 5, 6, 1, 1))
# Returns 3 2 2 1 (in that order decreasing)

# Define function
species_abundance <- function(community){
  abundance <- table(community)
  abundance <- as.vector(abundance)
  sort(abundance, decreasing = TRUE)
  return(abundance)
}

# Test function
species_abundance(c(1, 5, 3, 6, 5, 6, 1, 1))
species_abundance(c(1,1,1,1,1,2,2,2,2,3,3,3,4,4,5))

## Questions 14

# Write a function "octaves" to bin the abundances of species into "octave classes"
# The first value of the returned vector will give the species with an abundance of 1.
# The second will give the numer of species with an abundance of 2, 3 etc.
# In general, the nth value will give 

#Define function
octaves <- function(abundance){
  abundance_log <- log2(abundance)
  floor_abundance <- floor(abundance_log) +1 # plus one because R does not index from 0
  bins <- tabulate(floor_abundance)
  return(bins)
}

# Test function
octaves(c(100,64,63,5,4,3,2,2,1,1,1,1))

## Question 15

# Write a function "sum_vect(x, y)" which accepts two vectors as inputs, x and y and
# returns their sums after fillinf whichever of the vectors is shorter with zeros.
# E.g. sum_vect(c(1,3), c(1,0,5,2))
# Returns 2,3,5,2

# Define function
sum_vect <- function(x,y){
  if (length(x) < length(y)) {
    xydif <- (length(y) - length(x))
    x <- append(x, rep.int(0, xydif), after = length(x))
  } else if (length(x) > length(y)){
    xydif <- (length(x) - length(y))
    y <- append(y, rep.int(0, xydif), after = length(y))
  }
  return(x + y)
}

# Test function
sum_vect(c(1,3,2,6,4), c(1,2,3))
sum_vect(c(1,2,3), c(1,3,2,6,4))
sum_vect(c(1,1,1,1,3,2,5,6,3), c(1,5,3))

## Question 16

# Run a neutral model simulation using the same parameters as Q12 for a "burn in"period
# of 200 generations.
# Next, record the species abundance octave vector.
# Then repeatedly continue the simulation from where you left off for 2000 generations,
# and record species abundance octave for ever 20 generations.

# Define function
question_16 <- function(){
  #define initial conditions for burn in
  community <- initialise_max(100)
  for(i in 1:200){
    community <- neutral_generation_speciation(community = community, nu = 0.1)
  }
    burn_abundance <- species_abundance(community)
    burn_bins <- octaves(burn_abundance)
    x <- c()
    bin_size <- c()
  for(j in 1:2000){
    community <- neutral_generation_speciation(community = community, nu = 0.1)
    if ((j %% 20) == 0) {
      abundance_20 <- species_abundance(community)
      bins_20 <- octaves(abundance_20)
      x <- sum_vect(x, bins_20)
      bin_size <- append(bin_size, length(bins_20))
    }
    
  }
    
  x <- (x/101)
  bin_names <- unlist(lapply(seq(1:max(bin_size)), function(n) paste(2^(n-1), "-", 2^n -1)))
  bin_names[1] <- "1"
  barplot(x, names.arg = bin_names,
          main = "Some title",
          xlab = "Octaves",
          ylab = "Abundance") 
  return(x)
}

# Test function
question_16()

## REMEMBER TO DO EXTRA CREDITS



