#REMEMBER DOCSTRINGS ETC



birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively.

#list comprehension for latin names
ln = [ln[0] for ln in birds]
print(ln)

#list comprehension for common names
cn = [cn[1] for cn in birds]
print(cn)

#list comprehension for body mass
bm = [bm[2] for bm in birds]
print(bm)

# (2) Now do the same using conventional loops (you can shoose to do this
# before 1 !).

#Loop for listing latin names
latin_names = set() #create empty set
for i in birds: #for each set in birds
    ln = i[0] #ln = first item in the set
    latin_names.add(ln) #add ln to the empty set
print(latin_names) #print

#Loop for listing common names
common_names = set()
for i in birds:
    cn = i[1]
    common_names.add(cn)
print(common_names)

#Loop for listing body mass
body_mass = set()
for i in birds:
    bm = i[2]
    body_mass.add(bm)
print(body_mass)

latin_names = set()
common_names = set()
body_mass = set()
for i in birds:
    ln = i[0]
    cn = i[1]
    bm = i[2]
    latin_names.add(ln)
    common_names.add(cn)
    body_mass.add(bm)
print(latin_names)
print(common_names)
print(body_mass)




# ANNOTATE WHAT EVERY BLOCK OR IF NECESSARY, LINE IS DOING!
# ALSO, PLEASE INCLUDE A DOCSTRING AT THE BEGINNING OF THIS FILE THAT
# SAYS WHAT THE SCRIPT DOES AND WHO THE AUTHOR IS.
