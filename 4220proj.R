#Spencer Palladino 
#Stat 4220
#Final Project

#Question 1 
alloy <- read.delim("~/Downloads/alloy.txt")
head(alloy)
#a
((13.413 + 35.088+ 8.466 +18.613 + 33.919 + 27.534 + 24.183 + 30.706) -
    (29.926+23.724+20.554+26.363+17.512+39.463+12.029+22.125))/16
#b
mod = lm( alloy$Length ~ alloy$A * alloy$B * alloy$C * alloy$D)
summary(mod)
eff = 2*mod$coefficients[-1]
mod1 = lm(alloy$Length ~ alloy$A +alloy$B + alloy$C + alloy$D +
            alloy$A:alloy$B + alloy$A:alloy$C +alloy$A:alloy$B:alloy$C)
plot(mod1)
#e
library(FrF2)
MEPlot(mod1)

#Question 2 
uec <- read.delim("~/Downloads/uec.txt") #the data is broken on this
#a
uec = uec[1:16,]
mod2 = lm(uec$UEC~ uec$A*uec$B*uec$C*uec$D)
eff = 2*mod3$coefficients[-1]
eff
###########
Plots.halfnorm = function(x) ## This function generates the half normal plot
{n = length(x)
halfn = .5+.5*(1:n-.5)/n
plot(qnorm(halfn), sort(abs(x)), type="p", pch=20,
     xlab="half-normal quantiles", ylab="absolute effects")
identify(qnorm(halfn), sort(abs(x)), names(sort(abs(x))))
}
#########
halfnorm = function(x){
  n = length(x)
  halfn = .5+.5*(1:n-.5)/n
  plot(qnorm(halfn), sort(abs(x)), type="p", pch=20, xlab="half−normal quantiles", ylab="absolute effects") 
  identify(qnorm(halfn), sort(abs(x)), names(sort(abs(x)))) }
##########
Plots.halfnorm(eff) #use plot to get significant factors 
#now use a c d and ac for model
#b
mod3 = lm(uec$UEC ~ uec$A+ uec$C+ uec$D + uec$A:uec$C)
summary(mod3)
plot(mod3)
#c
B1 = A*B
B2 = C*D
mod15 = lm(uec$UEC~ uec$A:uec$B + uec$C:uec$D)
summary(mod15)
plot(mod15)
eff = 2*mod15$coefficients[-1]
Plots.halfnorm(eff)
#Question 3 
leafspring = read.delim("~/Downloads/leafspring.txt")
#b
y=(leafspring$Height1 + leafspring$Height2 + leafspring$Height3)/3
A = leafspring$A
B = leafspring$B
C = leafspring$C
D = leafspring$D
E = leafspring$E
mod4 = lm(y~ A +B + C + D+ E + A:B +A:C + A:D + A:E + B:C + B:D + B:E + C:D + C:E + D:E)
summary(mod4)
mod5 = lm(y~A + B + E + B:E)
#c
plot(mod5)


#Question 4
asat <- read.csv("~/Downloads/asat.txt", sep="")
#
y = asat$Asat
A = asat$A
B = asat$B
C = asat$C
D = asat$D
E = asat$E
F = asat$F
G = asat$G
H = asat$H
K = asat$K
mod8 = lm(y~A+B+C+D+E+F+G+H+K)
summary(mod8)
eff = 2*mod8$coefficients[-1]
eff
Plots.halfnorm(eff)
mod9 = lm(y~C+D+E+F)

mod10 = lm(y~A:B+A:C+A:D+A:E+A:F+A:G+A:H+A:K+B:C+B:D+B:E+B:F+B:G+B:H+B:K+ 
             C:D+C:E+C:F+C:G+C:H+C:K+D:E+D:F+D:G+D:H+D:K+ E:F+E:G+
             E:H+E:K+F:G+F:H+F:K+G:H+G:K+H:K)
#this doesnt actually work becasue there is more terms than df
mod11 = lm(y~C:D+C:E+C:F+D:E+D:F+E:F)
summary(mod11)
eff = 2*mod11$coefficients[-1]
eff
Plots.halfnorm(eff)
plot(mod11)
