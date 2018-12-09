#!/usr/bin/env python3
def main(argv=[]):

    """

    A python verison of Vectorize1.R

    """
    __author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
    __appname__ = "Vectorize 1"
    __version__ = "0.0.1"
    __license__ = "I do not have one"

    # Import modules
    import numpy as np
    import time

    # Define function
    def SumAllElements(M):
        """ A function to sum all the
        elements in a matrix """
        Dimensions = np.shape(M) # Get matrix dimensions
        Tot = 0 # Initialise
        for i in range(0, Dimensions[0]): # From the first...
            for j in range(0, Dimensions[-1]): # to last element
                Tot = Tot + M[i, j] # Sum these elements and add to the total
        return Tot

    # Draw random samples from a uniform distribution
    # With the dimmensions 1000x1000
    M = np.random.rand(1000, 1000)

    # Time the function:
    start = time.time() # Start the clock
    SumAllElements(M) # Run function
    # Stop the clock and print result.
    print("The sum of all elements takes %fs to run." % (time.time() - start))


if __name__== "__main__":
    import sys
    main(sys.argv)
