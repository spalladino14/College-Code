#Spencer Palladino 
#Stat 4635 
#Homework 6
library(tidyverse)
NSeq = seq(from =2, to=30, by=2)
b=c(.2,.5,1)
a=c(1,1,1)
C=c(1,1)


#try #7

LinRegPower = function(N,B,A,sd,nrep) {
  if (length(A) != length(B)){
    return("Error: A and B are not the same length")
  }
  else if (length(N) == 1){
    return("Error: N is length 1")
  }
  else{
    m = cbind(A,B)
    m1 = as.data.frame(m)
    powers = rep(NA, length(N))
    for (k in 1:nrow(m1)){
    for (j in 1:length(N)){
      N1 = N[j]
      sigexs <- rep(NA, nrep) 
      for (i in 1:nrep){
        x =runif(N1,min=0,max=10) #gets x 
        y= m1$A[k]+(m1$B[k]*x)+rnorm(N1,0,sd) #gets ys
        fit.sim = lm(y~x) #make model
        p.value = summary(fit.sim)$coefficients[2,4] #gets pvalues
        sigexs[i] = (p.value <= .05) 
      }
      powers[j] = mean(sigexs)   
    }
      plt = matplot(N,powers,type="l",col=2:4,lty=1:3,lwd=2,ylim = c(0,1))
      plt # I tried for a long time but could not manage to get all of the 
      #plots on the same one
    }
  }
}

LinRegPower(NSeq,B,A,1,1000) #test run
