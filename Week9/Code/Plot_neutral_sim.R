##########################################
## High Performance Computing Exercises ##
##########################################

# Author: Hannah O'Sullivan
# Script: Plot_neutral_sim.R
# Date: November 18
# Version: 0.1

########################
## Process HPC output ##
########################

## Read in and process HPC output files

# Provide 4 bar graphs in a multipanel graph.
# One for each simulation size.
# Each should show mean species abundance octave results from all
# simulations of that size. 
# Only use abundance octaves from after the burn in period. 


## Question 20

# Clear environment
rm(list = ls())
# Turn off graphics
graphics.off()

# Get a list of all RDA files 
file_list <- list.files(path = "../Data/", pattern ="*.RDA")

#load("../Data/HJO17_1.RDA")
# Define sum_vect function
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

# Define function "read_files"
# This function will read in RDA files and get average octaves for a given community size
read_files <- function(community_size){
  all_soctaves <- c() # create empty vector for sum_vect of all octaves
  total_vals <- 0 # set a counter
  # For each file in file_list:
  for (i in file_list) {
    load(paste0("../Data/", i)) # load RDA file
    if (community_size == size) {
      post_burn <- burn_in_generations/interval_oct # get post-burn period
      for(j in post_burn:length(soctaves)) { # for data after burn in:
        all_soctaves <- sum_vect(all_soctaves, soctaves[[j]]) # sum_vect each octave
        total_vals <- total_vals+1 # and add 1 to the counter
      }
    }
  }
  
  # Divide sum_vect of all octaves by the total vals 
  all_soctaves <- all_soctaves/total_vals
  
  return(all_soctaves)

}


size_500 <- read_files(500)
size_1000 <- read_files(1000)
size_2500 <- read_files(2500)
size_5000 <- read_files(5000)
print(size_5000)

# plot 
pdf("../Results/Q_20.pdf")
par(mfrow = c(2,2))
barplot(size_500, main = "Community size 500",
        xlab = "Species abundance octaves",
        ylab = "Species  richness",
        col = "blue")
barplot(size_1000, main = "Community size 1000",
        xlab = "Species abundance octaves",
        ylab = "Species richness",
        col = "red")
barplot(size_2500, main = "Community size 2500",
        xlab = "Species abundance octaves",
        ylab = "Species richness",
        col = "red")
barplot(size_5000, main = "Community size 5000",
        xlab = "Species abundance octaves",
        ylab = "Species richness",
        col = "blue")

dev.off()

## Challenge C

challenge_c <- function(community_size){
  all_srichness <- c() # create empty vector for sum_vect of all octaves
  total_vals <- 0 # set a counter
  # For each file in file_list:
  for (i in file_list) {
    load(paste0("../Data/", i)) # load RDA file
    if (community_size == size) {
        all_srichness <- sum_vect(all_srichness, srichness) # sum_vect each octave
        total_vals <- total_vals+1 # and add 1 to the counter
    }
  }
  
  # Divide sum_vect of all octaves by the total vals 
  all_srichness <- all_srichness/25
  return(all_srichness)
  
}

x <- challenge_c(500)
## Challenge D



