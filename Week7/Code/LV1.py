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
    __license__ = "I do not have one"

    #import packages
    import scipy as sc
    import scipy.integrate as integrate

    #define function to return growth rate of consumer
    #and resource population at any given time stepself.

    def dCR_dt(pops, t = 0):
        """ A function that returns growth rate
        of consumer and resource population  at
        any given time step."""

        R = pops[0] #assign R first column (list)
        C = pops[1] #assign C to second column (list)
        dRdt = r * R - a * R * C
        dCdt = -z * C + r * a * R * C

        return sc.array([dRdt, dCdt])

    #check type of object
    type(dCR_dt)

    #assign parameter values
    #arbitrary but interesting!
    r = 1.
    a = 0.1
    z = 1.5
    e = 0.75

    #define time vector
    #from time point 0 to 15
    #using 1000 sub-divisions of time
    t = sc.linspace(0, 15, 1000) #again values are arbitrary

    #set initial conditions for both populations
    #10 resources and 5 consumers per unit area
    R0 = 10
    C0 = 5
    RC0 = sc.array([R0, C0]) #convert to array

    #numerically integrate this system from those starting conditions
    pops, infodict = integrate.odeint(dCR_dt, RC0, t,
    full_output = True)

    #view array
    pops

    type(infodict)

    infodict.keys()

    infodict["message"]

    ###############################
    ## visualize with matplotlib ##
    ###############################

    import matplotlib.pylab as p

    #first plot
    #open empty figure object
    f1 = p.figure()

    #plot
    p.plot(t, pops[:,0], "g-", label = "Resource density")
    p.plot(t, pops[:,1], "b-", label = "Consumer density")
    p.grid()
    p.legend(loc = "best")
    p.xlabel("Time")
    p.ylabel("Population density")
    p.title("Consumer-Resource population dynamics")

    #save to pdf in results directory
    f1.savefig("../Results/LV1_model.pdf")

    #second plot
    #plotting direction fields and trajectories in the phase plane
    #open empty figure object
    f2 = p.figure()

    p.plot(pops[:,0],pops[:,1],"r-")
    p.grid()
    p.legend(loc = "best")
    p.xlabel("Resource density")
    p.ylabel("Consumer density")
    p.title("Consumer-Resource population dynamics")

    #save to pdf in results directory
    f2.savefig("../Results/LV1_phase.pdf")

if __name__== "__main__":
    import sys
    main(sys.argv)
