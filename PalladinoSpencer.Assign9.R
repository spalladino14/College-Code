#Spencer Palladino 
#Assignment 9

#Question 1
x = c(1:12) #create vector with numbers 1-12
#a
print(x) #print x
#b
attributes(x) #find attributes of x
#c
y=c(13:20) #create vector with numbers 13-20
#d
x=x+y
print(x)
#e
#Because the added vectors are not the same length, 
#once each variable of original x was added to its
#matching variable in the sequence of y the sequence 
#of y restarted and were added to the remaining x values.

#Question 2 
X=matrix(1:20,nrow=4, byrow=TRUE)
#a
print(X)
#b
attributes(X)
#c 
X=replace(X,X==8,100) #change 8 in matrix to 100
print(X)
#d
X=replace(X,c(1,5,9,13,17),1) #change postions in first row to 1
print(X)
#e
X=replace(X,c(17,18,19,20),c(19,14,9,4)) #change fourth column to 
                                #given numbers
print(X)

#Question 3

cars.types <- list(c(4), c(22.8,24.4,33.9),c("Datsun","Mercedes","Toyota"),c(FALSE,TRUE,FALSE))
#create list with 4 different variables
names(cars.types) <- c("cylinder","mpg","car.brand","is.German")
#creates variable names for the list
cars.types$cylinder
cars.types$mpg
cars.types$car.brand
cars.types$is.German
attributes(cars.types) #get list attributes

#Question 4
#a
dim(cars) #get dimension
max(cars) #get max
min(cars) #get min
#b
head(cars) #see which variable is in column 1/2
s=cars$speed #assign s to column 1
print(s) 
dim(s)
min(s)
max(s)
#c
d=cars$dist #assign d to column 2
print(d)
dim(d)
min(d)
max(d)

#Question 5 
attributes(mtcars)
#struggled with
#Question 6 
x=1:9
x=rev(x)
#a
#The rev function reverses the vector from 
# making the last observation first
X=matrix(x,nrow=3)
print(X)
print(rev(X))
diag(X)
#b
#diag function prints the matrix diagonals 
#of the matrix
col(X)
row(X)
#c
#The col function turns all observations in each 
#respective column to the number of its column.
#So observations in column 1 are changed to =1 
#and so on. The row function does the exact same 
#things except in respect to the obersvations row.
#So oberservations in row 2 for example would =2.

dT = col(X) == row(X)
dF = col(X) !=row(X)
X[dT]
X[dF]
#d
#The statements made a logical matrix dT in which
#the values were true for when the column=row 
#which would be the diagnoals. We then printed 
#the values at which dT was true. dF was basically
#the exact opposite so we made a logical matrix
#true for everywhere the row was not= to column
#and then printed the values for which the statement
#was true.
X[,1]
X[,1,drop=FALSE]
#e
#The drop option allows us to transpose what we 
#want so in this case we did not transpose column 1
X[,-1]
#f
#The negative index has us print everything 
#except what was after the - symbol. So in this
#case we printed everything except column 1.






