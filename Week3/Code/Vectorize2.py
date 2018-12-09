#!/usr/bin/env python3
def main(argv=[]):

    """

    A python verison of Vectorize2.R

    """
    __author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
    __appname__ = "Vectorize 2"
    __version__ = "0.0.1"
    __license__ = "I do not have one"

    #import modules
    import numpy as np
    import time

    # Runs the stochastic Richer equation
    # With Gaussian fluctuations

    # Define function
    # def stochrick(p0 = np.random.uniform(.5,1.5,(1000)), r = 1.2, K = 1, sigma = 0.2, numyears = 100):
    #     """ A stochastic Richer equation with
    #      gaussian fluctuations. """
    #
    #     # Initialise
    #     N = np.full([numyears, len(p0)], np.nan)
    #     N[0,] = p0
    #
    #     # Looping through populations
    #     for pop in range(0, len(p0)):
    #         for yr in range(1, numyears):
    #             N[yr, pop] = N[yr - 1, pop] * np.exp(r * (1 - N[yr - 1, pop]/K)+ np.random.normal(1, 0, sigma))
    #     return N
    #     Print(N)

    # Define function to vectorise the original stockrich equation
    # Remove the outer loop and adjust indexing.

    def stochrickvect(p0 = np.random.uniform(.5,1.5,(1000)), r = 1.2, K = 1, sigma = 0.2, numyears = 100):
        """ A stochastic Richer equation with
         gaussian fluctuations. """

        # Initialise
        #N = np.array(np.nan, numyears, len(p0))
        N = np.full([numyears, len(p0)], np.nan)
        N[0,] = p0

        # Looping through populations
        for yr in range(1, numyears):
            N[yr,] = N[yr - 1,] * np.exp(r * (1 - N[yr - 1,]/K)+ np.random.normal(0, sigma,len(p0)))
        return N
        Print(N)

    # Compare the performance of both functions
    # start = time.time()
    # stochrick()
    # print("The original Richer equation takes %fs to run." % (time.time() - start))

    # Time the vectorized Richer equation:
    start = time.time() # Start the clock
    stochrickvect() # Run function
    # Stop the clock and print result.
    print("The vectorized Richer equation takes %fs to run." % (time.time() - start))

if __name__== "__main__":
    import sys
    main(sys.argv)
