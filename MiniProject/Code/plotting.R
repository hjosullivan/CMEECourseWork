# !/usr/bin/env Rscript

#####################
## Plots n' stats! ##
#####################

## AUTHOR: Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)
## SCRIPT: BT_DataWrang.R
## DESC: Tidyverse friendly data wrangling nlls data 
## DATE: Dec 2018

# clear environment 
rm(list = ls())

# Require packages
require(tidyverse)
require(ggthemes)

# Import data from NLLS fitting
# Fill empty rows and calculate AIC scores
df <- read.csv("../Data/fit_results.csv") %>% 
  group_by(FinalID) %>% 
  mutate(AIC_full = AIC_full[1],
         AIC_lt = AIC_lt[1],
         AIC_ht = AIC_ht[1],
         B0_full = B0_full[1],
         B0_ht = B0_ht[1],
         B0_lt = B0_lt[1],
         BIC_full = BIC_full[1],
         BIC_ht = BIC_ht[1],
         BIC_lt = BIC_lt[1],
         E_full = E_full[1],
         E_ht = E_ht[1],
         E_lt = E_lt[1],
         El_full = El_full[1],
         Eh_full = Eh_full[1],
         Eh_lt = Eh_lt[1],
         El_ht = El_ht[1],
         R2_full = R2_full[1],
         R2_ht = R2_ht[1],
         R2_lt = R2_lt[1],
         rss_full = rss_full[1],
         rss_ht = rss_ht[1],
         rss_lt = rss_lt[1],
         Th_full = Th_full[1],
         Th_lt = Th_lt[1],
         Tl_full = Tl_full[1],
         Tl_ht = Tl_ht[1],
         chisq_ht = chisq_ht[1],
         chisq_lt = chisq_lt[1],
         chisqr_full = chisqr_full[1]) %>%
  mutate(OriginalTraitValue = log(OriginalTraitValue),
         total_val = n(),
         AIC_full_prop = exp((min(c(AIC_full, AIC_ht, AIC_lt), na.rm = TRUE) - AIC_full)/2) ,
         AIC_ht_prop = exp((min(c(AIC_full, AIC_ht, AIC_lt), na.rm = TRUE) - AIC_ht)/2) ,
         AIC_lt_prop = exp((min(c(AIC_full, AIC_ht, AIC_lt), na.rm = TRUE) - AIC_lt)/2)) %>% 
  dplyr::select(AIC_full, AIC_ht, AIC_lt, AIC_full_prop, AIC_ht_prop, AIC_lt_prop, everything()) %>% 
  ungroup() %>% 
  group_by(total_val) %>% 
  mutate(total_id = length(unique(FinalID)))

# Define global parameters
# Boltzmann constant
k <- 8.62e-05
# Reference temperature (25 C)
Tref <- 298.15
plot_list = list()
for (unique_id in unique(df$FinalID)) {
  data <- df[df$FinalID == unique_id, ]
  
  temperature <- seq(min(data$ConTemp), max(data$ConTemp), 0.01)
  
  schoollow <- data$B0_lt + log(exp((-data$E_lt/k)*((1/temperature)-((1/Tref))))/
                     (1+exp((data$Eh_lt/k)*((1/data$Th_lt)-(1/temperature)))))
  
  schoolhigh <- data$B0_ht + log(exp((-data$E_ht/k)*((1/temperature)-((1/Tref))))/
                      (1+exp((data$El_ht/k)*((1/data$Tl_ht)-(1/temperature)))))
  
  schoolfull <- data$B0_full + log(exp((-data$E_full/k)*((1/temperature)-((1/Tref))))/
                      (1+exp((data$Eh_full/k)*((1/data$Th_full)-(1/temperature)))) +
                      (1+exp((data$El_full/k)*((1/data$Tl_full)-(1/temperature)))))
  
  best_model <- strsplit(names(which.min(apply(data[, grep("AIC", names(data))], MARGIN=2, min))), "_")[[1]][2]
  
  plt_data <- data.frame(temperature, "lt" = schoollow, "ht" = schoolhigh, "full" = schoolfull) %>%
    gather("model", "fit", -temperature)
  plt_data$AIC <- ifelse(plt_data$model == best_model, "low", "high")
  
  p <- ggplot(data = data, aes(ConTemp, OriginalTraitValue)) + 
    geom_point() + 
    geom_line(data=plt_data, mapping = aes(temperature, fit, lty=model, col = AIC)) +
    xlab("Temperature in Kelvin") +
    ylab("Logged Trait Value") +
    ggthemes::theme_few() +
    scale_color_manual(values = c("grey", "red"), name = "AIC scores") +
    scale_linetype_manual(values = c(3,1,5)) +
    ggtitle(paste(unique_id))
  plot_list[[unique_id]] <- p
}  

for (unique_id in unique(df$FinalID)) {
  file_path = "../Results/NLLS_plots/"
  file_name = paste(file_path, "TPC_", unique_id, ".jpeg", sep="")
  jpeg(file_name, quality = 35)
  print(plot_list[[unique_id]])
  dev.off()
}

#################
## Final plots ##
#################

# get a plotting dataframe
plot_data <- df %>% 
  dplyr::ungroup() %>% 
  dplyr::select(AIC_full_prop, AIC_lt_prop, AIC_ht_prop, ConKingdom, FinalID, Climate, StandardisedTraitName, Habitat) %>% 
  tidyr::gather("AIC_label", "AIC_prop", -c(Climate, ConKingdom, StandardisedTraitName, Habitat, FinalID)) %>% 
  tidyr::separate(AIC_label, "_", into = c("type", "model")) %>% 
  dplyr::group_by(model, ConKingdom, Climate, Habitat) %>% 
  dplyr::mutate(total_ID =  length(unique(FinalID[AIC_prop == 1]))) %>% 
  dplyr::filter(!is.na(AIC_prop)) %>% 
  dplyr::ungroup() %>% 
  dplyr::mutate(prop = total_ID/sum(unique(total_ID))) %>% 
  dplyr::group_by(model) %>% 
  dplyr::mutate(model_prop = sum(unique(prop)))

## Plot proportion models that performed best
p <- ggplot(plot_data) +
  geom_bar(aes(x = reorder(model, model_prop), y = model_prop, fill = model), stat = "identity", position = position_dodge()) +
  theme_few() +
  xlab("Model") +
  ylab("Proportion of TPC curves")
ggsave("../Data/figure3.pdf", p)

## model perfomance by Kingdom
p <- ggplot(plot_data) +
  geom_bar(aes(x = reorder(ConKingdom, prop), y = prop, fill = model), stat = "identity", position = position_dodge()) +
  theme_few() +
  xlab("") +
  ylab("Proportion of TPC curves")
ggsave("../Data/figure4.pdf", p)

# model performance by climate
plot_data <- plot_data %>% filter(Climate!="")
p <- ggplot(plot_data) +
  geom_bar(aes(x = reorder(Climate, prop), y = prop, fill = model), stat = "identity", position = position_dodge()) +
  theme_few() +
  xlab("") +
  ylab("Proportion of TPC curves") + 
  theme(axis.text.x = element_text(angle = 30, hjust = 1))
ggsave("../Data/figure5.pdf", p)

# By habitat
#plot_data <- plot_data %>% dplyr::filter(Habitat!="")
#plot_data$Habitat[plot_data$Habitat == "Marine"] <- "marine"
#p <- ggplot(plot_data) +
#  geom_bar(aes(x = reorder(Habitat, prop), y = prop, fill = model), stat = "identity", #position = position_dodge()) +
#  theme_few() +
#  xlab("") +
#  ylab("Proportion of TPC curves") + 
#  theme(axis.text.x = element_text(angle = 30, hjust = 1))
#ggsave("../Data/figure6.pdf", p)

# model performance by traits
plot_data$new <- NA
plot_data$new[grep("photosynth", plot_data$StandardisedTraitName)] <- "Photosynthesis"
plot_data$new[grep("Growth", plot_data$StandardisedTraitName)] <- "Growth rate"
plot_data$new[grep("respiration", plot_data$StandardisedTraitName)] <- "Respiration"

p <- ggplot(plot_data) +
  geom_bar(aes(x = reorder(new, prop), y = prop, fill = model), stat = "identity", position = position_dodge()) +
  theme_few() +
  xlab("") +
  ylab("Proportion of TPC curves") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggsave("../Data/figure7.pdf", p)



# Find out how many models fitted at all
#df <- df %>% group_by(FinalID) %>% 
#  mutate(na_lt = anyNA(E_lt),
#         na_ht = anyNA(E_ht),
#         na_full = anyNA(E_full))

#paste(round(length(unique(df$FinalID[df$na_lt == TRUE]))*100/length(unique(df$FinalID)), digits= 2), "% of lt curves unsuccessful", sep = "")
#paste(round(length(unique(df$FinalID[df$na_ht == TRUE]))*100/length(unique(df$FinalID)), digits= 2), "% of ht curves unsuccessful", sep = "")
#paste(round(length(unique(df$FinalID[df$na_full == TRUE]))*100/length(unique(df$FinalID)), digits= 2), "% of full curves unsuccessful", sep = "")
