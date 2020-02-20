# -*- coding: utf-8 -*-
"""
Created on Tue Dec  3 09:58:24 2019

@author: spenc
"""
#Spencer Palladino
#Homework 7
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import numpy.random as npr
import statsmodels.api as sm
import statsmodels.formula.api as smf
from sklearn.linear_model import LinearRegression
from sklearn.linear_model import Lasso

collegedata = pd.read_csv('C:/Users/spenc/Downloads/data/MERGED2015_16_PP.csv',
                          usecols = ['C200_4','CONTROL','AVGFACSAL','INC_PCT_LO','INC_PCT_M1',
                                     'INC_PCT_M2','INC_PCT_H1','INC_PCT_H2','SATVRMID','SATMTMID',
                                     'UGDS_WOMEN','UGDS_WHITE','ADM_RATE','PFTFAC','TUITIONFEE_IN'])

collegedata=collegedata[collegedata!= 'PrivacySuppressed']
collegedata.dropna(inplace=True)
collegedata.astype(float)
#get data to be less messy. Python handles NA values poor
#Question 1 
#a
y = collegedata.C200_4
x1 = collegedata.CONTROL

results = sm.OLS(y,x1).fit()
results.summary()

x2 = collegedata.AVGFACSAL
results = sm.OLS(y,x2).fit()
results.summary()
x3 = collegedata.INC_PCT_LO.astype(float) #for some reason these still were not floats
results = sm.OLS(y,x3).fit()
results.summary()
x4 = collegedata.INC_PCT_M1.astype(float)
results = sm.OLS(y,x4).fit()
results.summary()
x5 = collegedata.INC_PCT_M2.astype(float)
results = sm.OLS(y,x5).fit()
results.summary()
x6 = collegedata.INC_PCT_H1.astype(float)
results = sm.OLS(y,x6).fit()
results.summary()
x7 = collegedata.INC_PCT_H2.astype(float)
results = sm.OLS(y,x7).fit()
results.summary()
x8 = collegedata.SATVRMID
results = sm.OLS(y,x8).fit()
results.summary()
x9 = collegedata.SATMTMID
results = sm.OLS(y,x9).fit()
results.summary()
x10 = collegedata.UGDS_WOMEN
results = sm.OLS(y,x10).fit()
results.summary()
x11 = collegedata.UGDS_WHITE
results = sm.OLS(y,x11).fit()
results.summary()
x12 = collegedata.ADM_RATE
results = sm.OLS(y,x12).fit()
results.summary()
x13 = collegedata.PFTFAC
results = sm.OLS(y,x13).fit()
results.summary()
x14 = collegedata.TUITIONFEE_IN
results = sm.OLS(y,x14).fit()
results.summary()
#b
linmod = smf.ols(formula = 'y~x1+x2+x3+x4+x5+x6+x8+x9+x10+x11+x12+x13+x14'
,data=collegedata, missing='drop').fit()
linmod.summary()

#c
def forward_selection(data, target, significance_level=0.05):
    initial_features = data.columns.tolist()
    best_features = []
    while (len(list(initial_features))>0):
        remaining_features = list(set(initial_features)-set(best_features))
        new_pval = pd.Series(index=remaining_features)
        for new_column in remaining_features:
            model = sm.OLS(target, sm.add_constant(data[best_features+[new_column]])).fit()
            new_pval[new_column] = model.pvalues[new_column]
        min_p_value = new_pval.min()
        if(min_p_value<significance_level):
            best_features.append(new_pval.idxmin())
        else:
            break
    return best_features
#Could not figure out how to do step in Python so I found this online 

df=pd.concat([x1,x2,x3,x4,x5,x6,x8,x9,x10,x11,x12,x13,x14], axis=1, ignore_index=True) 
#make frame of predicting variables
forward_selection(df, y, significance_level=0.05)

#d
#Using forward selection, it would appear that x2,x3,x4,x8,x9,x10,x11,x12,x14 
#are good variables to predict C200_4. Normally I would like to verify this with other 
#step directions but I am unable to find out how to do that.The output is the just 
#the columns in the df fram that are significant in predicting y. 



#Question 2 
collegedata = pd.read_csv('C:/Users/spenc/Downloads/data/MERGED2007_08_PP.csv',
                          usecols = ['CONTROL','AVGFACSAL','INC_PCT_LO','INC_PCT_M1',
                                     'INC_PCT_M2','INC_PCT_H1','INC_PCT_H2','SATVRMID','SATMTMID',
                                     'UGDS_WOMEN','ADM_RATE','PFTFAC','TUITIONFEE_IN','MD_EARN_WNE_P10'])
collegedata=collegedata[collegedata != 'PrivacySuppressed']
collegedata.dropna(inplace=True)
collegedata.astype(float)
#finished importing old data set
y = collegedata.MD_EARN_WNE_P10.astype(float) / collegedata.TUITIONFEE_IN.astype(float)
#gets new y value
x1 = collegedata.CONTROL
results = sm.OLS(y,x1).fit()
results.summary()
x2 = collegedata.AVGFACSAL
results = sm.OLS(y,x2).fit()
results.summary()
x3 = collegedata.INC_PCT_LO.astype(float) #for some reason these still were not floats
results = sm.OLS(y,x3).fit()
results.summary()
x4 = collegedata.INC_PCT_M1.astype(float)
results = sm.OLS(y,x4).fit()
results.summary()
x5 = collegedata.INC_PCT_M2.astype(float)
results = sm.OLS(y,x5).fit()
results.summary()
x6 = collegedata.INC_PCT_H1.astype(float)
results = sm.OLS(y,x6).fit()
results.summary()
x7 = collegedata.INC_PCT_H2.astype(float)
results = sm.OLS(y,x7).fit()
results.summary()
x8 = collegedata.SATVRMID
results = sm.OLS(y,x8).fit()
results.summary()
x9 = collegedata.SATMTMID
results = sm.OLS(y,x9).fit()
results.summary()
x10 = collegedata.UGDS_WOMEN
results = sm.OLS(y,x10).fit()
results.summary()
x12 = collegedata.ADM_RATE
results = sm.OLS(y,x12).fit()
results.summary()
x13 = collegedata.PFTFAC
results = sm.OLS(y,x13).fit()
results.summary()

#b
linmod = smf.ols(formula = 'y~x1+x2+x3+x4+x5+x6+x8+x9+x10+x12+x13'
,data=collegedata, missing='drop').fit()
linmod.summary()

#c
df=pd.concat([x1,x2,x3,x4,x5,x6,x8,x9,x10,x12,x13], axis=1, ignore_index=True) 
#make frame of predicting variables
forward_selection(df, y, significance_level=0.05)
   
#d
#Using forward selection, it would appear that x1,x2,x3,x6,x8,x9 
#are good variables to predict VALUE (y). Normally I would like to verify this with other 
#step directions but I am unable to find out how to do that. The output is the just 
#the columns in the df fram that are significant in predicting y. 
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
