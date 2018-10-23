#####################################################
## Mapping the Global Population Dynamics Database ##
#####################################################

## Author: Hannah O'Sullivan
## Script: gpdd_map.R
## Desc: Map of the GPDD
## Date: October 2018

#clear environment
rm(list = ls())

#load R data file
load("../Data/GPDDFiltered.RData")

#install "maps" package
#install.packages("maps")
require(maps)

#plot species with available population times series data  
map(database = "world", fill = T)
points(x = gpdd$lon, y = gpdd$lat, pch = 21, bg = gpdd$common.name)

####################
## Interpretation ##
####################

## Looking at the map, what biases might you expect in any analysis based on the data represented?

#The species with available time series data are heavily biased towards Northern temperate zones.
#In any analysis based on these data it is worth taking into account how species may behave in other climates.
#I.e. tropical/polar regions. 

