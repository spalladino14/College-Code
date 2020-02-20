# -*- coding: utf-8 -*-
"""
Created on Thu Nov  7 10:32:17 2019

@author: spenc
"""
#Spencer Palladino 
#Homework 4
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import collections 
import numpy.random as npr
from scipy.stats import binom
#Question 1 
n= 10 
r = 1000000
#part i
df = np.random.uniform(0.0, 1.0, size = (n,r))
#generates an nxr matrix of uniform(0,1)
#part ii
colsuccesses=(df<.5).sum(axis = 0) #p=.5
print(colsuccesses)
#part iii
samplesuccesses=np.unique(colsuccesses, return_counts=True) 
#counts success of each column
samplesuccesses=pd.DataFrame(samplesuccesses)
#convert to panda df
samplesuccesses=samplesuccesses.drop(samplesuccesses.index[0])
#gets rid of extra row
print(samplesuccesses)
#part iv
sampleprobs=samplesuccesses/r
#gets sample probabilties
sampleprobs=pd.DataFrame(sampleprobs)
#covert to panda df
truevals=np.array([binom.pmf(0, n, .5),binom.pmf(1, n, .5),binom.pmf(2, n, .5),
     binom.pmf(3, n, .5),binom.pmf(4, n, .5),binom.pmf(5, n, .5),
     binom.pmf(6, n, .5),binom.pmf(7, n, .5),binom.pmf(8, n, .5),
     binom.pmf(9, n, .5),binom.pmf(10, n, .5)])
#gets values of the true binomial values
truevals=pd.DataFrame(truevals)
#covert to panda df
truevals=truevals.transpose()
table=sampleprobs.append(truevals) 
#row bind the panda dfs
table=table.rename(index={1:'Sample Binomial Probabilty',0:'True Binomial Probabilty' })
#renames columns
print(table)

#Question 2 
N=20
R=10
i= np.arange(10)
j= np.arange(.5, 5.5, 0.5)
#a
mat1 = np.random.normal(i, j, (20, 10))
#makes a matrix with specific mean and sd for each column
mat2 = pd.DataFrame(mat1) #turn into pandas data frame
mat2
colmeanss = np.mean(mat1, axis=0)
print(colmeanss) #column means
colsdss = np.std(mat1, axis=0)
print(colsdss)
#b
sum(((i*.8)< colmeanss) & ((i*1.2) > colmeanss) & ((j*.8) <colsdss) & ((j*1.2)>colsdss))
#total number of columns that have a mean and std within 20% of the generated data
#c
truths=(((i*.8)< colmeanss) & ((i*1.2) > colmeanss) & ((j*.8) <colsdss) & ((j*1.2)>colsdss))
truthss = pd.DataFrame(truths)
truthsss=truthss.transpose()
truthsss
new10=truthsss.rename(index={0:'Value'})
new1=mat2.append(new10) #combine truthsss with our original matrix
new1.loc["Value"]
new2= new1.drop([new1.loc["Value"] ==0],axis = 1)

# I tried for over 6 hours to select columns with specific value for a specific 
#row but literally had to give up. Hopefully my logic is at least worth 
#something. 
#d
(mat2 - colmeanss) / colsdss
#was not able to choose specific columns because I cant figure our part c in python
#but was able to do it for all values.  

#Question 3 
from matplotlib import animation
from IPython.display import HTML
NRAdata=pd.read_csv("C:/Users/spenc/Downloads/data/nra-grades.csv",
                    usecols = ['body_type','year','race','grade','party'])
grades=['A+','A','AQ','A-','B+','B','B-','C+','C','C-','D+','D','D-','F','?']
house=NRAdata[(NRAdata.iloc[:,0]=="US House")&(NRAdata.iloc[:,2]=="General")]
grades=['A+','A','AQ','A-','B+','B','B-','C+','C','C-','D+','D','D-','F','?']
all_counts_hs=house.grade.value_counts()  #get counts in each category
all_counts_hs=all_counts_hs[grades]  
xpos=np.arange(len(all_counts_hs)) 
house_R=house[house.iloc[:,3]=="R"] #republican house candidates
house_D=house[house.iloc[:,3]=="D"]  #democratic house candidates

##################################
fig, ax = plt.subplots(figsize=(12, 12))
def draw_barchart(year):
    house_R_year = house_R[house_R.year == year ]
    counts_R_year = house_R_year.grade.value_counts()
    counts_R_year=counts_R_year.reindex(grades,fill_value=0)
    house_D_year = house_D[house_D.year == year ]
    counts_D_year = house_D_year.grade.value_counts()
    counts_D_year=counts_D_year.reindex(grades,fill_value=0)
    plt.bar(x=xpos+0.15,height=counts_R_year,label="Republican",width=0.3,color="red")  
    plt.bar(x=xpos-0.15,height=counts_D_year,width=0.3,label="Democrat",color="blue")
    plt.xlabel("grade")
    plt.title("NRA Grades for House Races over the Years")
    plt.xticks(xpos,grades)


fig, ax = plt.subplots(figsize=(12, 12))
animator = animation.FuncAnimation(fig, draw_barchart, frames=range(2010, 2016,2))
HTML(animator.to_jshtml()) 
# or use animator.to_html5_video() or animator.save()
