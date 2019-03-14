#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import numpy as np
import pandas as pd
from scipy import stats, integrate
import warnings
warnings.simplefilter('error', RuntimeWarning)
import starting_params
import fit_schoolfield
import csv

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "pipeline.py"
__version__ = "0.0.1"
__date__ = "March 2019"

# Get path to biotraits csv
path = "../Data/TidyData.csv"

# Read in csv
file = pd.read_csv(path, low_memory = False)

# Get a list of unique ids for each curve
curves = pd.unique(file['FinalID']).tolist()

# Assign empty dict
datasets = {}
for i in curves:
    data = file.loc[file['FinalID'] == i]
    data = data.sort_values("ConTemp").reset_index()
    datasets[i] = data

# Get starting parameters
for i in datasets.keys():
      dataset = datasets[i]

      # Get x and y for nls fitting
      temps = starting_params.get_cols(dataset, "ConTemp")
      traits = starting_params.get_cols(dataset, "OriginalTraitValue")

      # Get peak vals
      peak_vals = starting_params.get_Tpk(temps, traits)
      Tpk = peak_vals["Tpk"]
      max_trait_idx = peak_vals["max_trait_idx"]

      # Get E and Eh slopes
      all_slopes = starting_params.get_slopes(temps, traits, max_trait_idx)
      E_temps = all_slopes["E_temps"]
      E_traits = all_slopes["E_traits"]
      Eh_temps = all_slopes["Eh_temps"]
      Eh_traits = all_slopes["Eh_traits"]

      # Get actual params now!!!
      E = starting_params.get_E(E_temps, E_traits)
      #print(E)
      Eh = starting_params.get_Eh(Eh_temps, Eh_traits, E)
      #print(Eh)
      Th = starting_params.get_Th(Eh_temps, Eh_traits, Tpk)
      #print(Th)
      Tl = starting_params.get_Tl(E_temps, E_traits, Tpk)
      #print(Tl)
      El = starting_params.get_El(E_temps, E_traits, E)
      #print(El)
      B0 = starting_params.get_B0(temps, traits)
      #print(B0)

      # Add new starting parameter columns
      dataset["Tpk"] = Tpk
      dataset["E"] = E
      dataset["Eh"] = Eh
      dataset["Th"] = Th
      dataset["Tl"] = Tl
      dataset["El"] = El
      dataset["B0"] = B0

################################
# SCHOOLFIELD LOW TEMPERATURE ##
################################

for i in datasets.keys():
    dataset = datasets[i]

    # Assign parameters for NLS starts
    temps = starting_params.get_cols(dataset, "ConTemp")
    traits = starting_params.get_cols(dataset, "OriginalTraitValue")
    #Tpk = starting_params.get_cols(dataset, "Tpk")
    E = starting_params.get_cols(dataset, "E")
    Eh = starting_params.get_cols(dataset, "Eh")
    Th = starting_params.get_cols(dataset, "Th")
    #Tl = starting_params.get_cols(dataset, "Tl")
    #El = starting_params.get_cols(dataset, "El")
    B0 = starting_params.get_cols(dataset, "B0")

    # Fit model
    sch_l_t = fit_schoolfield.schoolfield_low_temp(temps, traits, E, Eh, Th, B0)

    # If the model converged...
    if sch_l_t is not None:
        Th_lt = sch_l_t["Th_lt"]
        E_lt = sch_l_t["E_lt"]
        Eh_lt = sch_l_t["Eh_lt"]
        B0_lt = sch_l_t["B0_lt"]
        chisq_lt = sch_l_t["chisqr_lt"]
        AIC_lt = sch_l_t["AIC_lt"]
        BIC_lt = sch_l_t["BIC_lt"]
        R2_lt = sch_l_t["R2_lt"]
        rss_lt = sch_l_t["rss_lt"]

        # Append your new keys and values!
        dataset["Th_lt"] = Th_lt
        dataset["E_lt"] = E_lt
        dataset["Eh_lt"] = Eh_lt
        dataset["B0_lt"] = B0_lt
        dataset["chisq_lt"] = chisq_lt
        dataset["AIC_lt"] = AIC_lt
        dataset["BIC_lt"] = BIC_lt
        dataset["R2_lt"] = R2_lt
        dataset["rss_lt"] = rss_lt
        dataset = dataset.fillna(method="ffill")
    else:
        dataset["Th_lt"] = "NA"
        dataset["E_lt"] = "NA"
        dataset["Eh_lt"] = "NA"
        dataset["B0_lt"] = "NA"
        dataset["chisq_lt"] = "NA"
        dataset["AIC_lt"] = "NA"
        dataset["BIC_lt"] = "NA"
        dataset["R2_lt"] = "NA"
        dataset["rss_lt"] = "NA"

##################################
## SCHOOLFIELD HIGH TEMPEARTURE ##
##################################

for i in datasets.keys():
    dataset = datasets[i]

    # Assign parameters for NLS starts
    temps = starting_params.get_cols(dataset, "ConTemp")
    traits = starting_params.get_cols(dataset, "OriginalTraitValue")
    #Tpk = starting_params.get_cols(dataset, "Tpk")
    E = starting_params.get_cols(dataset, "E")
    #Eh = starting_params.get_cols(dataset, "Eh")
    #Th = starting_params.get_cols(dataset, "Th")
    Tl = starting_params.get_cols(dataset, "Tl")
    El = starting_params.get_cols(dataset, "El")
    B0 = starting_params.get_cols(dataset, "B0")

    # Fit model
    sch_h_t = fit_schoolfield.schoolfield_high_temp(temps, traits, E, El, Tl, B0)

    # If the model converged...
    if sch_h_t is not None:
        Tl_ht = sch_h_t["Tl_ht"]
        E_ht = sch_h_t["E_ht"]
        El_ht = sch_h_t["El_ht"]
        B0_ht = sch_h_t["B0_ht"]
        chisq_ht = sch_h_t["chisqr_ht"]
        AIC_ht = sch_h_t["AIC_ht"]
        BIC_ht = sch_h_t["BIC_ht"]
        R2_ht = sch_h_t["R2_ht"]
        rss_ht = sch_h_t["rss_ht"]

        # Append your new keys and values!
        dataset["Tl_ht"] = Tl_ht
        dataset["E_ht"] = E_ht
        dataset["El_ht"] = El_ht
        dataset["B0_ht"] = B0_ht
        dataset["chisq_ht"] = chisq_ht
        dataset["AIC_ht"] = AIC_ht
        dataset["BIC_ht"] = BIC_ht
        dataset["R2_ht"] = R2_ht
        dataset["rss_ht"] = rss_ht
    else:
        dataset["Tl_ht"] = "NA"
        dataset["E_ht"] = "NA"
        dataset["El_ht"] = "NA"
        dataset["B0_ht"] = "NA"
        dataset["chisq_ht"] = "NA"
        dataset["AIC_ht"] = "NA"
        dataset["BIC_ht"] = "NA"
        dataset["R2_ht"] = "NA"
        dataset["rss_ht"] = "NA"


######################
## FULL SCHOOLFIELD ##
######################

for i in datasets.keys():
    dataset = datasets[i]

    # Assign parameters for NLS starts
    temps = starting_params.get_cols(dataset, "ConTemp")
    traits = starting_params.get_cols(dataset, "OriginalTraitValue")
    #Tpk = starting_params.get_cols(dataset, "Tpk")
    E = starting_params.get_cols(dataset, "E")
    Eh = starting_params.get_cols(dataset, "Eh")
    Th = starting_params.get_cols(dataset, "Th")
    Tl = starting_params.get_cols(dataset, "Tl")
    El = starting_params.get_cols(dataset, "El")
    B0 = starting_params.get_cols(dataset, "B0")

    # Fit model
    sch_full = fit_schoolfield.schoolfield_full(temps, traits, E, Eh, Th, El, Tl, B0)

    # If the model converged...
    if sch_full is not None:
        Th_full = sch_full["Th_full"]
        Tl_full = sch_full["Tl_full"]
        E_full = sch_full["E_full"]
        Eh_full = sch_full["Eh_full"]
        El_full = sch_full["El_full"]
        B0_full = sch_full["B0_full"]
        chisqr_full = sch_full["chisqr_full"]
        AIC_full = sch_full["AIC_full"]
        BIC_full = sch_full["BIC_full"]
        R2_full = sch_full["R2_full"]
        rss_full = sch_full["rss_full"]

        # Append your new keys and values!
        dataset["Th_full"] = Th_full
        dataset["Tl_full"] = Tl_full
        dataset["E_full"] = E_full
        dataset["Eh_full"] = Eh_full
        dataset["El_full"] = El_full
        dataset["B0_full"] = B0_full
        dataset["chisqr_full"] = chisqr_full
        dataset["BIC_full"] = BIC_full
        dataset["AIC_full"] = AIC_full
        dataset["R2_full"] = R2_full
        dataset["rss_full"] = rss_full
    else:
        dataset["Th_full"] = "NA"
        dataset["Tl_full"] = "NA"
        dataset["E_full"] = "NA"
        dataset["Eh_full"] = "NA"
        dataset["B0_full"] = "NA"
        dataset["chisqr_full"] = "NA"
        dataset["BIC_full"] = "NA"
        dataset["AIC_full"] = "NA"
        dataset["R2_full"] = "NA"
        dataset["rss_full"] = "NA"


# Save results to csv for plotting in R...
result = pd.concat(datasets)
result.to_csv("../Data/fit_results.csv", encoding='utf-8', index=False)
