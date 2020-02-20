
library(geoR)
library(nlme)


install.packages('geoR', dependencies = TRUE)
install.packages('XQuartz', dependencies = TRUE)

attach(acid)
aciddep <- read.csv("~/Downloads/acid.dat", sep="")
# First things first!! Give it a quick EDA and look at it.
summary(aciddep[,3])
hist(aciddep[,3])
# To look at the data, as well as use the functions in geoR, we will
# need to create a geodata object.
acid = as.geodata(aciddep[,1:3])
acid  # Check what you have.
points(acid, main='Acid Deposition on a Grid')
# Sample variogram.
acidvgm = variog(acid, breaks=seq(0,2000,250), option='bin')
plot(acidvgm, main='Sample Variogram of Acid Deposition')

# 1. Remove the least-squares trend. The residuals are the spatial data
#    we will model!
lsfit = lm(aciddep[,3]~aciddep[,1] + aciddep[,2])
summary(lsfit)
acidres=cbind(aciddep[,1:2],lsfit$residuals)
eps = as.geodata(acidres)
resvgm = variog(eps, breaks=seq(0,2000,250), option='bin')
plot(resvgm, main='Sample Variogram of Residuals')
   # those last few points are crap

# 2. 
#matern - this one is the default
vfitmatern = variofit(resvgm, ini.cov.pars=c(3.5,1500), 
                      weights='cressie')
lines.variomodel(vfitmatern, col='blue')
#gaussian
vfitgauss = variofit(resvgm, ini.cov.pars=c(3.5,1500), 
                     cov.model='gaussian',weights='cressie')
lines.variomodel(vfitgauss, col='red')
#spherical
vfitsph = variofit(resvgm, ini.cov.pars=c(3.5,1500), 
                   cov.model='spherical',weights='cressie')
lines.variomodel(vfitsph, col='green')
# Eyeball-wise, I like either the spherical or the matern. But we can
# check the SS for each model:
'matern'
vfitmatern$value
'gaussian'
vfitgauss$value
'spherical'
vfitsph$value
# Although Gaussian and spherical are roughly equivalent, I think that
# the nugget should be zero, and so using spherical.


# 3. Taking this spatial autocorrelation model to do 
#    regression with correlated errors.
Y = aciddep[,3]
xcoord = aciddep[,1]
ycoord = aciddep[,2]

regcorrerr = gls(Y~xcoord+ycoord, correlation = corSpher())
summary(regcorrerr)
  
# Comparing the inferences for the parameters between the two models.
cbind(lsfit$coefficients,confint(lsfit))
cbind(regcorrerr$coef,confint(regcorrerr))

# The thing to note here is that the West-East (x) coordinate is
# significant, while the North-South (y) coordinate is not. The
# estimates themselves are a little different, as are the confidence
# intervals. 