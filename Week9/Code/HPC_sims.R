##########################################
## High Performance Computing Exercises ##
##########################################

# Author: Hannah O'Sullivan
# Script: HJO17.R
# Date: November 18
# Version: 0.1

###########################
## Simulations using HPC ##
###########################

# Run larger simulation similar to "question_16" with more repeat readings.
# This will require use of HPC and adapted R code.

# Clear environment
rm(list = ls())
# Turn off graphics
graphics.off()

# necessary functions:

## CHOOSE TWO
# Define function.
choose_two <- function(x){
  return(sample(x, 2, replace = FALSE))
}

## NEUTRAL STEP SPECIATION
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

## NEUTRAL GENERATION SPECIATION
# Define function
neutral_generation_speciation <- function(community, nu){
  generation <- ceiling(length(community)/2)
  for (i in 1:generation){
    community <- neutral_step_speciation(community, nu)
  }
  
  return(community)
}

## SPECIES RICHNESS
# Define function for species richness
species_richness <- function(community){
  return(length(unique(community)))
}

## SPECIES ABUNDANCE
# Define function
species_abundance <- function(community){
  abundance <- table(community)
  abundance <- as.vector(abundance)
  sort(abundance, decreasing = TRUE)
  return(abundance)
}

## OCTAVES
#Define function
octaves <- function(abundance){
  abundance_log <- log2(abundance)
  floor_abundance <- floor(abundance_log) +1 # plus one because R does not index from 0
  bins <- tabulate(floor_abundance)
  return(bins)
}

## INITIALISE MIN
# Define function to initialise minimum community size
initialise_min <- function(size){
  min_size <- rep(1, size)
  return(min_size)
}

## Question 17

# Create a function "cluster_run" to accept 7 input parameters:
# SPECIATION_RATE:
# SIZE:
# WALL_TIME:
# INTERVAL_RICH:
# INTERVAL_OCT:
# BURN_IN_GENERATIONS:
# OUTPUT_FILE_NAME: 

# Define function
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct,
                        burn_in_generations, output_file_name){
  wall_time <- wall_time * 60 # convert to minutes
  elapsed_time <- 0 
  start_time <- as.numeric(proc.time()[3]) # set start time
  counter <- 0 # being counter
  community <- initialise_min(size)
  srichness <- c() # empty vector to store species richness
  soctaves <- c() # empty vector to store octaves
  while (elapsed_time < wall_time){
    counter <- counter + 1 # add for each iteration
    community <- neutral_generation_speciation(community, speciation_rate)
    #when counter = burn in generations and counter = interval rich modulus
    if((counter <= burn_in_generations) && (counter %% interval_rich == 0)){
      srichness <- append(srichness, (species_richness(community)))
    }
    if(counter %% interval_oct == 0){
      soctaves <- append(soctaves, list(octaves(species_abundance(community))))
    }
    end_time <- as.numeric(proc.time()[3]) # end time
    elapsed_time <- end_time - start_time
  }
  
  #save as RDA file
  save(srichness, 
       soctaves,
       community,
       elapsed_time,
       #input parameters
       speciation_rate,
       size,
       wall_time,
       interval_rich,
       interval_oct,
       burn_in_generations,
       file = output_file_name)
  return(0)
}

#check RData file
#load(file="DataFile.RDA")

####################
## Running on HPC ##
####################

## First read in the job number from the cluster

# A function to check whether to test locally or run on the cluster
# If running on the cluser "iter" will be input by job number.
# Otherwise a random "iter" it generated to test code locally.

iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX")) # cluster iter
run_time <- 11.5 * 60 # to set 11.5 hours for cluster
if(is.na(iter)){
    iter <- sample(100, 1) # generate a random number
    run_time <- 11.5 # 11.5 minutes to run locally
}

## Set seed

# Control the rndom number seed so each parallel simulation takes place
# with a different seed.
# If two simulations run with the same seed the answer will be identical.

set.seed(iter)

## Define community size(J)

J <- c(5000, 1000, 2500, 500)
J <- J[iter %% 4 +1]


## Run cluster_run!!!

# If running locally go and make yourself a cup of tea.
# If running for 11.5 hours on the cluster, go to bed. 

# (Speciation rate specified for yours truly)
cluster_run(speciation_rate = 0.00585, size = J, wall_time = run_time, 
            interval_rich = 1, interval_oct = J/10, burn_in_generations = 8*J, 
            output_file_name = paste("HJO17_", as.character(iter),".RDA", sep = ""))


