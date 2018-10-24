################################################################
## Data wrangling the Pound Hill dataset with tidyr and dplyr ##
################################################################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: DataWrangTidy.R
## Desc: Data wrangling in tidyverse
## Date: October 2018

#clear environment
rm(list = ls())

#necessary packages
require(tidyr)
require(dplyr)
require(tibble)
require(janitor)

MyData <- read.csv("../Data/PoundHillData.csv", stringsAsFactors = FALSE) %>%
  # converts all the column names to a nice format
  janitor::clean_names()
#convert to tibble
MyData <- tibble::rownames_to_column(MyData) %>%
  gather(var, value, -rowname) %>%
  spread(rowname, value)

#Replace species absence with 0
MyData[MyData == ""] = 0

#change column names
colnames(MyData) <- MyData[1,]
MyData <- MyData[2:nrow(MyData),]
MyData <- janitor::clean_names(MyData)

#stack species names together
#key = name of factor column to be called (usually the column names that you are stacking)
#value = stuff in the columns being stacked (i.e.) counts
#contains = a supercool wrapper to search for just the columns containing certain strings, here '_'
MyData <- gather(MyData, key = species, value = 'count', contains('_'))

write.csv(MyData,"../Results/DataWrangTidy.csv")









