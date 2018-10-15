##########################################
## Skip to the next iteration of a loop ##
##########################################

#both next and {\tt break} can be used within other loops

#clear environment
rm(list = ls())

#next example
for (i in 1:10) {
  if ((i %% 2) == 0)
    next #pass to the next iteration
  print(i)
}