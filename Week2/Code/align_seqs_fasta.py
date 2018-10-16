#!/usr/bin/env python3

"""

A script to align ANY two fasta sequences from seperate files.
Uses default fasta files as input when no arguments are given.

Output: align_seqs_fasta.txt

"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "Align Sequences (fasta)"
__version__ = "0.0.1"
__license__ = "I do not have one"

#should run using:
#$python align_seqs_fasta.py seq1.csv seq2.csv

#import useful modules
import sys

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
        #import import ipdb; ipdb.set_trace() a method of understanding the iterations of this loop
        if (i + startpoint) < l1:
            #if its matching the character
            if s1[i + startpoint] == s2[i]:
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    #build some formatted output
    print("." * startpoint + matched)
    print("." * startpoint + s2)
    print(s1)
    print(score)
    print("")

    return score

#calculate_score(s1, s2, l1, l2, 0)
#calculate_score(s1, s2, l1, l2, 1)
#calculate_score(s1, s2, l1, l2, 5)

#now try to find the best match (highest score)
my_best_align = None
my_best_score = -1

for i in range(l1): #take he last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i) #all possible start points
    if z > my_best_score:
        my_best_align = "." * i + s2
        my_best_score = z

print(my_best_align)
print(s1)
print("Best score:", my_best_score)
write_align = "Best score: {}\nBest align: {}".format(my_best_score, my_best_align)
#write_align = str(my_best_score) + my_best_align

result_path = "../Results/align_seqs_fasta.txt"

#make file
results = open(result_path, 'w')
results.write(write_align)

results.close()
