#Spencer Palladino
#Stat4360
#Assignment 12

#Question 1 
load("/Users/spencerpalladino/Downloads/dat1.Rdata")
attach(dat1)
x = dat1$X
#plot 1 
barplot(table(dat1$Y),main="Distribution of Variable Y", border = TRUE,
        col=c("black","red") , ylim=c(0,30)
        )

head(dat1)
#plot 2
regFit = lm(dat1$Y ~ dat1$X)
#make a OLS fit for the data 
GLM= (exp(1)^(.2+.07*(dat1$X)))/(1+(exp(1)^(.2+.07*(dat1$X))))
logisticFit = glm(GLM ~ dat1$X, data=dat1, family=binomial)
#make a logistic fit for the data using above equation
newdata = data.frame(
  x,
  predict(logisticFit, data.frame(X=x), type="response"))
#create a new data frame with the predicted logistic function
newdata1 = newdata[order(x),]
#order the function by x values so the lines looks correct and smooth
plot(dat1$X,dat1$Y, xlab = "X", ylab= "Y", main="Plot of X vs Y")

#plot data
abline(regFit, lty=2, col = "red")
#add red line as dashed with lty=2
lines(newdata1, col="blue")
#add logistic line by adding the new data set
legend("topleft", c("OLS Line","GLM Line"), lty=2:1, col=c("red", "blue"))
#creates a legend in the top left with correct lines/colors/text

#Question 2 
load("/Users/spencerpalladino/Downloads/dat2.Rdata")
head(dat2)
#Plot 1 
hist(dat2$z, main= "Histogram of Random Normal Variables",
     xlab= "Random Normal Variables", ylim = c(0,.5), breaks = 30,
     col="yellow", freq =FALSE)
#create plot for y[0:5] in yellow with more breaks and as density 
x=seq(-4,+4,by=0.02)
curve(dnorm(x), add=TRUE)
#add normal curve to plot, I thought this way was specifically easier 
#for this problem 

#Plot 2 
mean = dat2$t
std = sqrt(var(dat2$t))
x = dat2$t
hist(dat2$t, main= "Histogram of Random t Variables",
     xlab= "Random t Variables", ylim = c(0,.4), breaks = 30,
     col="green", freq =FALSE)
#creates density plot in green with labels and correct breaks
x= seq(-10, 10, by=.02)
curve(dnorm(x,mean, std), add= TRUE)
#struggling to get this to work, I didnt even know this could be jagged

#Plot 3 
boxplot(dat2$z, dat2$t, col = c("Yellow", "Green"),
       main= "Comparison of Random Normal and Random t Data",
       names =  c("Normal", "t"), outpch = 20)
#creates side by side box plot in colors/names
#outpch does filling in bubbles for outliers

#Question 3
load("/Users/spencerpalladino/Downloads/dough.Rdata")
head(dough)
dough$Color="black" #standard color 
dough$Color[dough$Additive==1]="red"
dough$Color[dough$Additive==2]="green"
dough$Color[dough$Additive==3]="blue"
#made a new column with each observations color
plot(dough$Temperature, dough$RisingTime, 
     main="Affect of Temperature on Rising Time by Additive",
     ylab= "RisingTime", xlab ="Temperature", xlim=c(60,80),
     ylim=c(20,34),pch=20, col=dough$Color)
#makes a plot of correct labeling 
legend("topleft", c("Gluten","Barley", "Potato","None")
            ,pch = c(20,20,20,20), col=c("red", "green","blue","black"))
#adds a legend with colors
axis(1, at=c(60,65,70,75,80))
#change x axis if not correct 
axis(2, at=seq(20, 34, by= 2))
#change y axis if not correct

#Question 4 
pburgjuly22 = read.table("~/Downloads/pburgjuly22.txt", quote="\"", comment.char="")
attach(pburgjuly22)
head(pburgjuly22)   
time = NB2<-strptime(pburgjuly22$V1, "%I %p") 
plot(time, pburgjuly22$V2,
     , type = "b", ylab = "Temperature in Farenheit",xlab="Hour",
     main="Hourly Temperature for Pittsburg"
)
#not sure how to get the x axis to be correct.
