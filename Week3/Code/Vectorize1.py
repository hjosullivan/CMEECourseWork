#!/usr/bin/env python3

"""

A python verison of Vectorize1.R

"""
__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "Vectorize 1"
__version__ = "0.0.1"
__license__ = "I do not have one"


#import modules
import numpy as np

#draw samples from a uniform distribution
M = np.array(np.random.uniform((1000000), 1000, 1000))

def SumAllElements(M):
    Dimensions = np.shape(M)
    Tot = 0
    for i in Dimensions[0]:
        for j in Dimensions[1]:
            Tot = Tot + M(i,j)
    return Tot
