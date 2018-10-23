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

#import data
#header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../Data/PoundHillData.csv",header = F,  stringsAsFactors = F))

#header = true because we do have metadata headers
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = T,  sep=";", stringsAsFactors = F)

#inspect the data
head(MyData)
dplyr::tbl_df(MyData) 
dim(MyData)
dplyr::glimpse(MyData)
#utils::View(MyData) #you can also do this
#utils::View(MyMetaData)

#Replace species absence with 0
MyData[MyData == ""] = 0

#first convert to data frame for tidyverse compatibility
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data
#MyTempData <- as_tibble(MyData)
#colnames(MyTempData) <- MyData[2,]
#NewData <- (rownames_to_column(MyTempData))

d <- tibble::rownames_to_column(TempData) %>%
  gather(var, value, -rowname) %>%
  spread(rowname, value)
colnames(d) <- d[1,]
d <- d[2:nrow(d),]

d <- gather(d, key = species, value = 'count', contains('_'))

#Transpose
#To get those species into columns and treatments into rows 
TempData2 <- add_rownames(TempData) %>%
  gather(var, value, -rowname) %>%
  spread(rowname, value)

#assign column names from original data
colnames(TempData2) <- MyData[1,] # assign column names from original data

#convert from wide to long format
MyWrangledData <- gather(key = "Species", value = "Count", "Cultivation", "Block", "Plot", "Quadrat")








