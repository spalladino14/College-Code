#Spencer Palladino
#Stat 5010
#Homework 3 

#Question 1 
#a
library(MASS)
library(splines)
geriatric <- read.table("~/Downloads/geriatric.txt", quote="\"", comment.char="")
y = geriatric$V1
x1 = geriatric$V2
x2= geriatric$V3
x3=geriatric$V4
x4=geriatric$V5
m1 = glm(y ~ x1 + x2 + x3 + x4 ,family = poisson, data = geriatric)
#link function is by default log
plot(m1)
summary(m1)
# x1  estimate = -1.069403, x1 sd = 0.336869
# x2 estimate = -0.046606, x2 sd = 0.119970
# x3 estimate = 0.009470, x3 sd = 0.002953
# x4 estimate = 0.008566, x4 sd = 0.004312

#b
#Null Hypothesis: Our model is correctly specified
#Alternative Hypothesis: Our model is not correct. 
# Residual deviance 108.79 
pchisq(m1$deviance, df=m1$df.residual, lower.tail=FALSE)
#Based on our p-value of 0.157792, we can conclude at an alpha =.05
#that our our model doesnt fit badly meaning it could be 
#a suitable model for the data

#c
m1$residual
plot(m1$residual)
#It appears that there may be 2 outliers in the data. 
#d
fullModelFit = glm(y ~ x1 + x2 + x3 + x4 ,family = poisson, data = geriatric)
emptyModelFit = glm(y~1, data=geriatric)
step(fullModelFit, method="backward")
step(emptyModelFit, scope=list(upper=fullModelFit),
     direction="forward") # forward selection
#I can conclude that the x2 variable is not significant and 
#not needed in the model which was confirmed by doing forward 
#and backward selection.
#Thus our new model would be y = B0 + B1x1 + B2x3 + B3x4
newmodel = glm(y ~ factor(x1) +x3 + x4 ,family = poisson, data = geriatric)
summary(newmodel)
#e
#Looking at the data, we can see that having a bad strength 
#index, bad balance index, and doing aerobic training will 
#lead to less falls. Although this may not make sense, 
#our coefficients for balance index and strength index 
#are postive and significant which mean that they have a 
#positive correlation with the number of falls. 

# Question 2
library(MASS)
attach(mcycle)
View(mcycle)
#a
plot(mcycle$times,mcycle$accel, xlab = "time", ylab = "acceleration")
#b
plot(times, accel, main="Polynomial Regression", xlab="time",
     ylab="acceleration")
lines(times, fitted(lm(accel~poly(times,3))),col = "red")
lines(times, fitted(lm(accel~poly(times,5))),col = "blue")
legend("bottomright", pch = c(20,20),c("degree 3", "degree 5"), 
       col = c("red", "blue"))
#The line of degree 5 follows the data much closer than 
#the regression line of degree 3, thus making a regression
#model degree 5 a better fit. 

#c
library(ggplot2)
y=mcycle$accel
x1=mcycle$times
m3 = lm(y ~ x1)
library(segmented)

my.seg <- segmented(m3, 
                    seg.Z = ~x1, 
                    psi = list(x1 = c(15,20,30,40)))
# get the fitted data
my.fitted <- fitted(my.seg)
my.model <- data.frame(times = mcycle$times, Elevation = my.fitted)
# plot the fitted model
ggplot(my.model, aes(x = times, y = Elevation)) + geom_line()
#I decided to make 4 cuts at 15, 20, 30, and 40 as looking at 
#the plain scatter plot from part a, I thought these points
#were where the data curved. The data around the curves is 
#hard to get close to because in reality the data would so 
#sharply curve.

#d 
plot(x1, y, main="Natural Splines", xlab="time",
     ylab="acceleration")
lines(x1, fitted(lm(accel~ns(times,df=3))),col = "red")
lines(x1, fitted(lm(accel~ns(times,df=5))),col = "blue")
legend("bottomright", pch = c(20,20),c("degree 3", "degree 5"), 
       col = c("red", "blue"))
#Based on this, it lookes like the fit for the model with degrees 
#of freedom = 5 is much closer to the actual fit of the data.

#e
blah=smooth.spline(x1,y)
plot(x1, y, main="Smooth Splines", xlab="time",
     ylab="acceleration")
lines(blah$x, blah$y)
#The fit appears to be very accurate. It fits the model much better
#than any of our other models so far. 

#f
plot(x1, y, main="Local Regression", xlab="time",
     ylab="acceleration")
loessMod10 <- loess(y ~ x1, data=mcycle, span=0.10) # 10% smoothing span
loessMod25 <- loess(y~ x1, data=mcycle, span=0.25) # 25% smoothing span
loessMod50 <- loess(y ~ x1, data=mcycle, span=0.50) # 50% smoothing span
smoothed10 <- predict(loessMod10) 
smoothed25 <- predict(loessMod25) 
smoothed50 <- predict(loessMod50)
lines(smoothed10, x=mcycle$times, col="red")
lines(smoothed25, x=mcycle$times, col="green")
lines(smoothed50, x=mcycle$times, col="blue")
legend("bottomright", pch = c(20,20,20),c("smooth 10", "smooth 25","smooth 50"), 
       col = c("red", "blue", "green"))
#I found that with local regression, a lower span allowed for a 
#more detailed, more fitted model line, although it is not 
#nearly as smooth. Thus, my red line which is for span =.10 is the 
#most accurate but least smooth. 

#Question 3
library(MASS)
attach(rock)
head(rock)
#a
y = log(rock$perm)
model = lm(y ~ rock$area + rock$peri + rock$shape)
summary(model)
plot(rock$area, y)
plot(rock$peri, y)
plot(rock$shape, y)
#Just looking at the plots, it looks like only total perimeter
#is the only good linear predictor of permeability. However, 
#the summary would suggest that area is also a good linear 
#predictor.

#b
# I made this fit in part A but just to reprint it:
summary(model)
#Again looking at this, it would appear that permiter and 
#area are good linear preidctors of the log of permeability.

#c
library(gam)
lm1<-lm(y ~ ns(area,df=6) + ns(peri,df=5) , data  = rock)
#ns() is function used to fit a Natural Cubic Spline
summary(lm1)
plot(y, lm1$residuals)
#I got rid of the shape parameter as it was an ineffective variable.
#I used guessing and checking method to fit models with 
#different df parameters to find the one with the highest R2
#value. I found that area with df = 6 and peri with df=5 got me 
#the highest R2 value.

#d
#Looking at our findings, we have found that area and total 
#perimeter and the best predictors of the log
# of permeability of rocks. 
#For the best model, we can use an area variable of the 6th 
#degree and 5th degree of the total permieter variable. 
