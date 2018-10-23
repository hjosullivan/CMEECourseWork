#################################
## Temperature Autocorrelation ##
#################################

## Author: Hannah O'Sullivan h.osullivan18@imperial.ac.uk
## Script: TAutoCorr.R
## Desc: Autocorrelation practical
## Date: October 2018

#clear environment
rm(list = ls())

#load R data file
load("../Data/KeyWestAnnualMeanTemperature.RData")
plot(ats)
?cor

#create a lagged vector of t0 and t1
#to calculate correlation coefficient between successive years
t0 = ats[1:(nrow(ats)-1),2]
t1 = ats[2:nrow(ats),2]
Corest = cor(t0,t1)

#number of replicates 
reps = 10000

#pre-append
Coefficient.vector = numeric(length = reps)

#create random permutations
for(i in 1:reps){
  x = sample(t0, replace = T)
  y = sample(t1, replace = T)
  Coefficient.vector[i] = cor(x,y)
}

#histogram
#hist(Coefficient.vector)
#abline for Corest
#abline(v = Corest, col = "red")

#with ggplot2
require(ggplot2)

qplot(Coefficient.vector,
      geom="histogram",
      main = "Correlation Coefficient Between Successive Years", 
      xlab = "Correlation Coefficient",
      ylab = "Frequency",
      col = I("blue"),
      fill = I("blue"),
      alpha=I(.2)) + 
  geom_vline(xintercept = Corest,
             col = I("red"),
             lty = 2,
             lwd = 1) +
  theme_bw()


#remember how to do this bit in particular!
p.value <- length(Coefficient.vector[Coefficient.vector > Corest])/length(Coefficient.vector)
p.value

