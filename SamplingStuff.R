#b
attach(ipums)
mysample=sample(income,1000)
average=mean(mysample)
s=sd(mysample)
se=s/sqrt(1000)
print(average)
print(se)
#c
table(race) #use to find total n in each strata
N=53461
N1=46186
N2=5874
N3=325
N4=886
N5=190
n=1000
Nh= c(N1,N2,N3,N4,N5)

Sh=sqrt(tapply(income,race,var))  #find Sd of each strata
print(Sh)
SumNhSh =(11144.506*N1)+(7132.177*N2)+(7429.539*N3)+(11251.016*N4)+(9542.374*N5)
print(SumNhSh)
n1= ((11144.506*N1)/SumNhSh)*n #calculate the n to be used in each strata for optimized allocation
n2= ((7132.177*N2)/SumNhSh)*n
n3= ((7429.539*N3)/SumNhSh)*n
n4= ((11251.016*N4)/SumNhSh)*n
n5= ((9542.374*N5)/SumNhSh)*n
nh=(c(n1,n2,n3,n4,n5))
print(nh) #show the n for each strata we need to use in our sample of 1000
s1=stratified(ipums,"race",c("1"=902,"2"=73,"3"=4,"4"=18,"5"=4))
means = tapply(s1$income, s1$race, mean)  #find the mean income of each strata according to race

th=means*nh #multiply the means of each strata by the optimized allocation ns
totalincome = sum(th) #add up the incomes of eaveryone in each strata
averageincome = totalincome/n #divide by the total amount of people sampled
print(averageincome) 
vars = tapply(s1$income, s1$race, var)
vars
varth=nh^2*vars/nh * (1-nh/Nh)
sum(varth)
se=sqrt(sum(varth))
print(se)





#Question 2 
attach(forest)
table(wilderness)
N1= 260796
N2= 29884
N3= 253364
N4= 36968
N= 581012
n=1000
Nh= c(N1,N2,N3,N4) 
p1=N1/N 
p2=N2/N 
p3=N3/N 
p4=N4/N 
nh=c((p1*1000),(p2*1000),(p3*1000),(p4*1000))
nh=c((449, 51, 436, 64))
s1=stratified(forest,"wilderness",c("1"=449,"2"=51,"3"=436,"4"=64))
s1
table(s1$wilderness, s1$cover) #Use to see how many of each type of wilderness is covered


phat1= .4276
phat2= .70588
phat3= .3853
phat4= 0.000
phats= c(phat1, phat2, phat3, phat4)#proportion in each strata with coverage
phats
th=phats*nh
totalcoverage = sum(th)
coveragephat = totalcoverage/1000
print(coveragephat)

coveragevar=sum((Nh/N)^2*(phats*(1-phats)/(nh-1))*(1-(nh/Nh)))
sqrt(coveragevar)