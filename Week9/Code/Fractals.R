########################
## Fractals in nature ##
########################

# Author: Hannah O'Sullivan (h.osullivan.18@imperial.ac.uk)
# Script: Fractals.R
# Date: December 18
# Version: 0.1

# Clear environment
rm(list = ls())
# Turn off graphics
graphics.off()

## Question 21
# ** see write up **
# Calculate the fractal dimensions of the Sierpinski carpet and the Merger sponge.

# Count the number of self similar units in the whole object (that you can see)
# Divide how many times this is repeated on one side

# The Sierpinski carpet:
# 8 self-similar copies scaled by 1/3rd
dim_1 = log(8)/log(3)
print(dim_1)

# The Merger sponge:
# 20 self-similar copies still scaled by 1/3rd
dim_2 = log(20)/log(3)
print(dim_2)

## Question 22

# The Chaos Game
# Store the following points:
# A <- c(0,0)
# B <- c(3,4)
# C <- c(4,1)
# Initialise point vector X to indicate the point (0,0):
# X <- c(0,0)
# Plot a very small point on the graph at X
# Choose one of the points A,B,C at random and move X halfway towards it. 

# Define function to find the halfway point between coordinates
halfway_point <- function(max, min){
  return (max - ((max - min)) / 2)
}

# Define the function "chaos_game"
chaos_game <- function(){
  # Define initial points
  A <- c(0,0)
  B <- c(3,4)
  C <- c(4,1)
  X <- c(0,0)
  points <- list(A, B, C) # create a list of point vectors
  # Run for 100000 iterations
  for(i in 1:100000){
    selection <- sample(3, 1) # select a random coordinate
  # Get coordinates for target
    target <- unlist(points[selection])
  # Create halfway point
   half_x <- halfway_point(max(target[1], X[1]), min(target[1], X[1]))
   half_y <- halfway_point(max(target[2], X[2]), min(target[2], X[2]))
   points(half_x, half_y, cex = 0.05)
   X <- c(half_x, half_y)
              
  }
  return(X)
}

# Test chaos game
#plot.new()
#plot.window(xlim= c(-5,10), ylim = c(-5,5))
#chaos_game()

#################
## Challenge E ##
#################

# ** see write up **

# Try starting the chaos game from a different initial postion (X)
# What happens and why?
# Plot the first n steps in a different colour to help
# Plot with the starting points of an equilateral triangle to produce a classic Sierpinski Gasket

halfway_point <- function(max, min){
  return (max - ((max - min)) / 2)
}

challenge_E <- function(){
  # Define initial points for an equilateral triangle
  A <- c(0,0)
  B <- c(5,5)
  C <- c(10,0)
  X <- c(0,0)
  points <- list(A, B, C) # create a list of point vectors
  # Run for 100000 iterations
  for(i in 1:10000){
    selection <- sample(3, 1) # select a random coordinate
    # Get coordinates for target
    target <- unlist(points[selection])
    # Create halfway point
    half_x <- halfway_point(max(target[1], X[1]), min(target[1], X[1]))
    half_y <- halfway_point(max(target[2], X[2]), min(target[2], X[2]))
    #points(half_x, half_y, cex = 0.05)
    if(i <= 1000){
      points(half_x, half_y, cex = 0.1, col = "black")
    } else {
      points(half_x, half_y, cex = 0.05, col = "red")
    }
    # New X:
    X <- c(half_x, half_y)
    
  }
  
  return()
}

# Save pdf
#pdf("../Results/Challenge_E.pdf")
plot.new()
plot.window(xlim= c(-5,20), ylim = c(0,5))
challenge_E()


halfway_point <- function(max, min){
  return (max - ((max - min)) / 2)
}
challenge_E_2 <- function(){
  # Define initial points for a square
  A <- c(0,0)
  B <- c(0,5)
  C <- c(5,5)
  D <- c(5,0)
  X <- c(0,0)
  points <- list(A, B, C,D) # create a list of point vectors
  # Run for 100000 iterations
  for(i in 1:100000){
    selection <- sample(4, 1) # select a random coordinate
    # Get coordinates for target
    target <- unlist(points[selection])
    # Create halfway point
    half_x <- halfway_point(max(target[1], X[1]), min(target[1], X[1]))
    half_y <- halfway_point(max(target[2], X[2]), min(target[2], X[2]))
    #points(half_x, half_y, cex = 0.05)
    if(i <= 1000){
      points(half_x, half_y, cex = 0.3, col = "black")
    } else {
      points(half_x, half_y, cex = 0.3, col = "red")
    }
    # New X:
    X <- c(half_x, half_y)
    
  }
  
  return()
}

pdf("../Results/Challenge_e_2.pdf")
plot.new()
challenge_E_2()
dev.off()

# The square is not so impressive I must say.


## Question 23

# Create the function "turtle"
# Draw a line of a given length, from a given point, in a given direction.
# Turle will have three inputs: start, direction (radians) and length.
# As well as drawing the line, turtle should return the endpoint as a vector. 

# Turtle should not open a plot, just draw the line on an already open plot.
# You will need to open the plot with a command outside of turtle.


# Random test parameters for following questions:
A <- c(3,3)
B <- pi/2 # to ensure a radian input 
C <- 10

# Define function "turtle"
turtle <- function(start, direction, length){
  # Get new x with cos 
  new_x <- start[1] + (length * cos(direction)) 
  # Get new y with sin 
  new_y <- start[2] + (length * sin(direction))
  # Draw a line between points
  lines(c(start[1], new_x), c(start[2], new_y), type = "l")
  # Get end point vector  
  end_point <- c(new_x, new_y)
  
  # Return the turtle endpoint 
  return(end_point)
}

# Test "turtle"
plot.new()
plot.window(xlim= c(-5,5), ylim = c(-5,5))
turtle(A, B, C)

## Question 24

# Create the function "elbow"
# This function will call "turtle" twice to draw an elbow
# "elbow" should take the starting point, direction and length of the first line
# The second line will start at the end point of the first line
# With a direction of 45 degrees (pi/4 radians)
# To the right of the first line
# And a length 0.95 times the length of the first line.

# Define function "elbow"
elbow <- function(start, direction, length){
  # Get the first line 
  line_1 <- turtle(start, direction, length) 
  # Get second line
  line_2 <- turtle(line_1, direction - pi / 4, length * 0.95)
  
  return(line_2)
}

# Plot
plot.new()
plot.window(xlim= c(-5,5), ylim = c(-5,5))
elbow(A, B, C)


## Question 25

# Copy and paste elbow and rename it "spiral"
# "spiral" will be an interative function that draws a spiral
# Instead of calling "turtle" twice, it will call turtle once then call itself. 

# Define function "spiral"
spiral <- function(start, direction, length){
  # Get the first line 
  line_1 <- turtle(start, direction, length) 
  # Get successive lines
  next_line <- spiral(line_1, direction - pi / 4, length * 0.95)
  
  #return()
}

# Test "spiral"
plot.new()
plot.window(xlim= c(-15,15), ylim = c(-15,15))
spiral(A, B, C)

# Uh oh
# Error: C stack usage  7971072 is too close to the limit
# ** see write up **

## Question 26

# Edit "spiral" so it will only act if called with a line length above a certain size
# This should draw a spiral without crashing or giving an error message!

# Define function "spiral_2"
spiral_2 <- function(start, direction, length){
  if(length >= 0.000000001){ # why not!
    # Get the first line 
    line_1 <- turtle(start, direction, length)
    # Get successive lines
    next_line <- spiral_2(line_1, direction - pi/4, length * 0.95)
  
  }
  #return()
}

# Test "spiral_2" and save pdf
#pdf("../Results/Q_26.pdf")
plot.new()
plot.window(xlim= c(-5,30), ylim = c(-5,20))
spiral_2(A, B, C)
#dev.off()

## Question 27

# Copy and paste "spiral_2" and name it "tree"
# "tree" will call itself not once, but twice!
# 45 degrees to the left and 45 degrees to the right
# Each subsequent line will be 0.65 times the length of the previous
# "turtle" will still be called 


# Define function "tree"
tree <- function(start, direction, length){
  if(length >= 0.01){ # we can reign it in a bit now
    # Get the first line 
    line_1 <- turtle(start, direction, length)
    # Get successive lines (to the right)
    next_lines <- tree(line_1, direction - pi/4, length * 0.65)
    # and again... (to the left)
    another_line <- tree(line_1, pi/4 + direction, length * 0.65)
    
  }
  #return()
}

# Test "tree" and save pdf
#pdf("../Results/Q27.pdf")
plot.new()
plot.window(xlim= c(-40,40), ylim = c(-5,80))
tree(A, B, C)
#dev.off()

# Question 28

# Copy and paste "tree" and name if "fern"
# Change variables so that:
# 1. One of the two branches goes 45 degrees to the left
# 2. The other goes straight on
# 3. Length (left) = 0.38
# 4. Length (straight) = 0.85

# Define function "fern"
fern <- function(start, direction, length){
  if(length >= 0.1){ 
    # Get the first line 
    line_1 <- turtle(start, direction, length)
    # Get successive lines (straight ahead)
    next_lines <- fern(line_1, direction, length * 0.87)
    # and again... (to the left)
    another_line <- fern(line_1, pi/4 + direction, length * 0.38)
    
  }
  #return()
}

plot.new()
plot.window(xlim= c(-40,40), ylim = c(-5,80))
fern(A, B, C)
# looks pretty funky at this point...

# Question 29

# Now copy "fern" and rename it "fern_2"
# This will have an addition input parameter "dir"
# "dir" will dictate whether the side branch goes to the left or right
# Should be a value of -1 or +1
# Make sure it looks the same as the fern from the worksheet!

# Define function "fern_2"
fern_2 <- function(start, direction, length, dir){
  if(length >= 0.01){ # For an extra fluffy fern this time
    # Get the first line 
    line_1 <- turtle(start, direction, length)
    # Get successive lines (straight ahead) - dir
    next_lines <- fern_2(line_1, direction, length * 0.87, -dir)
    # and again... (to the left)
    another_line <- fern_2(line_1, (dir * pi/4) + direction, length * 0.38, dir)
    
  }
  #return()
}

# Plot
#pdf("../Results/Q_29.pdf")
plot.new()
plot.window(xlim= c(-40,40), ylim =  c(-5,80))
fern_2(A, B, C, 1)
#dev.off()

#################
## challenge F ##
#################

# Define function "turtle"
turtle2 <- function(start, direction, length){
  # Get new x with cos 
  new_x <- start[1] + (length * cos(direction)) 
  # Get new y with sin 
  new_y <- start[2] + (length * sin(direction))
  # Draw a line between points
  lines(c(start[1], new_x), c(start[2], new_y), type = "l", col = "blue")
  # Get end point vector  
  end_point <- c(new_x, new_y)
  
  # Return the turtle endpoint 
  return(end_point)
}

# Define function "challenge_f"
challenge_f <- function(start, direction, length, dir){
  if(length >= 0.01){ # For an extra fluffy fern this time
    # Get the first line 
    line_1 <- turtle2(start, direction, length)
    # Get successive lines (straight ahead) - dir
    next_lines <- challenge_f(line_1, direction, length * 0.38, -dir)
    # and again... (to the left)
    another_line <- challenge_f(line_1, (dir * pi/4) + direction, length * 0.85, dir)
    
  }
  #return()
}

# Plot
#pdf("../Results/challenge_f.pdf")
plot.new()
plot.window(xlim= c(-15,35), ylim =  c(0,40))
challenge_f(A, B, C, -1)
dev.off()
