############################
## Girko's Law Simulation ##
############################

#the eigenvalues of a matrix M of size N×N are approximately contained in a circle
#in the complex plane with radius √N
#Let's draw the results of a simulation displaying this result.

#First, build a function object that will calculate the ellipse 
#(the perdicted bounds of the eigenvalues):

#clear environment
rm(list = ls())

build_ellipse <- function(hradius, vradius){ # function that returns an ellipse
  npoints = 250
  a <- seq(0, 2 * pi, length = npoints + 1)
  x <- hradius * cos(a)
  y <- vradius * sin(a)  
  return(data.frame(x = x, y = y))
}
#Assign size of the matrix
N <- 250

#Build the matrix
M <- matrix(rnorm(N * N), N, N)

#Find the eigenvalues
eigvals <- eigen(M)$values

# Build a dataframe
eigDF <- data.frame("Real" = Re(eigvals), "Imaginary" = Im(eigvals))

#The radius of the circle is sqrt(N)
my_radius <- sqrt(N)

#Dataframe to plot the ellipse
ellDF <- build_ellipse(my_radius, my_radius)

#rename the columns
names(ellDF) <- c("Real", "Imaginary")

#plot the eigenvalues
p <- ggplot(eigDF, aes(x = Real, y = Imaginary))
p <- p +
  geom_point(shape = I(3)) +
  theme(legend.position = "none")

#add the vertical and horizontal line
p <- p + geom_hline(aes(yintercept = 0))
p <- p + geom_vline(aes(xintercept = 0))

#finally, add the ellipse
p <- p + geom_polygon(data = ellDF, aes(x = Real, y = Imaginary, alpha = 1/20, fill = "red"))
p

#save plot
ggsave(filename = "../Results/Girko.pdf", plot = p)

