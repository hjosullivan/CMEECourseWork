##################################################
## Model fitting using Non-linear least squares ##
##################################################

#Allometric 

#clear environment
rm(list = ls())

#install packages
install.packages("minpack.lm")
install.packages("repr")

#load
require(minpack.lm)
require(ggplot2)
require(repr)

#create a function for power law model
powMod <- function(x, a, b) {
  return(a * x^b)
}

MyData <- read.csv("../Data/GenomeSize.csv")

head(MyData)

Data2Fit <- subset(MyData,Suborder == "Anisoptera")

#remove NA's
Data2Fit <- Data2Fit[!is.na(Data2Fit$TotalLength),]

#plot
ggplot(Data2Fit, aes(x = TotalLength, y = BodyWeight)) + geom_point()

#fit the model to the data using NLLS
PowFit <- nlsLM(BodyWeight ~ powMod(TotalLength, a, b),
                data = Data2Fit, start = list(a = .1, b = .1))
summary(PowFit)

#plot
#first generate vector of body lengths (x-axis)
Lengths <- seq(min(Data2Fit$TotalLength),max(Data2Fit$TotalLength),len=200)

#then calculate predicted line
#extract the coefficient from the model fit object
coef(PowFit)["a"]
coef(PowFit)["b"]

#so now...
Predic2PlotPow <- powMod(Lengths,coef(PowFit)["a"],coef(PowFit)["b"])

#plot data and fitted model line
plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col = 'blue', lwd = 2.5)

#calculate confidence intervals
confint(PowFit)


