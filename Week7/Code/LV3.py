#!/usr/bin/env python3
def main(argv=[]):

    """

    A python script which implements a discrete-time
    version of the Lokta Volterra model.

    """

    __author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
    __appname__ = "Lokta - Volterra 3"
    __version__ = "0.0.1"
    __license__ = "I do not have one"

    # Import necessary modules
    import scipy as sc
    import scipy.stats
    import scipy.integrate as integrate


    def Rt1_Ct1(R, C, t = 0):
        """ A function that returns the growth rate
        of consumer and resource population  at
        any given time step."""
        #R = pops[0] #assign R first column (list)
        #C = pops[1] #assign C to second column (list)
        Rt = R
        Ct = C
        Rt_1 = Rt * (1 + (r * (1 - (Rt / K))) - a * Ct)
        Ct_1 = Ct * (1 - z + e * a * Rt)

        return sc.array([Rt_1, Ct_1])

    #check type of object
    type(Rt1_Ct1)

    # Take system arguments and provide default values
    try:
        r = float(argv[1])
        a = float(argv[2])
        z = float(argv[3])
        e = float(argv[4])
    except (ValueError, IndexError):
        print("Error with values given, using default instead!")
        r = 1.
        a = 0.1
        z = 1.5
        e = 0.75
        print("Calculating Lokta-Volterra model")

    # Define time vector
    # Time point 0 to 15
    #1000 sub-divisions of time
    t = sc.linspace(0, 15, 1000) # (values are arbitrary)

    # Define carrying capaticy(K)
    K = 50

    # Set initial conditions for both populations
    # 10 resources and 5 consumers per unit area
    R0 = 10
    C0 = 5
    RC0 = sc.array([[R0, C0]]) # Convert to array of lists

    # Equilibrium occurs when the growth rate is equal to 0.

    # Loop through iterations until the resource and consumer
    # populations are equal to 0.

    # Loop though 1000 iterations
    for i in range(1000):
        pops = Rt1_Ct1(RC0[-1][0], RC0[-1][-1]) # Run the function
        RC0 = sc.vstack((RC0, pops)) # Vertically stack array
        if pops[0] < 0: # When the resource is less than 0
            RC0[-1, 0] = 0 # Resource population is extinct
            print("Prey population reached extinction at {} iterations".format(i))
            continue
        if pops[-1] < 0: # As above
            RC0[-1, -1] = 0
            print("Predator population reached extinction at {} iterations".format(i))
            break

    # Set the time vector to equal the length of RC0
    t = range(len(RC0))

    ###############################
    ## Visualize with matplotlib ##
    ###############################

    # Import module
    import matplotlib.pylab as p

    # First plot
    # Open empty figure object
    f1 = p.figure()

    # Plot
    p.plot(t, RC0[:,0], "g-", label = "Resource density")
    p.plot(t, RC0[:,1], "b-", label = "Consumer density")
    p.grid()
    p.legend(loc = "best")
    p.xlabel("Time")
    p.ylabel("Population density")
    p.title("Consumer-Resource population dynamics")

    # Save pdf in results directory
    f1.savefig("../Results/LV3_model.pdf")

    # Second plot
    # Plot direction fields and trajectories in the phase plane
    # Open empty figure object
    f2 = p.figure()

    # Plot
    p.plot(RC0[:,0],RC0[:,1],"r-")
    p.grid()
    p.legend(loc = "best")
    p.xlabel("Resource density")
    p.ylabel("Consumer density")
    p.title("Consumer-Resource population dynamics")

    # Save ddf in results directory
    f2.savefig("../Results/LV3_phase.pdf")

if __name__== "__main__":
    import sys
    main(sys.argv)
