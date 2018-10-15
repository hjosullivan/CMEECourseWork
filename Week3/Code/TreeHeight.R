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

TreeHeight <- function(degrees, distance){
  radians <- degrees * pi/180
  height <- distance * tan(radians)
  print(paste("Tree height is:", height
  ))
  
  return(height)
  
}

TreeHeight(37, 40)
