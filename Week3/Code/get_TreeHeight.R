##################################################################
## Tree heights script taking input files from the command line ##
##################################################################

#Take a csv file from the command line
#Output to results file but input file name in the output file name
#NOTE: strip .csv
#use commandArgs

#clear environment
rm(list = ls())
#trees <- read.csv("../Data/trees.csv", header = TRUE)
#This function calculates heights of tree given the distance of each tree,
#form its base and angle to its top
#uses the trigonometric formula

#height = distance * tan(radians)

#ARGUMENTS
#degrees: The angle of elevation of tree
#distance: The distance from the base of tree (e.g. meters)

#OUTPUT
#The heights of the tree, same units as "distance"

#function for calulating tree height
TreeHeight <- function(degrees, distance){
  radians <- degrees * pi/180
  height <- distance * tan(radians)
  
  return(height)
  
}

args = commandArgs(trailingOnly = TRUE)
print(args)
if (length(args) == 0) {
  #use default if no arguments are provided
  trees = read.csv("../Data/trees.csv", header = TRUE)
  outbase = "default"
} else {
  #provided csv
  trees = read.csv(args[1])
  outbase = args[1]
}

#get base filename strip path and ext
outfile = tools::file_path_sans_ext(basename(outbase))

#contrust output path (suppressing seperators)
outpath = paste0("../Results/", outfile, "_treeheights.csv")

#use dplyr
require(dplyr)
testdf <- trees %>% dplyr::group_by(Species) %>% 
  dplyr::mutate(Tree.Height.m = TreeHeight(Angle.degrees, Distance.m))


#write row names
write.csv(testdf,outpath)



