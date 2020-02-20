#Spencer Palladino 
#Stat 4365 
#Homework 7 
collegedata = read.csv("~/Downloads/MERGED2015_16_PP.csv")

#Question 1 
y = as.numeric(collegedata$C200_4)
x1 = collegedata$CONTROL
x2 = as.numeric(collegedata$AVGFACSAL)
x3 = as.numeric(collegedata$INC_PCT_LO)
x4 = as.numeric(collegedata$INC_PCT_M1)
x5 = as.numeric(collegedata$INC_PCT_M2)
x6 = as.numeric(collegedata$INC_PCT_H1)
x7 = as.numeric(collegedata$INC_PCT_H2)
x8 = as.numeric(collegedata$SATVRMID)
x9 = as.numeric(collegedata$SATMTMID)
x10 = as.numeric(collegedata$UGDS_WOMEN)
x11 = as.numeric(collegedata$UGDS_WHITE)
x12 = as.numeric(collegedata$ADM_RATE)
x13 = as.numeric(collegedata$PFTFAC)
x14 = as.numeric(collegedata$TUITIONFEE_IN)
#running models on each variable individually
summary(lm(y~x1))
summary(lm(y~x2))
summary(lm(y~x3))
summary(lm(y~x4))
summary(lm(y~x5))
summary(lm(y~x6))
summary(lm(y~x7))
summary(lm(y~x8))
summary(lm(y~x9))
summary(lm(y~x10))
summary(lm(y~x11))
summary(lm(y~x12))
summary(lm(y~x13))
summary(lm(y~x14))
#b
fullmodel = lm(y~x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13+x14)
summary(fullmodel)
#c
model.null = lm(y ~ 1)
step(model.null,
     scope = list(upper=fullmodel),
     direction="both",
     test="Chisq")
step(fullmodel, method="backward")
step(model.null, scope=list(upper=fullmodel),
     direction="forward")
#d
#Using forward, backward, and both step methods, I found that the full model actually 
#has the lowest AIC of any model meaning it has 
# the least error and is the best fit for predicting
#our response variable. It makes me feel more comfortable knowing that each of the 
#three methods resulted in the same outcome. 


#Question 2 
collegedata1 <- read.csv("~/Downloads/MERGED2007_08_PP.csv")
y = as.numeric(collegedata1$MD_EARN_WNE_P10)/as.numeric(collegedata1$TUITIONFEE_IN)
x1 = collegedata1$CONTROL
x2 = as.numeric(collegedata1$AVGFACSAL)
x3 = as.numeric(collegedata1$INC_PCT_LO)
x4 = as.numeric(collegedata1$INC_PCT_M1)
x5 = as.numeric(collegedata1$INC_PCT_M2)
x6 = as.numeric(collegedata1$INC_PCT_H1)
x7 = as.numeric(collegedata1$INC_PCT_H2)
x8 = as.numeric(collegedata1$SATVRMID)
x9 = as.numeric(collegedata1$SATMTMID)
x10 = as.numeric(collegedata1$UGDS_WOMEN)
x11 = as.numeric(collegedata1$UGDS_WHITE)
x12 = as.numeric(collegedata1$ADM_RATE)
x13 = as.numeric(collegedata1$PFTFAC)

#a
#running models on each variable individually
summary(lm(y~x1))
summary(lm(y~x2))
summary(lm(y~x3))
summary(lm(y~x4))
summary(lm(y~x5))
summary(lm(y~x6))
summary(lm(y~x7))
summary(lm(y~x8))
summary(lm(y~x9))
summary(lm(y~x10))
summary(lm(y~x11))
summary(lm(y~x12))
summary(lm(y~x13))
#b
fullmodel2 = lm(y~x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13)
summary(fullmodel2)
34282.55
#c
model.null2 = lm(y ~ 1)
step(model.null2,
     scope = list(upper=fullmodel2),
     direction="both",
     test="Chisq")
step(fullmodel2, method="backward")
step(model.null2, scope=list(upper=fullmodel2),
     direction="forward")
#d
#Looking at our 3 subset selection methods, we got that the model with just 
#UGDS_WOMEN,INC_PCT_H1, and AVGFACSAL resulted in the best model when using 
#step selection methods from both sides and from forwards. Backwards step method
#resulted in y ~ x2 + x3 + x4 + x5 + x6 + x9 + x10 being the resulting formula but 
#this resulted in a higher AIC than our smaller model of just y ~ x10 + x6 + x2. 
#Thus is believe y ~ x10 + x6 + x2 is our best model for predicting the value of y. 




