#!/usr/bin/env python3
def main(argv=[]):

    """

    A Lokta-Volterra model which includes prey density
    dependance and takes input values from the command
    line.

    Input: r = Intrinsic growth rate
           a = Per-capita search rate
           z = Mortality rate
           e = Consumer efficiency

    Command line example:
    run LV2.py r a z e

    Output: Figure of consumer-resource population dynamics
    Saves output to Results

    """

    __author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
    __appname__ = "Lokta - Volterra 2"
    __version__ = "0.0.1"
    __date__ = "November 2018"
    __license__ = "I do not have one"

    # Import packages
    import sys
    import scipy as sc
    import scipy.integrate as integrate

    # Define function to return growth rate of consumer
    # and resource population at any given time steps.
    def dCR_dt(pops, t = 0):
        """ A function that returns growth rate
        of consumer and resource population at
        any given time step, including prey density
        dependance."""

        R = pops[0] #assign R first column (list)
        C = pops[1] #assign C to second column (list)
        dRdt = r * R * (1 - (R/K)) - a * C * R
        dCdt = -z * C + e * a * C * R

        return sc.array([dRdt, dCdt])

    # Check type of object
    type(dCR_dt)

    # Take system arugments
    try:
        r = float(argv[1])
        a = float(argv[2])
        z = float(argv[3])
        e = float(argv[4])
    except (ValueError, IndexError):
        print("Error with values given, providing default values instead!")
        r = 1.
        a = 0.1
        z = 1.5
        e = 0.75
        print("Calculating Lokta-Volterra model")

    # Define time vector
    # Time point 0 to 15
    # 1000 sub-divisions of time
    t = sc.linspace(0, 15, 1000) # (values are arbitrary)

    # Define resource carrying capacity
    K = 50

    # Set initial conditions for both populations
    # 10 resources and 5 consumers per unit area
    R0 = 10
    C0 = 5
    RC0 = sc.array([R0, C0]) # Convert to array of lists

    # Numerically integrate this system from starting conditions
    pops, infodict = integrate.odeint(dCR_dt, RC0, t,
    full_output = True)

    # View array
    # Contains population trajectories
    pops

    type(infodict)

    infodict.keys()

    infodict["message"]

    ###############################
    ## visualize with matplotlib ##
    ###############################

    import matplotlib.pylab as p

    # First plot
    # Open empty figure object
    f1 = p.figure()

    # Plot
    p.plot(t, pops[:,0], "g-", label = "Resource density")
    p.plot(t, pops[:,1], "b-", label = "Consumer density")
    p.grid()
    p.legend(loc = "best")
    p.xlabel("Time")
    p.ylabel("Population density")
    p.title("Consumer-Resource population dynamics, r = {:.2}, a = {:.2}, z = {:.2}, e = {:.2}".format(r,a,z,e), fontsize  = 10)
    # Save pdf in results directory
    f1.savefig("../Results/LV2_model.pdf")

    # Open empty figure object
    f2 = p.figure()
    p.plot(pops[:,0],pops[:,1],"r-")
    p.grid()
    p.legend(loc = "best")
    p.xlabel("Resource density")
    p.ylabel("Consumer density")
    p.title("Consumer-Resource population dynamics")

    # Save pdf in results directory
    f2.savefig("../Results/LV2_phase.pdf")

if __name__== "__main__":
    import sys
    main(sys.argv)
