
# Regression with Time Series Errors

# package we'll need.
library(forecast) 
install.packages('forecast', dependencies = TRUE)

help(LakeHuron)

# First things first: Look at the data!
layout(matrix(c(1,1,2,3),2,2,byrow = T))
plot(LakeHuron, main='Levels of Lake Huron')  # I spy a trend
acf(LakeHuron, main='ACF')  # Maybe a weak trend
pacf(LakeHuron, main='PACF')

# 1. Remove the least-squares trend. The residuals are the time series
#    we will model!
Years = 1875:1972
Y2 = Years*Years
lsfit = lm(LakeHuron~Years + Y2)
summary(lsfit)
dev.off()
plot(LakeHuron, main='Levels of Lake Huron')
lines(Years,lsfit$fitted.values)

eps = ts(lsfit$residuals)

# 2. Find a time series model for the residuals.
layout(matrix(c(1,1,2,3),2,2,byrow = T))
plot(eps, main='Levels of Lake Huron')  # I spy a trend
acf(eps, main='ACF')  # Maybe a weak trend
pacf(eps, main='PACF')
##########
errmodel = auto.arima(eps)  # Chooses the best-fit ARIMA model.
                           
# Spot-check the fit
plot(errmodel$residuals, main='Innovations from AR(2) Fit to Residuals')
acf(errmodel$residuals, main='ACF')
pacf(errmodel$residuals, main='PACF')
# And this spot-check looks good.

#time series model / regression with
#correlated errors
regcorrerr = arima(LakeHuron, xreg = cbind(Years,Y2), order = c(2,0,0))
summary(regcorrerr)
plot(regcorrerr$residuals)
acf(regcorrerr$residuals)
pacf(regcorrerr$residuals)
# Compare the inferences for the parameters between the two models.
cbind(lsfit$coefficients,confint(lsfit))
cbind(regcorrerr$coef,confint(regcorrerr))
