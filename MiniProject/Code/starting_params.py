#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import numpy as np
import pandas as pd
from scipy import stats, integrate

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "starting_params.py"
__version__ = "0.0.1"
__date__ = "March 2019"

# Boltzmann constant
global k
k = 8.62e-5
# Refernce temperature (10 degrees C)
global Tref
Tref = 273.15

def get_cols(dataset, item, remove_nan = True):
    """Deal with those nasty nas!"""
    col = dataset[item]
    col = col.replace("NA", np.nan)
    col = col.as_matrix()

    if remove_nan:
        return col[~np.isnan(col)] # gets rid of nans
    return col

def get_Tpk(temps, traits):
    """Find the temperature at the maximum trait value"""

    # Find row index of maximum trait value
    max_trait_idx = traits.argmax()

    # Get "ConTemp" where row index = max trait value
    Tpk = temps[max_trait_idx]

    return {"Tpk":Tpk, "max_trait_idx":max_trait_idx}

def get_slopes(temps, traits, max_trait_idx):
    """Find the temps/traits on either side of Tpk"""
    # Get the upward slopes (E)
    E_temps = temps[:max_trait_idx + 1]
    E_traits = traits[:max_trait_idx + 1]

    # Get the downward slopes (Eh)
    Eh_temps = temps[max_trait_idx:]
    Eh_traits = traits[max_trait_idx:]

    return {"E_temps":E_temps, "E_traits":E_traits, "Eh_temps":Eh_temps, "Eh_traits":Eh_traits}

def get_E(E_temps, E_traits):
    """Find the activation energy (E)"""
    global k
    if len(E_temps) > 1:
        try:
            # Define x and y vals
            x = 1/(k * E_temps) # 1/kT
            y = np.log(E_traits) # log trait vals

            # Linear regression of temps/traits
            E_stats = stats.linregress(x,y)
            # Get just the slope
            E = abs(E_stats.slope)
        except RuntimeWarning:
            # Set default to 0.65 if there is some nan weirdness
            E = 0.65
    else:
        # Set default to 0.65
        E = 0.65

    return E

def get_Eh(Eh_temps, Eh_traits, E):
    """High temperature de-activation energy (Eh)"""
    global k
    if len(Eh_temps) > 1:
        try:
            # Define x and y vals
            x = 1/(k * Eh_temps) # 1/kT
            y = np.log(Eh_traits) # log trait vals

            # Linear regression of temps/traits
            Eh_stats = stats.linregress(x,y)
            # Get just the slope
            Eh_slope = Eh_stats.slope
            # Now find Eh
            Eh = Eh_slope + E

        except RuntimeWarning:
            # Set default to twice the value of  E
            Eh = E * 2
    else:
        # Set default to twice the value of E
        Eh = E * 2

    return Eh

def get_Th(Eh_temps, Eh_traits, Tpk):
    """Temperature of 50% high temperature enzyme deactivation (Th)"""
    global k
    if len(Eh_temps) > 1:
        try:
            # Get the difference between
            Eh_temps_diff = Eh_temps[1:]
            Eh_traits_diff = np.diff(Eh_traits)
            # Get minimum np.diff trait index
            change_idx = np.argmin(Eh_traits_diff)
            # Assign Th
            Th = Tpk + ((Eh_temps_diff[change_idx] - Tpk)/2)

        except RuntimeWarning:
            # Assign a default close to Tpk
            Th = Tpk + 1
    else:
    # Assign a default close to Tpk
        Th = Tpk + 1
    return Th

def get_Tl(E_temps, E_traits, Tpk):
    """Temperature of 50% low temperature enzyme deactivation (Tl)"""
    global k
    if len(E_temps) > 3:
        E_temps_diff = E_temps[:-2]
        E_traits_diff = np.diff(E_traits[:-1])

        change_idx_min = np.argmin(E_traits_diff)
        change_idx_max = np.argmax(E_traits_diff)

        Tl = (E_temps_diff[change_idx_max] + E_temps_diff[change_idx_min])/2
    else:
        Tl = Tpk - 10
    return Tl

def get_El(E_temps, E_traits, E):
    """Low temperature de-activation energy (El)"""
    global k
    if len(E_temps) > 5:
        try:
            temps_split = np.array_split(E_temps, 3)[0]
            traits_split = np.array_split(E_traits, 3)[0]

            x = 1/(k * temps_split)
            y = np.log(traits_split)

            El_stats = stats.linregress(x,y)
            El_slope = El_stats.slope

            El = El_slope + E
        except RuntimeWarning:
            El = E * 0.5
    else:
        El = E * 0.5
    return El

def get_B0(temps, traits):
    """Rate performance at a reference temperature"""
    global Tref
    close_temp_idx = abs(temps - (Tref + 25)).argmin()
    close_trait_val = traits[close_temp_idx]
    B0 = np.log(close_trait_val)

    return B0
