##########################################
## Predator-Prey regression by location ##
##########################################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: PP_Regress_loc.R
## Desc: Linear regression exercise
## Date: October 2018

#clear environment
rm(list = ls())

#require packages
require(plyr)
require(dplyr)

#import data
MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")

#convert prey mass to grams
MyDF <- MyDF %>%
  rowwise() %>%
  mutate(Prey.mass = ifelse(Prey.mass.unit =="mg",
                            Prey.mass/1000, Prey.mass))


#using tidyverse 
lm_df <- dlply(MyDF,.(Type.of.feeding.interaction, Predator.lifestage, Location),
               function(x) lm(Predator.mass ~ Prey.mass, data = x))  

#extract stats
LMextract <- ldply(lm_df, function(x) {
  intercept <- summary(x)$coefficients[1]
  slope <- summary(x)$coefficients[2]
  p_val <- summary(x)$coefficients[8]
  r2 <- summary(x)$r.squared
  data.frame(slope, intercept, r2, p_val)
})

#extract fstat
f_stat <- ldply(lm_df, function(x) summary(x)$fstatistic[1])

#merge
final_df <- merge(LMextract, f_stat, by = c("Type.of.feeding.interaction",
                                            "Predator.lifestage",
                                            "Location"), all = TRUE)
#change fstat column name
names(final_df)[8] <- "f_statistic"

#write csv
write.csv(final_df, "../Results/PP_Regress_loc.csv", row.names = FALSE, quote = FALSE)












































































































