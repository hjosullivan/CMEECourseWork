taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic
# derived from  taxa so that it maps order names to sets of taxa.
# E.g. 'Chiroptera' : set(['Myotis lucifugus']) etc.

# ANNOTATE WHAT EVERY BLOCK OR IF NECESSARY, LINE IS DOING!

# ALSO, PLEASE INCLUDE A DOCSTRING AT THE BEGINNING OF THIS FILE THAT
# SAYS WHAT THE SCRIPT DOES AND WHO THE AUTHOR IS

#Write your script here:

#using a loop
#taxa_dic = {} #create an empty dictionary
#for i in taxa: #for order
#    if i[1] in taxa_dic.keys(): #make order a key
#        taxa_dic[i[1]].append(i[0]) #and append species
#    else: #if it isn't a key...
#        taxa_dic[i[1]] = [i[0]] #make new one and populate!

#print(taxa_dic)


#or list comprehension
#a dictionary comprehension to construct order list, populating each entry
taxa_dic = {x[1]: set([y[0] for y in taxa if y[1] == x[1]]) for x in taxa}
print(taxa_dic)
