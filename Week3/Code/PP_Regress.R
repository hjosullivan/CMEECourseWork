##########################################################
## Predator-Prey regression by feeding interaction type ##
##########################################################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: PP_Regress.R
## Desc: Visualization with ggplot and LMs
## Date: October 2018

#clear environment
rm(list = ls())

#require packages
require(ggplot2)
require(plyr)
require(dplyr)

#import data
MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")

#convert prey mass to grams
MyDF <- MyDF %>% rowwise() %>% mutate(Prey.mass = ifelse(Prey.mass.unit =="mg", Prey.mass/1000, Prey.mass))

#plot
p <- qplot(Prey.mass, Predator.mass,
           facets = Type.of.feeding.interaction ~.,
           data = MyDF,
           log = "xy",
           xlab = "Prey mass in grams",
           ylab = "Predator mass in grams",
           colour = Predator.lifestage,
           shape = I(3))
p <- p + geom_smooth(method = "lm", fullrange = TRUE) +
          geom_point(shape = I(3)) +
          theme_bw() +
          theme(legend.position = "bottom")

p

ggsave(filename = "../Results/PP_Regress.pdf", plot = p)

########################################################################
## regression results corresponding to the lines fitted in the figure ##
########################################################################

#using tidyverse 
lm_df <- dlply(MyDF,.(Type.of.feeding.interaction, Predator.lifestage), function(x) lm(Predator.mass ~ Prey.mass, data = x))  

#extract stats
LMextract <- ldply(lm_df, function(x) {
  intercept <- summary(x)$coefficients[1]
  slope <- summary(x)$coefficients[2]
  p_val <- summary(x)$coefficients[8]
  r2 <- summary(x)$r.squared
  data.frame(slope, intercept, r2, p_val)
})

#why does it not extract f statistic 
f_stat <- ldply(lm_df, function(x) summary(x)$fstatistic[1])

#merge
final_df <- merge(LMextract, f_stat, by = c("Type.of.feeding.interaction", "Predator.lifestage"), all = TRUE)

#rename fstat
names(final_df)[7] <- "f_statistic"

#write csv
write.csv(final_df, "../Results/PP_Regress.csv", row.names = FALSE, quote = FALSE)












































































































