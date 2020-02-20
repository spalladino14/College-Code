# -*- coding: utf-8 -*-
"""
Created on Fri Oct 18 17:13:24 2019

@author: spenc
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
gundata = pd.read_csv('C:/Users/spenc/Downloads/data/full_data.csv')
print(gundata.race)
gundata.hist(x='Intent')
#a


#b
sub1=gundata[gundata.race == 'White']
sub2=sub1[sub1.intent == 'Homicide']
g1 = plt.hist(sub2.age)
plt.gca().set(title = 'Age Dist of White People that Commited Homicide',
       ylabel = 'Count', xlabel = 'age')
sub3=sub1[sub1.intent == 'Suicide']
g2 = plt.hist(sub3.age)
plt.gca().set(title = 'Age Dist of White People that Commited Suicide',
       ylabel = 'Count', xlabel = 'age')
#python is being annoying but this method works to get the correct subset
#plt.gca is making the totles and plt.hist makes the plots using the subsets

sub4=gundata[gundata.race == 'Black']
sub5=sub4[sub4.intent == 'Homicide']
g3 = plt.hist(sub5.age)
plt.gca().set(title = 'Age Dist of Black People that Commited Homicide',
       ylabel = 'Count', xlabel = 'age')
sub6=sub4[sub4.intent == 'Suicide']
g4 = plt.hist(sub6.age)
plt.gca().set(title = 'Age Dist of Black People that Commited Suicide',
       ylabel = 'Count', xlabel = 'age')

sub7=gundata[gundata.race == 'Hispanic']
sub8=sub7[sub7.intent == 'Homicide']
g5 = plt.hist(sub8.age)
plt.gca().set(title = 'Age Dist of Hispanic People that Commited Homicide',
       ylabel = 'Count', xlabel = 'age')

sub9=sub7[sub7.intent == 'Suicide']
g6 = plt.hist(sub9.age)
plt.gca().set(title = 'Age Dist of Hispanic People that Commited Suicide',
       ylabel = 'Count', xlabel = 'age')

#c
#Looking at the plots, it appears that blacks and hispanics are far 
#more likely to commit suicide or homicide at a younger age(20-30) than white 
#people although they are less likely at older ages. White people are most 
#likely to commit homicide or suicide around 40-50 interestingly.