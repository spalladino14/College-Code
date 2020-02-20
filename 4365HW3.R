#Spencer Palladino 
#Stat 4365 
#Homework 3 
#Problems 1 and 3 
library(tidyverse)
#Question 1
gundata <- read.csv("~/Downloads/full_data.csv")
head(gundata)
#a
sub1 = subset(gundata, 
    gundata$intent == "Suicide")
#create a subset of data of men and women who committed suicide

#create a subset of data of females who committed suicide
ggplot(sub1, aes(x=age)) + 
  geom_histogram(color= "blue", fill = "blue") + facet_wrap(vars(sex))+
labs(title = "Age Distribuiton for Suicide Rates of Men and Women")

#b
sub2 = subset(gundata, 
              gundata$intent == "Homicide")
#create a subset of data of men and women who committed homicide

ggplot(sub2, aes(x=age)) + 
  geom_histogram(color= "red", fill = "red") + facet_wrap(vars(sex))+
  labs(title = "Age Distribuiton for Homicide Rates of Men and Women")

#c
#The most obvious thing to point out when lookings at both 
#the homicide and suicide data is how much more data there is for 
#men that committed homicide and suicide. I am assuming this means 
#men commit more of these acts than women. 
#It looks like the median age for men and women to commit 
#homicide is about the same being aroudn 30 years old. 
##The median age for men and women to commit 
#suicide is also about the same being maybe a little 
#less than 50 years old. 

#d

sub10 = subset(gundata, gundata$age != "NA" & gundata$intent!= "Undetermined")
#subset data to get rid of entries we dont want
sub10 %>%
  group_by(sex, intent) %>%
  summarize(mean_age = mean(age, na.rm = TRUE))

#Question 3 
collegedata <- read.csv("~/Downloads/MERGED2015_16_PP.csv")
#a
ggplot(collegedata, aes(x=as.numeric(as.character(GRAD_DEBT_MDN)))) + 
  geom_histogram(color= "pink", fill = "pink") + facet_wrap(vars(CONTROL))+
  labs(title = "Median Debt of Graduated Students by University Type",
       x = "Type of Institution")
#use facet_wrap to do the subplots
#b
ggplot(collegedata, aes(x=as.numeric(as.character(C100_4)))) + 
  geom_histogram(color= "orange", fill = "orange") + facet_wrap(vars(CONTROL))+
  labs(title = " 4 Year Completion Rate % of Students by University Type",
       x = "Type of Institution")
#c
collegedata %>%
  group_by(CONTROL) %>%
  summarize(meandebt = mean(as.numeric(as.character(GRAD_DEBT_MDN)), na.rm = TRUE),
            AvgCompletionRate = mean(as.numeric(as.character(C100_4)),na.rm = TRUE))

#d
#Looking at the mean debt and average 4 year completion percentages,
#we can see that public universities (1), have the smallest mean debts.
#Private for profit was closely behind that in terms of mean debts of 
#graduating students and not-for-profit private schools interestingly 
#had the highest student debts by a long shot. Although they had the 
#highest average student debt, not-for-profit private schools had the 
#highest average completion rate for 4 years with the other two types
#of schools behind that. 

#e
prob3 <- read.csv("~/Downloads/MERGED2007_08_PP.csv")
as.numeric(as.character(prob3$MN_EARN_WNE_P10))
j= subset(prob3, GRAD_DEBT_MDN != "NULL" & GRAD_DEBT_MDN != "PrivacySuppressed" & MN_EARN_WNE_P10 != "NULL" & MN_EARN_WNE_P10 != "PrivacySuppressed") 
#gets rid of the NAs
s=as.numeric(as.character(j$GRAD_DEBT_MDN))
t= as.numeric(as.character(j$MN_EARN_WNE_P10))
j %>%
  group_by(j$CONTROL) %>%
  summarize("StudentLoanDebt/10YearEarnings" = mean(s/t))

#f
ggplot(prob3, aes(x=as.numeric(as.character(GRAD_DEBT_MDN)), y=as.numeric(as.character(MN_EARN_WNE_P10)))) + 
  geom_point(color = prob3$CONTROL) +
  labs(title = "10 Year Avg Income vs Median Dept by School Type",
       x = "Median Debt", y = "Mean 10 Year Income")
