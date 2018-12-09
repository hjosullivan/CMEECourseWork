#!/usr/bin/env python3
def main(argv=[]):

    """

    A python script to exemplify using numerical integration
    to solve the Lokta-Volterra model for a predator-prey
    system in two-dimmensional space.

    """

    __author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
    __appname__ = "Lokta - Volterra 1"
    __version__ = "0.0.1"
    __date__ = "November 2018"
    __license__ = "I do not have one"

    # Import packages
    import scipy as sc
    import scipy.integrate as integrate

    # Define function to return growth rate of consumer
    # and resource population at any given time steps.

    def dCR_dt(pops, t = 0):
        """ A function that returns growth rate
        of consumer and resource population  at
        any given time step."""

        R = pops[0] # Assign prey first column (list)
        C = pops[1] # Assign predator to second column (list)
        dRdt = r * R - a * R * C
        dCdt = -z * C + e * a * R * C

        return sc.array([dRdt, dCdt])

    # Check type of object
    type(dCR_dt)

    # Assign parameter values
    # Arbitrary but interesting!
    r = 1. # Instrinsic growth rate
    a = 0.1 # Intrinsic search rate for the resource
    z = 1.5 # Mortality rate (time-1)
    e = 0.75 # Consumer efficiency of converting resource to biomass

    # Define time vector
    # Time point 0 to 15
    # 1000 sub-divisions of time
    t = sc.linspace(0, 15, 1000) # (values are arbitrary)

    # Set initial conditions for both populations
    # 10 resources and 5 consumers per unit area
    R0 = 10
    C0 = 5
    RC0 = sc.array([R0, C0]) # Convert to array

    # Numerically integrate this system from starting conditions
    pops, infodict = integrate.odeint(dCR_dt, RC0, t,
    full_output = True)

    # View array
    # Contains population trajectories
    pops

    # Check type of infodict
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
    p.title("Consumer-Resource population dynamics")

    # Save to pdf in results directory
    f1.savefig("../Results/LV1_model.pdf")

    # Second plot
    # Plot direction fields and trajectories in phase plane
    # Open empty figure object
    f2 = p.figure()

    # Plot
    p.plot(pops[:,0],pops[:,1],"r-")
    p.grid()
    p.legend(loc = "best")
    p.xlabel("Resource density")
    p.ylabel("Consumer density")
    p.title("Consumer-Resource population dynamics")

    # Save to pdf in results directory
    f2.savefig("../Results/LV1_phase.pdf")

if __name__== "__main__":
    import sys
    main(sys.argv)
