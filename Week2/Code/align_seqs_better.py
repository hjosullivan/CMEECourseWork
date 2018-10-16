#!/usr/bin/env python3

"""

A script to align ANY two DNA sequences from seperate files.
Pickles the highest scoring alignment in addition to other equally
good alignments.

Output: align_seqs_pickle

"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "Align Sequences (better)"
__version__ = "0.0.1"
__license__ = "I do not have one"

#should run using $python align_seqs_fasta.py seq1.csv seq2.csv
#also include default files when no arguments are given from command line

#import useful modules
import sys
import pickle

#set default arguments using week1 fasta files
if len(sys.argv) == 1:
    seq_file1 = "../Data/407228326.fasta"
    seq_file2 = "../Data/407228412.fasta"
    print("No arguments provided, using default.")
elif len(sys.argv) ==2:
    seq_file1 = sys.argv[1]
    seq_file2 = "../Data/407228412.fasta"
    print("One argument provided, comparing with default argument")
else:
    seq_file1 = sys.argv[1]
    seq_file2 = sys.argv[2]

#read in files and remove headers/newline characters
open_seq1 = open(seq_file1).readlines()
seqname1 = open_seq1[0]
seq1 = "".join(open_seq1[1:]).replace("\n", "")

open_seq2 = open(seq_file2).readlines()
seqname2 = open_seq2[0]
seq2 = "".join(open_seq2[1:]).replace("\n", "")

#assign the longest sequence s1, and the shortest to s2
#l1 is the length of the longest, l2 that of the shortest

#Check the length of the two sequences
#swap
l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

#function that computes a score
#by returning the number of matches
#starting from arbitrary startpoint
def calculate_score(s1, s2, l1, l2, startpoint):
    #score is every match = 1
    #startpoint is the point at which we want to start
    """ Calculate the alignment score of two given sequences """
    matched = "" #contains string for alignement
    score = 0
    for i in range(l2):
        #import import ipdb; ipdb.set_trace() waaaaaat is going on
        if (i + startpoint) < l1:
            #if its matching the character
            if s1[i + startpoint] == s2[i]:
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    return score

#calculate_score(s1, s2, l1, l2, 0)
#calculate_score(s1, s2, l1, l2, 1)
#calculate_score(s1, s2, l1, l2, 5)

#now try to find the best match (highest score)
my_best_align = None
my_best_score = {} #create empty dictionary

for i in range(l1): #take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i) #all possible start points
    my_best_align = "." * i + s2
    if z in my_best_score.keys():
        my_best_score[z].append(my_best_align)
    else:
        my_best_score[z] = [my_best_align]

val = max(my_best_score.keys())
print("The highest score was {}".format(val))
print("There were {} alignments with this score".format(len(my_best_score[val])))

bests = {val : my_best_score[val]}
pickle_bests = open("../Results/align_seqs_pickle", "wb")
pickle.dump(bests,pickle_bests)
pickle_bests.close()

#if you wanted top 10 aligns

#top10 = sorted(my_best_score.keys(), reverse=True)[:10]
#print(top10)
#top10_dic = {}
#for i in top10:
#    if i in top10_dic.keys():
#        top10_dic[i].append(my_best_score[i])
#    else:
#        top10_dic[i] = [my_best_score[i]]

#for i in top10_dic.keys():
#    print(i, len(top10_dic[i]))
