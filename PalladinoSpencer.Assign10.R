#Spencer Palladino 
#Stat 4360 Assignment 10

#Question 1 
# Set the seed, so that everyone gets the same answer.
set.seed(11)
k = 10000   # replicates
n = 100     # sample size of each replication
t.mean = 0  # initialize vector of trimmed means

f1 = function(x){
 return(mean(x,trim=.05))
}
#makes a function that trims mean at .05

my.df <- replicate(n=10000, rnorm(100))
#makes a random sample of 100, 10000 times.
means <- apply(my.df, MARGIN = 2, f1)
#takes the trucated mean of 10000 rows of 100
mean(means) #take the mean of the means to check answer
var(means) #takes the variance of the means to check answer

#Question 2 
D=matrix(1:6,ncol=1) #setting d
r=matrix(c(1.1,1.9,2.8,4.4,5.6,7),ncol=1) #setting r
my.lm = function(y,x) { #how to start a function with y/x arguments
  rows = nrow(y) #counts rows
  colums= ncol(x) #counts colums
  newx= cbind(a=1, x) #binds a colum of 1 to matrix
  answer= solve(t(newx)%*%newx) #mulipling matricies and taking inv
  Coef= as.vector(answer%*%t(newx)%*%y) #using Beta equation
  Fit= as.vector(newx%*%solve(t(newx)%*%newx)%*%t(newx)%*%y)
                              #using least squares equation 
  Resid= as.vector((diag(rows)-newx%*%solve(t(newx)%*%newx)%*%t(newx))%*%y)
                              #using residual equation
  Df= rows-ncol(x)-1
                              #using Df equation
  MSE= sum(Resid^2)/Df
                            #MSE equation
  VarCoef= MSE * answer
                            #VarCoef equation
 return(list(Coef, Fit, Resid, Df, MSE, VarCoef))
  #import step to return these variables from my function
}
mylm=my.lm(r,D) #calls my function wiht r,D
mylm

set.seed(50)
X=matrix(runif(12,-5,5),ncol=2)
mu.x=as.numeric(r+X%*%matrix(c(1,4),ncol=1))
y=matrix(rnorm(6,mu.x,sd=3),ncol=1)
g=my.lm(y,X)
print(g)
#I was told to run this code

#Question 3 
#first part
p=18/38 #set probability 
play = function(p =(13/18), bet) {
  if(runif(1) == p){ #if you win add the bet value
    winnings = bet + bet
  }
  else{
    winnings = -bet #if you lose subtract the value
  }
  return(winnings) #return after 1 iteration
}
xin=20
xout=xin + play(18/38,1)
print(xout)

#second part
p=18/38
martingale = function(pwin =(13/18),start, goal, rep) { #create func
  bet=1 #set first bet =1 because does not specify 
  for(i in 1:rep){ #for startement to set the number of iterations
    end = FALSE #keeps function running until i later specify
    while(!end){
      if(runif(1) == p){
        bet=1
        start = start + bet #add money won from bet
        bet = bet #bet stays the same becasue we won
      }
      else{
        start = start - bet #lose money from bet
        bet = bet*2 #change bet to twice the value
      }
        if(start <= 0){
          end=TRUE #end if process if less than or equal to 0
        }
        if (start >= goal){ #end if we reached our goal
          end=TRUE
        }
      }  
   } 
     return(start)  #return amount
}

#a) start=500, goal=1000
a1 = martingale((13/18),500,1000,1000)

#b) start=500, goal=2000 
b1 = martingale((13/18),500,2000,1000)
#c) start=2000, goal=4000 
c1 = martingale((13/18),2000,4000,1000)
#d) start=2000, goal=8000
d1= martingale((13/18),2000,8000,1000)

set.seed(25)
money = martingale(start=100,goal=200,rep=1000)
print(money)
 #I know I messed up the martingale function but 
#I have been looking at it for many hours so this 
#is my best guess. According to my output, 
#it would not be smart to gamble with martingale 
#as you would lose all your money in evey case.






