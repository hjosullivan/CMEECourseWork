#!/usr/bin/env python3

"""

A script to align fasta sequences.

Takes input from a single external file and and saves
the best alignment with corresponding score.

Output: align_seqs.txt

"""

__author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
__appname__ = "Align Sequences "
__version__ = "0.0.1"
__license__ = "I do not have one"

#set relative path to sequence txt
seq_path = "../Data/sequences.txt"

#open file and strip to get just the 2 DNA sequences
seq = open(seq_path).read()
seq1 = seq.split("\n")[0]
seq1 = seq1.split(" ")[-1].replace('"','').rstrip()


seq2 = seq.split("\n")[-1]
seq2 = seq1.split(" ")[-1].replace('"','').rstrip()
print(seq1,seq2)

#These are the two sequences to match
#seq2 = "ATCGCCGGATTACGGG"
#seq1 = "CAATTCGGAT"

# assign the longest sequence s1, and the shortest to s2
# l1 is the length of the longest, l2 that of the shortest

#Check the length of the two sequences
#What if two sequences have the same length?
l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

# function that computes a score
# by returning the number of matches
# starting from arbitrary startpoint
def calculate_score(s1, s2, l1, l2, startpoint):
    #score is every match = 1
    # startpoint is the point at which we want to start
    """ Calculate the alignment score of two given sequences """
    matched = "" # contains string for alignement
    score = 0
    for i in range(l2):
        #import import ipdb; ipdb.set_trace()
        if (i + startpoint) < l1:
            # if its matching the character
            if s1[i + startpoint] == s2[i]:
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # build some formatted output
    print("." * startpoint + matched)
    print("." * startpoint + s2)
    print(s1)
    print(score)
    print("")

    return score

#calculate_score(s1, s2, l1, l2, 0)
#calculate_score(s1, s2, l1, l2, 1)
#calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score)
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

result_path = "../Results/align_seqs.txt"
#make file
results = open(result_path, 'w')
results.write(write_align)

results.close()
