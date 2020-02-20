#Spencer Palladino 
#Homework 4 
#R Parts 
#Question 1 
library(tidyverse)
n=10
r = 1000000
#part i 
sim1=runif(n*r) 
df=matrix(sim1,nrow = n,ncol = r)
#create full matix of uniform dist values 
#part ii
colsuccesses = colSums(df < .5) #p=.5
#counts column success (when value less than .5)
#part iii
samplesuccesses=table(colsuccesses)
print(samplesuccesses)
#makes table of successes
#part iv
sampleprobs=samplesuccesses/r #sample probabilities
table = matrix(c(dbinom(0, size=10, prob=0.5),dbinom(1, size=10, prob=0.5),
                 dbinom(2, size=10, prob=0.5),dbinom(3, size=10, prob=0.5),
                 dbinom(4, size=10, prob=0.5),dbinom(5, size=10, prob=0.5),
                 dbinom(6, size=10, prob=0.5),dbinom(7, size=10, prob=0.5),
                 dbinom(8, size=10, prob=0.5),dbinom(9, size=10, prob=0.5),
                 dbinom(10, size=10, prob=0.5)),ncol = 11,byrow=TRUE)
#create matrix of binomial probabilties
table1=rbind(sampleprobs,table) 
rownames(table1) = c("Sample Binomial Probability", "True Binomial Probability")
#name columns
table1 = as.table(table1)
print(table1)

#Question 2 
N=20#column numbers
R=10 #number of rows
i=(0:9)
j= seq(from=.5, to=5, by=.5)

#a
mat1=matrix(rnorm(N*R,mean=i,sd=j),nrow = N,byrow = T)
colmeanss=apply(mat1,2,mean)
colsdss=apply(mat1,2,sd)

#b 
sum(((i*.8) < colmeanss) & ((i*1.2) > colmeanss) & ((j*.8) < colsdss) & ((j*1.2)>colsdss))
# number of columns with sample mean/sd within 20% of generated data values

#c 
truths=((i*.8) < colmeanss) & ((i*1.2) > colmeanss) & ((j*.8) < colsdss) & ((j*1.2)>colsdss)
new=rbind(mat1,truths) #adds a row that = 1 if condition satified, 0 if not
new1=new[, new[21,] %in% 1] #removes columns that dont satisfy condition
print(new1)
#d 
new2=head(new1,20)
#removing last column 
testmu=apply(new2,2,mean)
testsd=apply(new2,2,sd)
new3=(new2-testmu)/testsd
print(new3)
#returns values subratacted by column mean and divided by column sd
