#####################
## Baby steps in R ##
#####################

#store a as 4
a <- 4

#print a
a

#4x4
a*a

#assign a squared
a_squared <- a*a

#square root
sqrt(a_squared)

#build a vector (use c to concate)
v <- c(0,1,2,3,4)

#print v
v

#find out if v is a vector 
is.vector(v)

#find the mean
mean(v)

#a vector is a single row/column
#can be combined to make a matrix

#variance
var(v)

#median(v)
median(v)

#sum all elements
sum(v)

#multiply
prod(v + 1)

#find length
length(v)

################################
## Variable names and tabbing ##
################################

#using dot notation
wing.width.cm <- 1.2
wing.length.cm <- c(4.7, 5.2, 4.8)

####################
## Variable types ##
####################

#logical
v <- TRUE
class(v)

#numeric
v <- 3.2
class(v)

#integer
v <- 2L
class(v)

#character
v <- "a string"
class(v)

#can also use is.* function 

b <- NA
is.na(b)

#Nan = not a number
b <-0/0
b
is.nan(b)

b <- 5/0
b

is.nan(b)

is.infinite(b)

is.finite(b)

is.finite(0/0)

#########################################
## Type conversions and species values ##
#########################################

#the as.* command converts a variable from one type to another

as.integer(3.1)

as.numeric(4)

as.roman(155)

as.character(155)

as.logical(5)

as.logical(0)

################
## E notation ##
################

#R uses E to display very large or small numbers

1E4

1e4

5e-2

1E4^2

1/3/1e8

#######################
## R data structures ##
#######################

#Vectors
a <- 5
is.vector(a)

v1 <- c(0.02, 0.5, 1)
v2 <- c("a", "bc", "def", "ghij")
v3 <- c(TRUE, TRUE, FALSE)

v1;v2;v3

#R vectors can only store data of a single type
#If you try and combine them R will homogenise them

#e.g.
v1 <- c(0.02, TRUE, 1)
v1
#TRUE is converted to 1.00

v1 <- c(0.02, "Mary", 1)
v1
#everything is converted to text

#########################
## Matrices and arrays ##
#########################

#a matrix is a 2 dimmendional vector
#and an array

mat1 <- matrix(1:25, 5, 5)
mat1

#order elements by row
mat1 <- matrix(1:25, 5, 5, byrow = TRUE)
mat1

#get matrix size
dim(mat1)

#make an array of 2 5x5 matrices (1-50)
arr1 <- array(1:50, c(5,5,2))
arr1[,,1]
arr1[,,2]
arr1

#################
## Data frames ##
#################

col1 <- 1:10
col1

col2 <- LETTERS[1:10]
col2

#10 random numbers from a uniform distribution
col3 <- runif(10)
col3

#combine them into a dataframe
MyDF <- data.frame(col1,col2,col3)
MyDF

#assign names to columns
names(MyDF) <- c("MyFirstColumn", "My Second Column", "My.Third.Column")
MyDF

#access contents by naming columns using $
MyDF$MyFirstColumn

#DO NOT USE SPACES IN COLUMN NAMES
MyDF$My Second Column
#doesn't work

#replace column name
colnames(MyDF)
colnames(MyDF) [2] <- "MySecondColumn"
MyDF
#tada

#using . is ok
MyDF$My.Third.Column

#access elements with numerical indexing
MyDF[,1]
MyDF[1, 1]

#two specific columns only
MyDF[c("MyFirstColumn", "My.Third.Column")]

#check structure
class(MyDF)

#also
str(MyDF)

#print colmn names and first few rows:
head(MyDF)

#and last few
tail(MyDF)

#you can convert particular vectors of a df to and from the factor class.
a <- as.factor(c(1, 2))
a
class(a)
levels(a)

class(MyDF$MySecondColumn)
MyDF$MySecondColumn <- as.character(MyDF$MySecondColumn)
class(MyDF$MySecondColumn)
str(MyDF)

###########
## Lists ##
###########

#Very different in Python and R!

MyList <- list(species = c("Quercus robur", "Fraxinus excelsior"), age = c(123, 84))
MyList

#access contents
MyList[[1]]

#or
MyList$species

#or!
MyList[["species"]]

#to access a specific item
MyList$species[1]

#you can also build lists of lists

####################################
## Creating and manipulating data ##
####################################

#the : operator creates vectors of sequential integers
years <- 1990:2009
years

#or in reverse
years <- 2009:1990
years

#for sequences of float numbers use seq()
seq(1, 10, 0.5)

#NOTE: prefix a command with ? for help, i.e.
?seq

#can also use
seq(from = 1, to = 10)
seq(from = 1, by = 0.5, to = 10)

##############################################################
## Accessing parts of data structures: Indices and indexing ##
##############################################################

#every element of a vector has an order (index)
MyVar <- c("a", "b", "c", "d", "e")

#sequare brackets extract values based on their numerical order:
#first
MyVar[1]

#fourth
MyVar[4]

#we can also select sets of values
#reverse
MyVar[c(3, 2, 1)]

#repeat
MyVar[c(1, 1, 5, 5)]

#manipulate by indexing
v <- c(0, 1, 2, 3, 4)
v

#access one element
v[3]

#access sequential elements
v[1:3]

#remove elements
v[-3]

#remove non-sequential indices
v[c(1,4)]

#for matrices you need row and column indices
mat1[1,2]
mat1[1,2:4]
mat1[1:2,2:4]

#to get all elements in a row/column, leave the value blank
#first row, all columns
mat1[1,]

#first column, all rows
mat1[,1]

###############
## Recycling ##
###############

#when vectors are f different lengths, R will recycle the shorter one to make them the same length
a <- c(1,5) + 2
a

x <- c(1, 2); y <- c(5, 3, 9, 2)
x;y

x + y

#whaaaat R recycles x (repeated 1, 2 twice)
#to sum the vectors

x + c(y, 1)

#R hates this.

####################################
## Basic vector-matrix operations ##
####################################

v <- c(0, 1, 2, 3, 4)
#Multiply whole vector by 2
v2 <- v * 2
v2

#element-wise product
v * v2

#transpose the vector
t(v)

#matrix/vetor product
v %*% t(v)

#assign using sequence
v3 <- 1:7
v3

#concate vectors
v4 <- c(v2, v3)
v4

#########################
## Strings and pasting ##
#########################

#it is important to know how to handle strings because:
#1. text data i.e. names of treatments
#2.to generate appropriate text labels and titles for figures

species.name <- "Quercus robur"
species.name

#combine strings
paste("Quercus", "robur")

#get rid of space
paste("Quercus", "robur", sep = "")

#insert comma to seperate
paste("Quercus", "robur", sep = ", ")

#for vectors
paste("Year is:", 1990: 2000)
#this is inclusive






