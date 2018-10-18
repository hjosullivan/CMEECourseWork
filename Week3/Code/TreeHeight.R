##################
## Tree Heights ##
##################

#This function calculates heights of tree given the distance of each tree,
#form its base and angle to its top
#uses the trigonometric formula

#height = distance * tan(radians)

#ARGUMENTS
#degrees: The angle of elevation of tree
#distance: The distance from the base of tree (e.g. meters)

#OUTPUT
#The heights of the tree, same units as "distance"

#clear environment
rm(list = ls())
require(dplyr)

#if dplyr is not installed, install it
#if("dplyr" %in% rownames(installed.packages()) == FALSE){
#  install.packages("dplyr")
#}

#import tree csv - use relative path!
trees <- read.csv("../Data/trees.csv", header = TRUE)

#function for calulating tree height
TreeHeight <- function(degrees, distance){
  radians <- degrees * pi/180
  height <- distance * tan(radians)
  
  return(height)
  
}

#use dplyr
test_df <- trees %>% dplyr::group_by(Species) %>% dplyr::mutate(Tree.Height.m = TreeHeight(Angle.degrees, Distance.m))
#look at the first few rows 
head(test_df)

#write row names
write.csv(test_df,"../Results/TreeHts.csv", row.names = TRUE)

