#########################################################
## Some code exemplifying control flow constructs in R ##
#########################################################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: control.R
## Desc: Introduction to writing R functions
## Date: October 2018

#clear environemnt
rm(list = ls())

#if statement
a <- TRUE
if (a == TRUE) {
  print("a is TRUE")
} else {
  print("a is FALSE")
}

#on a single line
z <- runif(1) #a random number
if (z <= 0.5) {
  print("Less than a half")
}

#for loop using a sequence
for(i in 1:1000){
  j <- i * i
  print(paste(i, " squared is", j))
}

#for loop over vector of strings
for(species in c("Heliodoxa rubinoides",
                 "Boissonneaua jardini",
                 "Sula nebouxii"))
{
  print(paste("The species is", species))
}

#for loop using a vector
v1 <- c("a", "bc", "def")
for(i in v1){
  print(i)
}

#while loop
i <- 0
while(i < 100){
  i <- i + 1
  print(i ^ 2)
}



