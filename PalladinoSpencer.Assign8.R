#Spencer Palladino 
#Assignment 8

#Question 1
#a
x=c(TRUE,FALSE,TRUE) #creates vectors
print(x)
#b
x=c(TRUE, FALSE, TRUE, 1) #creates vector
print(x)
#c
x=c(TRUE, FALSE, TRUE, 1, 'a') #creates vector
print(x)
#d
y1=as.numeric(x) #makes x a numeric vector
print(y1)
#e
y2=as.logical(x) #makes x a bayseian vector
print(y2)
#f
y3= as.numeric(y1) #makes y1 a number vector
print(y3)
#Question 2
x=c(1, 4, -7, 11, NA, 9, 2, 1, NA, 1, 4, 0)
naturallogs=log10(x) #take the natural log of x
print(naturallogs)
#Question 3
a = 'This is' 
b = 'a concatenated' 
c = 'string'
d = paste(a, b, c) #combines charecter values a b c 
print(d)
#Question 4 
g=c(T, T, T, T, F, T, T, T, F, T, T, T)
#a
z= sum(x[g]) #takes sum of x values for which g is True
print(z)
#b
g=c(T, T, F, T, F, T, T, T, F, T, T, T)
lns=log10(x[g]) #takes natural log of x values for which g is True
print(lns)
#Question 5
f=c('3', '1', '2', '2', '4', '4', '5', '2')
f=factor(f,levels=c('5','4',"3","2","1"),ordered=T)
#factor f with levels 1 being the smallest up to 5
print(f)
#Question 6
z=1:2
j=rep(z,5) #create vector that repeates z 5 times
print(j)
z1=1:5
k=rep(z1,each=2) #creates vector that has 2 of each values in z1
print(k)
q=seq(from=0,to=5,by=0.55555555555) #creates squence from 0-5 adding by .555
print(q)
value=sqrt(sum(j^2 + k^2 + q^2)) #take sum of squares and root the value
print(value)
#Question 7
library(faraway) #add faraway package
x = gala$Endemics #get data values
#a
?fivenum
fivenum(x) 
?quantile
quantile(x,c(0, 0.25, 0.50, 0.75, 1))
#The difference between fivenum and quantile is that fivenum produces 
# a five number summary of the min, 1st quantile, median, 3 quantile,
# and max. Where as the quantile produces just specific quantile 
#percentages that we type in. In this case, we happend to type in 
#similar percentages as what the fivenum summary produces.
#b
?order
order(x)
x[order(x)]
?sort
sort(x)
# Both order and sort do essentially the same thing it's just that 
# the output is different if you don't index the original vector 
# with the vector of the indices. Using order just adds an extra step.

