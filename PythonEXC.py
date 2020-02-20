# -*- coding: utf-8 -*-
"""
Created on Wed Nov 20 14:56:05 2019

@author: spenc
"""
#Spencer Palladino 
#Extra Credit HW 
#Question 1 of HW 3
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
gundata = pd.read_csv('C:/Users/spenc/Downloads/data/full_data.csv')

#a
#Age Dist of Suicides by Gender Comparison
sub1=gundata[gundata.sex == 'M']
sub2=sub1[sub1.intent == 'Suicide']
g1 = plt.hist(sub2.age)
plt.gca().set(title = 'Age Dist of Men that Commited Suicide',
       ylabel = 'Count', xlabel = 'age')

sub3=gundata[gundata.sex == 'F']
sub4=sub3[sub3.intent == 'Suicide']
g2 = plt.hist(sub4.age)
plt.gca().set(title = 'Age Dist of Women that Commited Suicide',
       ylabel = 'Count', xlabel = 'age')
#B
#Age Dist of Homicide by Gender Comparison
sub5=gundata[gundata.sex == 'M']
sub6=sub1[sub5.intent == 'Homicide']
g3 = plt.hist(sub6.age)
plt.gca().set(title = 'Age Dist of Men that Commited Homicide',
       ylabel = 'Count', xlabel = 'age')

sub7=gundata[gundata.sex == 'F']
sub8=sub7[sub7.intent == 'Suicide']
g4 = plt.hist(sub8.age)
plt.gca().set(title = 'Age Dist of Women that Commited Homicide',
       ylabel = 'Count', xlabel = 'age')

#C
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
pivot = gundata.pivot_table(index='intent', columns = 'sex', aggfunc='count')
newdf = pivot[pivot.columns[2:4]]
print(newdf) # age shows up because the pivot table repeats the same calculation 
#for every single variable and I just wanted to show it once.




















