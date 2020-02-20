############## Load Data ##############
library(datasets)
data(iris)
head(iris)
# divide data into train and test
train=iris[c(1:40,51:90, 101:140),]
test=iris[c(41:50,91:100, 141:150),]
#Sample size in training set
n_setosa=20
n_versicolor=20
n_virginica=20

#Prior=relative sample size in train data
p_setosa=n_setosa/60
p_versicolor=n_versicolor/60
p_virginica=n_virginica/60

# Calculate sample mean vectors 
Mean_setosa=colMeans(train[1:40,1:4])
Mean_versicolor=colMeans(train[41:80,1:4])
Mean_virginica=colMeans(train[81:120,1:4])


#Calculate pooled variance-covariance matrix
#Sample variance-covariance matrix for each specie
S_setosa=cov(train[1:40,1:4])
S_versicolor=cov(train[41:80,1:4])
S_virginica=cov(train[81:120,1:4])

#Complete fomula
S_pooled= ((n_setosa-1)*S_setosa+(n_versicolor-1)*S_versicolor+(n_virginica-1)*S_virginica)/(n_setosa+n_versicolor+n_virginica-3)

S_inv=solve(S_pooled)

#Simple way
#S_pooled=(S_setosa+S_versicolor+S_virginica)/3

#Calculate alpha_i 

alpha_setosa= -0.5* t(Mean_setosa) %*% S_inv %*% Mean_setosa
alpha_versicolor= -0.5* t(Mean_versicolor) %*% S_inv %*% Mean_versicolor 
alpha_virginica= -0.5* t(Mean_virginica) %*% S_inv %*% Mean_virginica 


#Calculate beta_i 

beta_setosa=S_inv %*% Mean_setosa
beta_versicolor=S_inv %*% Mean_versicolor
beta_virginica=S_inv %*% Mean_virginica


#Classification 
prediction=c()
d_setosa_vec=c()
d_versicolor_vec=c()
d_virginica_vec=c()
label=c("setosa", "versicolor", "virginica")

for(i in 1:nrow(test)){
    #Read an ovservation in test data
    x=t(test[i,1:4])
    
    #Calcualte linear discriminant functions for each speice
    d_setosa=alpha_setosa+ t(beta_setosa) %*% x
    d_versicolor=alpha_versicolor+ t(beta_versicolor) %*% x
    d_virginica=alpha_virginica+ t(beta_virginica) %*% x

    #Calssify the observation to the speice with highest function value
    d_vec=c(d_setosa, d_versicolor, d_virginica)
    prediction=append(prediction, label[which.max( d_vec )])
    
    d_setosa_vec=append(d_setosa_vec, d_setosa)
    d_versicolor_vec=append(d_versicolor_vec, d_versicolor)
    d_virginica_vec=append(d_virginica_vec, d_virginica)

}

#Combine the predicted resutls to the test dataset.
test$prediction=prediction


#3D scatter plot

library("scatterplot3d")

col_vec=c(rep("red", 10), rep("blue", 10), rep("black", 10))
pch_vec=c(rep(15, 10), rep(17, 10), rep(19, 10))

scatterplot3d(x = d_setosa_vec, y = d_versicolor_vec, z=d_virginica_vec,
              xlab = "d_setosa", ylab = "d_versicolor",	zlab="d_virginica", 
              color="red", pch=19, angle = 55 , cex.symbols=2, cex.lab=2
)

scatterplot3d(x = d_setosa_vec, y = d_versicolor_vec, z=d_virginica_vec,
              xlab = "d_setosa", ylab = "d_versicolor",	zlab="d_virginica", 
              color=col_vec, pch=pch_vec, angle = 55 , cex.symbols=2, cex.lab=2
)



