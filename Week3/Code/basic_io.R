#################################
## Basic input and output in R ##
#################################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: basic_io.R
## Desc: A simple script to illustrate R input and output.
## Date: October 2018

#Run line by line and check inputs and outputs to understand what is happening

#clean environment
rm(list = ls())

#import with headers
MyData <- read.csv("../Data/trees.csv", header = TRUE)

#write it out as a new file
write.csv(MyData, "../Results/MyData.csv")

#append to this
write.table(MyData[1,], file = "../Results/MyData.csv",append=TRUE)

#write row names
write.csv(MyData,"../Results/MyData.csv", row.names = TRUE)

#ignore column names
write.table(MyData, "../Results/MyData.csv", col.names = FALSE)
