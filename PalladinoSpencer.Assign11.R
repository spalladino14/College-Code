#Spencer Palladino
#Stat 4360
#Assignment 11
#Question 1 
#a
planets = read.delim("~/Downloads/exoplanet.txt", 
                     header=FALSE)
planets$V1 = as.character(planets$V1)
#makes V1 not convert to a factor
planets$V2 = as.numeric(planets$V2)
planets$V3 = as.numeric(planets$V3)
planets$V4 = as.numeric(planets$V4)
planets$V5 = as.numeric(planets$V5)
planets$V6 = as.numeric(planets$V6)
planets$V7 = as.numeric(planets$V7)
planets$V8 = as.numeric(planets$V8)
#making sure the other variables are 
#read as numeric because I can
#b
head(planets, 3) #show first 3 obs
#c 
is.factor(planets$V1) #test if V1 is a factor
# FALSE 
#d
names(planets) = c("Name", "JMass", "SAxis", "Operiod",
                  "OEcc", "Deg", "TimePer", "VelSemi")
#function names names my variables
head(planets, 3) #show first 3 obs

#Question 2 
discovery = read.csv("~/Downloads/exoplanetdiscovery.csv",
                              header=TRUE)
names(discovery) = c("Name", "Year")
discovery$Name = as.character(discovery$Name)
#make Name var a non factor
discovery$Year = as.factor(discovery$Year)
#making year a factor var
#b
head(discovery, 2) #show first 2 observations
#c
is.factor(discovery$Name)
#FALSE
is.factor(discovery$Year)
#TRUE

#Question 3 
exoplanets = merge(planets, discovery, by="Name")
#merge data by name
exoplanets= na.omit(exoplanets)
#remove rows that lack variable entry
print(exoplanets[100:105,])
#print rows 100-105

#Quesion 4 
row.names(exoplanets) = exoplanets$Name
#change the row names
exoplanets[1] <- NULL
#get rid of the first column
print(exoplanets[c(10,20,30,500,510),])
#prints specific rows

#Question 5
#a
exoplanets$SGiant = ifelse(exoplanets$JMass >= 5, 1,0)
#creates var SGiant with an if else statement 
#b
exoplanets$EOrbit = ifelse(exoplanets$Operiod < 400 
                           & exoplanets$Operiod > 330
                           , 1,0)
#creates var SGiant with an if else statement 
#c
is.factor(exoplanets$SGiant)
#FALSE
is.factor(exoplanets$EOrbit)
#FALSE
#Since I need both vars to be factors, 
exoplanets$SGiant=as.factor(exoplanets$SGiant)
exoplanets$EOrbit=as.factor(exoplanets$EOrbit)
#makes both of them factors 
is.factor(exoplanets$SGiant)
#TRUE
is.factor(exoplanets$EOrbit)
#TRUE
#d
print(exoplanets[c(80:83),])
#prints observations 80-83

#Question 6
rm(planets, discovery)
#remove those objects from workspace
ls()
#check to see if they are still there

#Question 7 
summary(exoplanets)
#give summary of full data set

#Question 8 
sub6 = subset(exoplanets, exoplanets$SGiant ==0 & exoplanets$EOrbit ==0)
sub7 = subset(exoplanets, exoplanets$SGiant ==1 & exoplanets$EOrbit ==0)
sub8 = subset(exoplanets, exoplanets$SGiant ==0 & exoplanets$EOrbit ==1)
sub9 = subset(exoplanets, exoplanets$SGiant ==1 & exoplanets$EOrbit ==1)
#create subsets for each of the level possibilities
summary(sub6)
summary(sub7)
summary(sub8)
summary(sub9)
#get summary for each 
#Question 9 
complete.cases(exoplanets)
#removes non complete rows,
#I may have already removed the incomplete rows from 
#a previous question thus no differeneces in the summaries
summary(exoplanets)

#Question 10
#a
biggest = exoplanets[order(- exoplanets$JMass),]
#sort by JMass
head(biggest,1)
#prints vars for biggest planet
#b
shortest = exoplanets[order(exoplanets$Operiod),]
#sort by Operiod with smallest first
head(shortest,1)
#c
longest = exoplanets[order(- exoplanets$Operiod),]
#sort by Operiod with biggest first
head(longest,1)
#d
sub = subset(exoplanets, exoplanets$SGiant ==0 & exoplanets$EOrbit ==1)
#create a subset of those observations with SGIANT=0/EORBIT =1
print(sub)
#e
sub1 = subset(exoplanets, exoplanets$Year ==2012)
#create a subset of those observations with year=2012
print(sub1)
#f
nrow(sub1)
#counts rows in the subset
#28 planets discovered in 2012

#Question 11
sub2=sub[order(sub$Year),]
#order the subset by year
row.names(sub2)
#print just the row names which will be in order
