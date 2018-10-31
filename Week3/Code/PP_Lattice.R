#######################
## Lattice practical ##
#######################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: PP_Lattice.R
## Desc: Visualization with the lattice package
## Date: October 2018

#save three lattice graphs by feeding interaction type:
#1. Predator mass
#2. Prey mass
#3. Size ratio of prey mass over predator mass

#NOTE: use logarithms of masses (or mass ratios) for all three plots. 

#Also calculate mean/median for:
#1. log predator mass 
#2. prey mass
#3. predator/prey size ratio
#by feeding type!
#save it as a single csv output file

#clear environment
rm(list = ls())

#load packages
require(lattice)
require(dplyr)

#import data
MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")

#Data wrang!
#create and populate column for predator/prey size ratio
test_df <- dplyr::mutate(MyDF, Predator.Prey.size.ratio = Prey.mass / Predator.mass)
tbl_df(test_df)

#check if ratios are sensible
densityplot(~log(test_df$Predator.Prey.size.ratio))

#plot lattice 
pdf("../Results/Pred_Lattice.pdf",
    11.7, 8.3)
densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data = test_df)
dev.off()

pdf("../Results/Prey_Lattice.pdf",
    11.7, 8.3)
densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data = test_df)
dev.off()

pdf("../Results/SizeRatio_Lattice.pdf",
    11.7, 8.3)
densityplot(~log(Predator.Prey.size.ratio) | Type.of.feeding.interaction, data = test_df)
dev.off()

#get mean/median
#mean for predator mass
new_df1 <- test_df %>% dplyr::group_by(Type.of.feeding.interaction) %>% 
  dplyr::summarise(mean(Predator.mass), median(Predator.mass),
                   mean(Prey.mass), median(Prey.mass),
                   mean(Predator.Prey.size.ratio), median(Predator.Prey.size.ratio))



#write csv
write.csv(new_df1, "../Results/PP_Results.csv", row.names = FALSE, quote = FALSE)




