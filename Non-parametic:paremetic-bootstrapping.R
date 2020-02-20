#Spencer Palladino 
#Stat 5010 
#Homework 4 

#Question 1 
library(boot)
library(rmarkdown)

bootsobs <- read.table("~/Downloads/bootsobs.txt", quote="\"", comment.char="")

skew <- function(x, d) {
  E <- x[d,] # allows boot to select sample 
  n= nrow(x)
  estimator1 = (1/n)* (sum(((E-mean(E))^3)))
  estimator2= estimator1/ ((sd(E))^3)
  return(estimator2)
} 
boots.obj = boot(data=bootsobs, statistic=skew, R=2500) #2500 replicates
#Histogram of Mean Skewness Estimators
hist(boots.obj$t, main = "Histogram of the Mean Skewness Estimators",
     xlab = "Mean Estimators")
plot(boots.obj)
Mean = mean(boots.obj$t)
#Skewness Estimator Mean 
print(Mean)
StdErr = sd(boots.obj$t)
#Skewness Estimator Standard Error 
print(StdErr)
boot.ci(boot.out =boots.obj, type = c("perc"))
#Based on this Confidence Interval we can say that we 
#are 95% confident that the mean value of a replication 
#is between (-0.298, 1).
t.test(boots.obj$t,alternative="two.sided")
#Looking at a t-test to see the mean value of the replications, 
#we can say with confidence that the mean value of the replications is 
#not 0 meaning we can reject a null hypothesis stating the mean value 
#of all the replications is equal to 0. We know this due to our extremely 
#small p-value.

#Question 2 
#If we know that the data comes from a normal distibution, I will 
#use the normal distribution with mean = the mean of our data and 
#variance = the variance of our data. 
mu = mean(bootsobs$V1)
print(mu)
sigma = sd(bootsobs$V1)
print(sigma)
var = sigma^2
print(var)
#Given our data, we have a mean = 5.015965 and a variance = 6.236597.
#We can then use these numbers to make a normal sampling distribution 
#that will improve our estimation of theta. 

#We want to now make samples using our found parameters 
prob2=rnorm(20, mean = 5.015965, sd = 2.497318)
X <- matrix(rnorm(50000, mean = 5.015965, sd = 2.497318), 2500, 20)
#creates a matrix of 20 samples sampled from our parameters replicated 2500 times
skew2 <- function(x) {
  n= 20
  estimator1 = (1/20)* (sum(((x-mean(x))^3)))
  estimator2= estimator1/ ((sd(x))^3)
  return(estimator2)
} 
#creates a function to find skew estimator for each replication
skewestimates=apply(X, 1, skew2)
hist(skewestimates, main = "Histogram of the Mean Skewness Estimators of Parametric Bootstrap ",
     xlab = "Mean Estimators")
Mean9 = mean(skewestimates)
#Skewness Estimator Mean of Parametric Bootstrap 
print(Mean9)
StdErr9 = sd(skewestimates)
#Skewness Estimator Standard Error of Parametric Bootstrap 
print(StdErr9)
t.test(skewestimates)
#With a p-value of .6916 we cannot reject the null hypothesis and we accept
#that or skew estimator may be equal to 0.
#Our 95% confidence bands are (-0.02076682, 0.01377818)


#Question 3 
#Using non-parametric bootstrapping
maximum <- function(x, d) {
  E <- x[d,] # allows boot to select sample 
  return(max(E))
} 

boots.max = boot(data= bootsobs, statistic= maximum, R=2500) #2500 replicates
#Histogram of Mean Max Estimators Using non-parametric bootstrapping
hist(boots.max$t, main = "Histogram of the Mean Max Estimators
     Using non-parametric bootstrapping",
     xlab = "Mean Estimators")
plot(boots.max)
Mean1 = mean(boots.max$t)
# Estimator Mean Using non-parametric bootstrapping
print(Mean1)
StdErr1 = sd(boots.max$t)
#Max Estimator Standard Error Using non-parametric bootstrapping
print(StdErr1)
boot.ci(boot.out =boots.max, type = c("perc"))
t.test(boots.max$t)
#It was fairly obvious that the true mean was not going to be 
#equal to 0 given that we are lookings at a max parameter of the data. 
#Our 95% confidence bounds for the max of each set is from (9.504176,9.562957)

#Using Parametric bootsrapping
#our mu and sigma should be the same as in problem 2 given we are 
#using the same data set.
#We can use our X data set from question 2. 
max1 <- function(x) {
  return(max(x))
} 
#creates a function to find skew estimator for each replication
maxestimates=apply(X, 1, max1)
#Histogram of Mean Max Estimators Using Parametric bootstrapping
hist(maxestimates, main = "Histogram of the Mean Max Estimators 
     Using Parametric bootstrapping",
     xlab = "Mean Estimators")

Mean2 = mean(maxestimates)
# Estimator Mean Using parametric bootstrapping
print(Mean2)
StdErr2 = sd(maxestimates)
#Max Estimator Standard Error Using parametric bootstrapping
print(StdErr2)
t.test(maxestimates)
#95 percent confidence interval: 9.612217 9.714327
#Once again, it was fairly obvious that the true average max of the 
#sample was not going to be =0 which means we reject our H0 as our p-value 
#is extremely small. 

#Based on the parametric and non-parametric bootstrapping for the max estimator,
#the non-parametric bootsrap appears to have less of a standard error given the 
#smaller confidence bounds which would make it seem like a better way of getting 
#less error but when you look at the histograms it is clear that bootstrapping 
#from the same sample will not always get as consistent of a result where as having
#many different normal sample in our parametric bootstrap at least results in having 
#our mean max estimator to have a normal distribution. 
