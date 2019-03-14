#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import numpy as np
import pandas as pd
from scipy import stats, integrate
import warnings
warnings.simplefilter('error', RuntimeWarning)
from lmfit import minimize, Parameters, Parameter, report_fit

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "fit_schoolfield.py"
__version__ = "0.0.1"
__date__ = "March 2019"

# Boltzmann constant
global k
k = 8.62e-5
# Refernce temperature (0 degrees C)
global Tref
Tref = 273.15 + 25

#################################
## SCHOOLFIELD LOW TEMPERATURE ##
#################################

def fit_lt_eq(params, temps, logtraits):
    """Define equation to be fit"""

    global k
    global Tref

    B0 = params["B0"].value
    E = params["E"].value
    Eh = params["Eh"].value
    Th = params["Th"].value
    #Tpk = params["Tpk"].value

    fit = B0 + np.log(np.exp((-E/k) * ((1/temps) - (1/Tref)))\
                     /(1 + np.exp(Eh/k * (1/Th - (1/temps)))))

    return np.array(np.exp(fit) - np.exp(logtraits))


def schoolfield_low_temp(temps, traits, E, Eh, Th, B0):
    """Fit schoolfield low temp model"""
    global k
    global Tref

    # Log trait values
    logtraits = np.log(traits)

    # Define parameters
    params = Parameters()
    params.add('B0', value = B0[1], vary = True, min = -np.inf, max = np.inf)
    params.add('E', value = E[1], vary = True, min = 10E-3, max = np.inf)
    #params.add('Eh', value = Eh[1], vary = True, min = 10E-10, max = np.inf)
    #params.add('Th', value = Th[1], vary = True, min = 273.15, max = np.inf)
    params.add('Eh', value = Eh[1], vary = True, min = 10E-3, max = np.inf)
    params.add('Th', value = Th[1], vary = True, min = 273.15 - 70, max = 273.15 + 170)

    try:
        model = minimize(fit_lt_eq, params, args = (temps, logtraits))
    except Exception:
        return None

    # Calculate R2 value
    R2 = 1 - np.var(model.residual/np.var(logtraits))

    # Get number of data points
    ndata = model.ndata

    # Get no. variables in fit
    nvarys = model.nvarys

    # Calculate residual sum of squares
    rss = sum(np.power(model.residual,2))

    # Get all fitted values
    fitted_vals = pd.DataFrame({"Th_lt": [model.params["Th"].value],
            "E_lt": [model.params["E"].value],
            "Eh_lt": [model.params["Eh"].value],
            "B0_lt": [model.params["B0"].value],
            "chisqr_lt": [model.chisqr],
            "AIC_lt": [model.aic],
            "BIC_lt": [model.bic],
            "R2_lt": R2,
            "rss_lt": rss})
    return fitted_vals

##################################
## SCHOOLFIELD HIGH TEMPERATURE ##
##################################

def fit_ht_eq(params, temps, logtraits):
    """Define equation to be fit"""

    global k
    global Tref

    B0 = params["B0"].value
    E = params["E"].value
    El = params["El"].value
    Tl = params["Tl"].value
    #Tpk = params["Tpk"].value

    fit = B0 + np.log(np.exp((-E/k) * ((1/temps) - (1/Tref)))\
                     /(1 + np.exp(El/k * (1/Tl - (1/temps)))))

    return np.array(np.exp(fit) - np.exp(logtraits))

def schoolfield_high_temp(temps, traits, E, El, Tl, B0):
    """Fit schoolfield high temp model"""
    global k
    global Tref

    # Log trait values
    logtraits = np.log(traits)

    # Define parameters
    params = Parameters()
    params.add('B0', value = B0[1], vary = True, min = -np.inf, max = np.inf)
    params.add('E', value = E[1], vary = True, min = 10E-3, max = np.inf)
    params.add('El', value = El[1], vary = True, min = -np.inf, max = -10E-10)
    params.add('Tl', value = Tl[1], vary = True, min = 273.15 - 70, max = 273.15 + 170)

    try:
        model = minimize(fit_ht_eq, params, args = (temps, logtraits))
    except Exception:
        return None

    # Calculate R2 value
    R2 = 1 - np.var(model.residual/np.var(logtraits))

    # Get number of data points
    ndata = model.ndata

    # Get no. variables in fit
    nvarys = model.nvarys

    # Calculate residual sum of squares
    rss = sum(np.power(model.residual,2))

    fitted_vals = pd.DataFrame({"Tl_ht": [model.params["Tl"].value],
            "E_ht": [model.params["E"].value],
            "El_ht": [model.params["El"].value],
            "B0_ht": [model.params["B0"].value],
            "chisqr_ht": [model.chisqr],
            "AIC_ht": [model.aic],
            "BIC_ht": [model.bic],
            "R2_ht": R2,
            "rss_ht": rss})

    return fitted_vals

######################
## SCHOOLFIELD FULL ##
######################

def fit_full_eq(params, temps, logtraits):
    """Define equation to be fit"""

    global k
    global Tref

    B0 = params["B0"].value
    E = params["E"].value
    El = params["El"].value
    Eh = params["Eh"].value
    Tl = params["Tl"].value
    Th = params["Th"].value

    fit = B0 + np.log(np.exp((-E/k) * ((1/temps) - (1/Tref)))\
                     /(1 + np.exp(El/k * (1/Tl - (1/temps))) + np.exp(Eh/k * (1/Th - (1/temps)))))

    return np.array(np.exp(fit) - np.exp(logtraits))

def schoolfield_full(temps, traits, E, Eh, Th, El, Tl, B0):
    """Fit full schoolfield model"""
    global k
    global Tref

    # Log trait values
    logtraits = np.log(traits)

    # Define parameters
    params = Parameters()
    params.add('B0', value = B0[1], vary = True, min = -np.inf, max = np.inf)
    params.add('E', value = E[1], vary = True, min = 10E-3, max = np.inf)
    params.add('El', value = El[1], vary = True, min = -np.inf, max = -10E-10)
    params.add('Tl', value = Tl[1], vary = True, min = 273.15 - 70, max = 273.15 + 170)
    params.add('Eh', value = Eh[1], vary = True, min = 10E-3, max = np.inf)
    params.add('Th', value = Th[1], vary = True, min = 273.15 - 70, max = 273.15 + 170)

    try:
        model = minimize(fit_full_eq, params, args = (temps, logtraits))
    except Exception:
        return None

    # Calculate R2 value
    R2 = 1 - np.var(model.residual/np.var(logtraits))

    # Get number of data points
    ndata = model.ndata

    # Get no. variables in fit
    nvarys = model.nvarys

    # Calculate residual sum of squares
    rss = sum(np.power(model.residual,2))

    fitted_vals = pd.DataFrame({"Th_full": [model.params["Th"].value],
            "Tl_full": [model.params["Tl"].value],
            "E_full": [model.params["E"].value],
            "Eh_full": [model.params["Eh"].value],
            "El_full": [model.params["El"].value],
            "B0_full": [model.params["B0"].value],
            "chisqr_full": [model.chisqr],
            "AIC_full": [model.aic],
            "BIC_full": [model.bic],
            "R2_full": R2,
            "rss_full": rss})

    return fitted_vals
