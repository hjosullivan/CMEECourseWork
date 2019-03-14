# !/usr/bin/env Rscript
#################################
## Mini Project Data Wrangling ##
#################################

## AUTHOR: Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)
## SCRIPT: BT_DataWrang.R
## DESC: Tidyverse friendly data wrangling of the biotraits database
## DATE: Dec 2018

# Explore BioTraits data!!!
# The main fields of interest are:
# 1. OriginalTraitValue (trait values responding to temperature)
# 2. ConTemp (the temperature)
# 3. FinalID (corresponds to 1 thermal performance curve)

# Clear environment
rm(list = ls())

# Require necesary packages
require(tidyverse)

# Import data as matrix, set header to f and saf to f
# Loading in data this way guarantees the data is imported 'as is'
#biotraits <- as.matrix(read.csv("../Data/BioTraits.csv", header = F, stringsAsFactors = F))
df1 <- as.data.frame(read.csv("../Data/BioTraits.csv", stringsAsFactors = F))

# Check columns
#colnames(df1)

# Select interesting columns
df2 <- df1 %>% 
    select(FinalID,
           OriginalID,
           StandardisedTraitName, 
           OriginalTraitValue,
           OriginalTraitUnit,
           StandardisedTraitValue,
           StandardisedTraitUnit,
           Habitat,
           Climate,
           Consumer,
           ConKingdom,
           ConPhylum,
           ConClass,
           ConOrder,
           ConFamily,
           ConGenus,
           ConSpecies,
           ConStage,
           ConTemp,
           ConTempUnit)

# Remove datasets with 0 or negative values
df3 <- df2 %>% 
  filter(!is.na(OriginalTraitValue), OriginalTraitValue > 0)

# Remove datasets without 2 unique temperatures above and below topt
df4 <- df3 %>% 
  group_by(FinalID) %>%
  filter(any(cumsum(row_number() %in% c(which.max(OriginalTraitValue) + - 2:2)) == 5))

# Remove datasets with less than 8 unique temperatures
df5 <- df4 %>% 
  group_by(FinalID) %>% 
  dplyr::filter(length(unique(ConTemp)) > 8)

# Check number of datasets
#length(unique(df5$FinalID))

# Convert to kelvins
df5[,"ConTemp"] <- df5[,"ConTemp"] + 273.15

# Write csv to ../Data
write.csv(df5, file = "../Data/TidyData.csv")

#export one tpc for NLS practice fitting in python
#test_df <- df5 %>% 
#  filter(FinalID == "MTD4545")
#write.csv(test_df, "../Data/TestDF.csv")


###################
## Plotting TPCs ##
###################

## FIGURE 1
# One example TPC
p <- ggplot(data = df4[df4$FinalID == "MTD4545",]) +
  theme_bw() +
  geom_point(aes(x = ConTemp, y = OriginalTraitValue)) +
  labs(title = "MTD4545", x = "Temperature (C)", y = "Trait value")

ggsave("../Data/figure1.pdf", p)

## FIGURE 2
# plot to see distribution of temps across TPCs
testdf <- df2 %>% 
  group_by(FinalID) %>% 
  mutate(total_val = n()) %>% 
  ungroup() %>% 
  group_by(total_val) %>% 
  mutate(total_id = length(unique(FinalID)))

p <- ggplot(testdf, aes(x = total_val, y = total_id)) +
  geom_bar(position = position_dodge(), stat = "identity", width = 1) +
  theme_bw(base_size = 10) +
  xlab("Number of temperatures") +
  ylab("Number of thermal responses") +
  xlim(1, 60)

ggsave("../Data/figure2.pdf", p)




# plot all TPC's
#plotTPCs <- function(tpcID){
#  subdf <- subset(df5, FinalID == tpcID)
#  g1 <- ggplot(data = subdf) +
#    geom_point(aes(x = ConTemp, y = OriginalTraitValue))
#  print(g1)
#  ggsave(sprintf("../Results/%s.pdf", tpcID))
#}

# plot every curve
#lapply(unique(df4$FinalID), plotTPCs)









