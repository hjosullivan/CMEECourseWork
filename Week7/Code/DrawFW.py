#!/usr/bin/env python3

"""

Food web networks with networkx

"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "Food webs"
__version__ = "0.0.1"
__license__ = "I do not have one"

#import modules
import networkx as nx
import scipy as sc
import matplotlib.pyplot as p

#generate a "synthetic" food web

def GenRdmAdjList(N = 2, C = 0.5):
    """ Generates a random list of connectance
    probibility between species pairs """
    Ids = range(N) #generate a particular set
    ALst = [] #empty list
    for i in Ids:
        if sc.random.uniform(0, 1, 1) < C:
            Lnk = sc.random.choice(Ids, 2).tolist()
            if Lnk[0] != Lnk[1]: #avoid self looping i.e. cannibalism
                ALst.append(Lnk)
    return ALst

#note this uses uniform random distribution [0,1]
#this generates connectance probablity between species pairs

#assign number os species (MaxN) and connectance(C)
MaxN = 30
C = 0.75

#generate adjacency list
AdjL = sc.array(GenRdmAdjList(MaxN, C))
AdjL
#two columns correspond to consumer and resource ids

#generate node(species) data:
Sps = sc.unique(AdjL)

#generate body size for species using log10 scale
SizRan = ([-10, 10])
Sizs = sc.random.uniform(SizRan[0], SizRan[1], MaxN)
Sizs

f1 = p.figure()
p.hist(Sizs) #log10 scale
f1.savefig("../Results/FW_log.pdf")
f2 = p.figure()
p.hist(10 ** Sizs) #raw scale
f2.savefig("../Results/FW_raw.pdf")

#use a circular configuration
pos = nx.circular_layout(Sps)

#generate networkx graph object
G = nx.Graph()

#add nodes
G.add_nodes_from(Sps)
G.add_edges_from(tuple(AdjL)) #function requires tuple

#generate node sizes proportional to log body sizes
NodSizs = 1000 * (Sizs - min(Sizs)) / (max(Sizs) - min(Sizs))

#render plot
f3 = p.figure()
nx.draw_networkx(G, pos, node_size = NodSizs)
f3.savefig("../Results/FW_network.pdf")
