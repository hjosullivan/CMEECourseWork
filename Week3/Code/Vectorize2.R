#################
## Vectorize 2 ##
#################

## Author: Hannah O'Sullivan
## Script: Vectorize2.R
## Desc: Vectorization practical
## Date: October 2018


#Runs the stochastic (with gaussian fluctuations) Ricker Eqn .

#clear environment
rm(list=ls())

#original
stochrick<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  
  for (pop in 1:length(p0)) #loop through the populations
  {
    for (yr in 2:numyears) #for each pop, loop through the years
    {
      N[yr,pop]<-N[yr-1,pop]*exp(r*(1-N[yr-1,pop]/K)+rnorm(1,0,sigma))
    }
  }
 return(N)

}

#print original performance
print("Original Ricker takes:")
print(system.time(res2 <- stochrick()))
plot(res2)

# Now write another function called stochrickvect that vectorizes the above 
# to the extent possible, with improved performance: 

#Remove outer loop and edit indentation
stochrickvect<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  
    for (yr in 2:numyears) #for each pop, loop through the years
    {
      N[yr,]<-N[yr-1,]*exp(r*(1-N[yr-1,]/K)+rnorm(length(p0),0,sigma))
    }
  return(N)
  
}


print("Vectorized Stochastic Ricker takes:")
print(system.time(res3<-stochrickvect()))
plot(res3)

