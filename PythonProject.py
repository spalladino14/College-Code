# -*- coding: utf-8 -*-
"""
Created on Wed Dec 11 11:51:17 2019

@author: spenc
"""
#Spencer Palladino 
#Final Project


import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from zipfile import ZipFile
import scipy
import matplotlib.ticker as ticker
import matplotlib.animation as animation
from IPython.display import HTML
import plotly.express as px
#a


data_list = [["year", "name", "gender", "births"]]

# We first read the zip file using a zipfile.ZipFile object.
with ZipFile('C:/Users/spenc/Downloads/data/names.zip') as temp_zip:
    for file_name in temp_zip.namelist():
        if ".txt" in file_name:
            with temp_zip.open(file_name) as temp_file:
                for line in temp_file.read().decode("utf-8").splitlines():
                    line_chunks = line.split(",")
                    year = file_name[3:7]
                    name = line_chunks[0]
                    gender = line_chunks[1]
                    count = line_chunks[2]
                    data_list.append([year, name, gender, count])
                    
df=pd.DataFrame(data_list) #make 1 big panda df from the others
new_header = df.iloc[0] #grab the first row for the header
df = df[1:] #take out top row 
df.columns = new_header #replace with the headers

 # this should be clean finally
male_df = df[df["gender"] == "M"] # make male subsets
male_df=male_df.sort_values(by="births", ascending=False)

male_df=pd.DataFrame(male_df) #make sure its a panda df
male_df.births=male_df.births.astype(float) #make sure births is a float
totalbirthsmale = male_df.pivot_table('births',index='year',aggfunc =np.sum) #get total #of births a year
pivoted_male_df = male_df.pivot_table(index="name", columns="year", values="births", aggfunc=np.sum).fillna(0)
#makes pivote table to see how many of each name were used a year
malepercentagedf = pivoted_male_df.astype(float) / np.asarray(totalbirthsmale).transpose() *100

transposed_male = malepercentagedf.transpose()

female_df = df[df["gender"] == "F"]
female_df=pd.DataFrame(female_df) #make sure its a panda df
female_df.births=female_df.births.astype(float) #make sure births is a float
totalbirthsfemale = female_df.pivot_table('births',index='year',aggfunc =np.sum) #get total #of births a year
pivoted_female_df = female_df.pivot_table(index="name", columns="year", values="births", aggfunc=np.sum).fillna(0)
#makes pivote table to see how many of each name were used a year
femalepercentagedf = pivoted_female_df.astype(float) / np.asarray(totalbirthsfemale).transpose() *100
transposed_female = femalepercentagedf.transpose()

def plot_names(*args,sex, begin_year=1880, end_year=2018):
    if sex == 'M':
        for arg in args:
            plt.bar(transposed_male.index.astype(float),transposed_male[arg], label = arg)
        plt.grid(False)
        plt.xlabel("Year")
        plt.ylabel("Percent of Newborns with Name")
        plt.title("Popularity of Boy Names")
        plt.xlim(begin_year,end_year)
        plt.legend()
    elif sex == 'F':
        for arg in args:
            plt.bar(transposed_female.index.astype(float),transposed_female[arg], label = arg)
        plt.grid(False)
        plt.xlabel("Year")
        plt.ylabel("Percent of Newborns with Name")
        plt.title("Popularity of Girl Names") 
        plt.xlim(begin_year,end_year)
        plt.legend()
    else:
       return("Error: Sex variable must be M or F")
#examples
plot_names("Spencer", "Sam",begin_year=2000, end_year = 2018,sex = 'T')  #shouldnt work
plot_names("Spencer", "Sam",begin_year=2000, end_year = 2018,sex = 'M')
plot_names("Mary","Susan","Natalie","Evelyn","Emma",sex="F",begin_year=1900,end_year=2018)

#b
def plot_topn(year,number,sex):
    if sex == 'M':
        sort = malepercentagedf[year].sort_values(ascending=False)
        y = sort[:number]
        names =sort.index[:number]
        names = np.asarray(names)
        plt.barh(names, y, label = names)
        plt.gca().invert_yaxis()
        plt.xlabel("Percent of Male Newborns with Name")
        plt.ylabel("Names")
        plt.title("Top " + str(number) + " Most Popular Boy Names in " + str(year))
        plt.gcf().text(.8,.2, year, fontsize=16)
    elif sex == 'F':
        sort = femalepercentagedf[year].sort_values(ascending=False)
        y = sort[:number]
        names =sort.index[:number]
        names = np.asarray(names)
        plt.barh(names, y, label = names)
        plt.gca().invert_yaxis()
        plt.xlabel("Percent of Female Newborns with Name")
        plt.ylabel("Names")
        plt.title("Top " + str(number) + " Most Popular Girl Names in " + str(year))
        plt.gcf().text(.8,.2, year, fontsize=16)
    else:
       return("Error: Sex variable must be M or F")
plot_topn("2004",20,'M')
plot_topn("2005",5,'F')

#c
  
def name_animate(begin_year,end_year,n,sex,slide_time =1000):
    yr = range(begin_year,end_year+1)
    if sex == 'M':
        for i in yr:
            i = str(i)
            sort = malepercentagedf[i].sort_values(ascending=False)
            y = sort[:n]
            names =sort.index[:n]
            names = np.asarray(names)     
            plt.figure()
            plt.barh(names, y, label = names)
            plt.gca().invert_yaxis()
            plt.xlabel("Percent of Male Newborns with Name")
            plt.ylabel("Names")
            plt.title("Top " + str(n) + " Most Popular Boy Names Over Time")
            plt.gcf().text(.8,.2, i, fontsize=16)

    elif sex == 'F':   
        for i in yr:
            i = str(i)
            sort = femalepercentagedf[year].sort_values(ascending=False)
            y = sort[:n]
            names =sort.index[:n]
            names = np.asarray(names)
            plt.figure()
            plt.barh(names, y, label = names)
            plt.gca().invert_yaxis()
            plt.xlabel("Percent of Female Newborns with Name")
            plt.ylabel("Names")
            plt.title("Top " + str(n) + " Most Popular Girl Names Over Time")
            plt.gcf().text(.8,.2, i, fontsize=16)
    
    else:
        return("Error: Sex variable must be M or F")

name_animate(begin_year=2000,end_year=2018,n=10,sex="M",slide_time=1000)



import matplotlib.animation as animation
from IPython.display import HTML
fig, ax = plt.subplots(figsize=(15, 8))
animator = animation.FuncAnimation(fig, name_animate, frames=range(2000, 2018))





















