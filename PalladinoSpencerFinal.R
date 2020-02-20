#Spencer Palldino 
#Stat 4360 
#Final Exam 

#Question 1
#Part A
subjinfo = read.delim("~/Downloads/subjinfo.txt")
subjinfo$ID=as.factor(subjinfo$ID)
subjinfo$Trt=as.factor(subjinfo$Trt)
subjinfo$Sex=as.factor(subjinfo$Sex)
#as.factor make the vars factors
subjinfo$Base=as.numeric(subjinfo$Base)
subjinfo$Age=as.numeric(subjinfo$Age)
#as.numeric makes the vars numbers
head(subjinfo, 1) #another method of printing
#ID Sex Age Trt Base
#1  6   M  40   0   38

#Part B
summary(subjinfo$Sex)
summary(subjinfo$Age)
summary(subjinfo$Trt)
summary(subjinfo$Base)

#Part C
with(subjinfo, table(Sex, Trt))

#Part D
placebo1 = read.delim("~/Downloads/placebo1.txt")
nosnooz = read.delim("~/Downloads/nosnooz.txt")
vertmerge=rbind(placebo1,nosnooz)
#vertically bind the two matricies 
sub = subset(vertmerge, vertmerge$ID==30)
sub1 = subset(vertmerge, vertmerge$ID==488)
#create subset of when ID =30 and 488
#Orginially tried as one subset but was printing 
#incomplete results
print(rbind(sub,sub1))
#prints when ID = 30 and 488

#Part E
info = merge(subjinfo, vertmerge, by="ID")
#merge info + stuff form part d
sub3 = subset(info, info$ID==183)
#make a subset with ID= 183 for printing
print(sub3)

#Part F
sub4 = subset(info, info$Sex == "F" & info$Trt ==0)
sub5 = subset(info, info$Sex == "M" & info$Trt ==0)
sub6 = subset(info, info$Sex == "F" & info$Trt ==1)
sub7 = subset(info, info$Sex == "M" & info$Trt ==1)
#create subsets for each of the level possibilities
summary(sub4) #summary for females on placebo
summary(sub5) #summary for males on placebo
summary(sub6) #summary for females on treatment
summary(sub7) #summary for males on treatment

#Part G
smallesty = info[order(info$Y),]
#sort by Y with smallest first
head(smallesty) #see how many obs tied for smallest y
#4 obs tied for smallest y 
sub8 = subset(smallesty, select=c("ID", "Week"))
#make subset for just those two columns in smallesty
head(sub8,4)
#prints those 4 obs tied for smallest y 
#and just the ID and Week columns


largesty = info[order(-info$Y),]
#sort by Y with largest first
head(largesty) #see how many obs tied for largest y
#2 tied
sub9 = subset(largesty, select=c("ID", "Week"))
#make subset for just those two columns in largesty
head(sub9,2)
#prints those 2 obs tied for largest y 
#and just the ID and Week columns

#Part H 
smallestbase = info[order(info$Base),]
#sort by base with smallest first
head(smallestbase) #see how many obs tied for smallest base
#4 obs tied for smallest base 
sub10 = subset(smallestbase, select=c("ID", "Week"))
#make subset for just those two columns in smallestbase
head(sub10,4)
#prints those 4 obs tied for smallest base 
#and just the ID and Week columns


largestbase = info[order(-info$Base),]
#sort by base with largest first
head(largestbase) #see how many obs tied for largest base
#4 tied
sub11 = subset(largestbase, select=c("ID", "Week"))
#make subset for just those two columns in largestbase
head(sub11,4)
#prints those 2 obs tied for largest base
#and just the ID and Week columns

#Part i
info$Change = info$Y-info$Base
#creates change variable 

sub12 = subset(info, info$Sex == "F" & info$Trt ==0)
sub13 = subset(info, info$Sex == "M" & info$Trt ==0)
sub14 = subset(info, info$Sex == "F" & info$Trt ==1)
sub15 = subset(info, info$Sex == "M" & info$Trt ==1)
#create subsets for each of the level possibilities
summary(sub12$Change) #summary of Change for females on placebo
summary(sub13$Change) #summary of Changefor males on placebo
summary(sub14$Change) #summary of Change for females on treatment
summary(sub15$Change) #summary of Change for males on treatment

#Part j
smallestchange = info[order(info$Change),]
#sort by change with smallest first
head(smallestchange) #see how many obs tied for smallest change
#2 obs tied for smallest change 
sub16 = subset(smallestchange, select=c("ID", "Week"))
#make subset for just those two columns in smallestchange
head(sub16,2)
#prints those 2 obs tied for smallest change 
#and just the ID and Week columns

largestchange = info[order(- info$Change),]
#sort by change with largest first
head(largestchange) #see how many obs tied for largest change
#1 obs with highest change
sub17 = subset(largestchange, select=c("ID", "Week"))
#make subset for just those two columns in largestchange
head(sub17,1)
#prints those 2 obs tied for largest change
#and just the ID and Week columns


# Question 2
load("/Users/spencerpalladino/Downloads/exoplanets.Rdata")
#Part A 
head(exoplanets)
exoplanets$StarType = as.factor(exoplanets$StarType)
summary(exoplanets$StarType)
barplot(summary(exoplanets$StarType), col = c("gold", "orange","red"),
        main = "Number of Stars of Each Star Type", 
        ylab = "Number of Stars", xlab = "Type of Star")
#makes barplot
#Part B 
#Earth Masses histogram
hist(exoplanets$EMass, main = "Historgram of Stars by Emass",
     ylab = "Number of Stars", xlab = "Planet Mass",breaks = 30,
     col=c("grey"))
#Gravity
hist(exoplanets$EGrav, main = "Historgram of Stars by EGrav",
     ylab = "Number of Stars", xlab = "Gravity in terms of Earths",breaks = 20,
     col=c("grey"), xlim= c(.25,1.75))
#Temp
hist(exoplanets$MSTK, main = "Historgram of Stars by Mean Surface Temperature",
     ylab = "Number of Stars", xlab = "Mean Surface Temperature",
     breaks = 20, col=c("grey"), xlim = c(200,400))
#Surface Pressure
hist(exoplanets$ESP, main = "Historgram of Stars by Surface Pressure",
     ylab = "Number of Stars", xlab = "Surface Pressure",breaks = 20,
     xlim = c(2,5.5))
#makes histogram in each set
#Part C
dotchart(exoplanets$ESI, labels = NULL, groups = exoplanets$StarType, 
         gcolor = c("gold", "orange","red"), 
         color = c("black"), pch = 20, ylab = "Type of Star",
         xlab= "Earth Similarity Index", 
         main = "Clevland Plot for Type of Star vs ESI" )
#makes dotchart
#Part D
#create color varibales
exoplanets$Color="black" #standard color 
exoplanets$Color[exoplanets$StarType=="G"]="gold"
exoplanets$Color[exoplanets$StarType=="K"]="orange"
exoplanets$Color[exoplanets$StarType=="M"]="red"
plot(exoplanets$EMass, exoplanets$EGrav, 
     main = "Scatterplot of Gravity by Mass of Stars",
     xlab= "Mass in Earth Mass", ylab= "Gravity in Earth Gravity",
     col = exoplanets$Color, pch =20)
#makes scatterplot with new color variable
legend("topright",title = "Star Type", c("G","K", "M") ,
       pch = c(20,20,20,20), col=c("gold", "orange","red"))
#adds legend
#Part E
plot(exoplanets$EMass, exoplanets$ESP, 
     main = "Scatterplot of Surface Pressure by Mass of Stars",
     xlab= "Mass in Earth Mass", ylab= "Surface Pressure in Earth Pressure",
     col = exoplanets$Color, pch =20)
#makes scatterplot
legend("bottomright",title = "Star Type", c("G","K", "M") ,
       pch = c(20,20,20,20), col=c("gold", "orange","red"))
#makes legend
#Part F
plot(exoplanets$EGrav, exoplanets$ESP, 
     main = "Scatterplot of Surface Pressure by Gravity of Stars",
     xlab= "Gravity in Earth Gravity", 
     ylab= "Surface Pressure in Earth Pressure",
     col = exoplanets$Color, pch =20)
#makes scatterplot
legend("bottomleft",title = "Star Type", c("G","K", "M") ,
       pch = c(20,20,20,20), col=c("gold", "orange","red"))
#adds legend
#Part G
plot(exoplanets$SemiMajAxis, exoplanets$MSTK, 
     main = "Scatterplot of Mean Surface Temperature 
     by Semi-Major Axis of Stars",
     xlab= "Semi-Major Axis in AU", 
     ylab= "Mean Surface Temperature in Kelvin",
     col = exoplanets$Color, pch =20, ylim = c(200,400))
#makes scatterplot
legend("topright",title = "Star Type", c("G","K", "M") ,
       pch = c(20,20,20,20), col=c("gold", "orange","red"))
#adds legend
#Part H
plot(exoplanets$Period, exoplanets$MSTK, 
     main = "Scatterplot of Mean Surface Temperature 
     by Orbital Period of Stars",
     xlab= "Orbital Period in days", 
     ylab= "Mean Surface Temperature in Kelvin",
     col = exoplanets$Color, pch =20, xlim = c(0,500),
     ylim=c(200, 400))
#make scatterplot
legend("topright",title = "Star Type", c("G","K", "M") ,
       pch = c(20,20,20,20), col=c("gold", "orange","red"))
#add legend
#Part i
plot(exoplanets$SemiMajAxis, exoplanets$Period, 
     main = "Scatterplot of Orbital Period
     by Semi-Major Axis of Stars",
     xlab= "Semi-Major Axis in AU", 
     ylab= "Orbital Period in Days",
     col = exoplanets$Color, pch =20, ylim = c(0, 6000),
     text(x = .77,  y = 5542, labels = "HD 65216 c"))
#make scatterplot
legend("topright",title = "Star Type", c("G","K", "M") ,
       pch = c(20,20,20,20), col=c("gold", "orange","red"))
#add legend
#Part j
par(mfrow = c(1, 2)) #next plots will be side by side
G = subset(exoplanets, exoplanets$StarType =="G")
K = subset(exoplanets, exoplanets$StarType =="K")
M = subset(exoplanets, exoplanets$StarType =="M")
#subsetting by type of star
boxplot(G$SemiMajAxis,K$SemiMajAxis,M$SemiMajAxis,
        col = c("gold", "orange", "red"),
        main= "Boxplot of Semi-Major Axis 
       by Star Type",
        outpch = 20, xlab = "Star Type", 
        ylab = "Semi Major Axis", names = c(
          "G", "K", "M"
        ))
#make first boxplot
boxplot(G$Period,K$Period,M$Period,
        col = c("gold", "orange", "red"),
        main= "Boxplot Comparison of Semi
        -Major Axis by Star Type",
        outpch = 20, xlab = "Star Type",
        ylab = "Orbital Period", names = c(
          "G", "K", "M"
        ))
#make second boxplot
#Part K
par(mfrow = c(1, 1)) #reset graph area so that i get 1x1s

sums=aggregate(exoplanets$EMass,
          by=list(Category=exoplanets$DiscoveryYear), FUN=sum)
plot(sums, xlab = "Planetary Mass Discovered", ylab = "Year",
     type = "l", main = "Line Plot of Planetary Mass Discovered
     by Year", ylim = c(0, 400))
#make a line plot of the sums of EMASS
#Part L
library(scatterplot3d) #figure out how to add text
scatterplot3d(exoplanets$Period,exoplanets$SemiMajAxis,
              exoplanets$MSTK, 
              main= "3D Scatterplot of Surface Temperature,
              Semi-Major Axis, and Orbital Period",
              xlab = "Orbital Period in Days",
              ylab = "Semi-Major Axis" ,
              zlab = "Mean Surface Temperature in Kelvin",
              xlim = c(0, 400),  
              pch =20, color = exoplanets$Color)
#make a 3D plot
text(x = exoplanets$Period, 
     y = exoplanets$SemiMajAxis,
     labels = exoplanets$ESI)
legend("topright",title = "Star Type", c("G","K", "M") ,
       pch = c(20,20,20,20), col=c("gold", "orange","red"))
#add a legend 
# Question 3
#Part A
my.fact = function(n){
   if(n >= 1 & n%%1==0){ #if you win add the bet value
    return(n*my.fact(n-1))
  } else if(n==0){
    return(1) 
  } else if(n<0){
    print("Cannot accept negative or non-integer values")
  } else if(n%%1!=0){
    print("Cannot accept negative or non-integer values")
  }
}
my.fact(0)
#[1] 1
my.fact(2)
#[1] 2
my.fact(-1)
#"Cannot accept negative or non-integer values"
my.fact(.5)
#"Cannot accept negative or non-integer values"

#Part B
my.choose=function(n,k){
  if (n >= k){
    return(my.fact(n)/(my.fact(k)*my.fact(n-k)))
  } else{
    print("n must be at least as large as k")
  }
}
my.choose(0,0)
#[1] 1
my.choose(4,2)
#[1] 6
my.choose(3,4)
#"n must be at least as large as k"

#Part C
my.binom = function(n,k,p){
  if (p >= 0 & p <= 1){
    my.choose(n,k)*(p^k)*((1-p)^(n-k))
  } else{
    print("pmust be in [0,1]")
  }
}

my.binom(2,1,0.8)
#[1] 0.32
my.binom(1,0,0.4)
#[1] 0.6
my.binom(1,1,-0.7)
#"pmust be in [0,1]"

#Question 4
load("/Users/spencerpalladino/Downloads/citygrowth.Rdata")

#Part A
citygrowth$difference = citygrowth$c.1930 - citygrowth$c.1920
#make a variable for the difference between populations
median(citygrowth$difference) 
#just to see what my varibles should be around
r = 100
#B = number of rows in my matrix (for each bootstrap sample)
#I figured 100 would be large enough for an accurate CI with 
#a sample size of 49
n = nrow(citygrowth) 
#use as a column (one for each sampled value
#to matach original size)
boot.samples = matrix(sample(citygrowth$difference, 
                     size = r * n, replace = TRUE), r, n)
#sampling with replacement of my differences variable
#and sampling to fill my r*n matrix
boot.statistics = apply(boot.samples, 1, median)
#applying median fucntion to my matrix, thus 100 medians
#the 1 means the function is applied to each row
difference.se = sd(boot.statistics) #2.659004
#find sd of my data which should = se for the CI
difference.median = mean(boot.statistics) #15.98
#find a point estimate(mean) of all the medians I bootstrapped
difference.median + (1.96*difference.se) #21.19165
difference.median - (1.96*difference.se) #10.76835
#1.96 is my t*
#95% CI for the median difference between populations in 1920s
#and 1930s using bootstrapping to sample: (10.76835, 21.19165)

#Part B
B1 = 100
#B = number of rows in my matrix (for each bootstrap sample)
t20.samples = matrix(sample(citygrowth$c.1920, 
                            size = 49 * B1, replace = TRUE), B1, 49)
t30.samples =  matrix(sample(citygrowth$c.1930,
                             size = 49 * B1, replace = TRUE), B1, 49)
#bootstrapped each sample 
t20.medians = apply(t20.samples, 1, median)
t30.medians = apply(t30.samples, 1, median)
#get the medians for each seperate group (1920s and 1930s)
boot.stat = t30.medians - t20.medians
#create data for the difference between the medians from 
#the bootstrapped data
mu=mean(boot.stat) #13.46
#find a point estimate(mean) of all the medians I bootstrapped
sigma = sd(boot.stat) #13.64886
#find sd of my data which should = se for the CI
mu + (1.96*sigma) #35.49991
mu - (1.96*sigma) #-13.07991
#95% CI for the difference between median population in 1920s
#and median population in the 1930s using bootstrapping 
#to sample: (-13.29176, 40.21176)

#not 100% one is correct cause of the variance is a tad high