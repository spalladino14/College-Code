# -*- coding: utf-8 -*-
"""
Created on Mon Nov 25 21:14:47 2019

@author: spenc
"""
#Spencer Palladino
#Homework 6
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import collections 
import numpy.random as npr
from scipy.stats import binom
import statsmodels.api as sm
import statsmodels.formula.api as smf
from sklearn.linear_model import LinearRegression
NSeq = np.arange(2, 32, 2)

b=np.array([.2,.5,1])
a=np.array([1,1,1])
C=np.array([1,1])

mod2=smf.ols(formula='y~x').fit()
C=c(1,1)
m1.loc[:, 1]
def LinRegPower(N,B,A,sd,nrep):
  A = pd.DataFrame(A)
  B = pd.DataFrame(B)
  m1=pd.concat([A, B], axis=1, ignore_index=True)
  if len(A) != len(B):
    return("Error: A and B are not the same length")
  elif len(N) == 1:
    return("Error: N is length 1")
  else:
    powers = np.zeros(shape=[len(N),1])
    for k in np.arange(1, m1.shape[0]):
        for j in np.arange(1,len(N)):
            N1 = N[j]
            sigexs = np.zeros(shape=[nrep,1], dtype = int)
            for i in np.arange(1,nrep):
                    x = np.random.uniform(0,10,N1) #gets x 
                    y= np.array(m1.loc[k, 0])+(np.array(m1.loc[k, 1])*np.array(x))+np.random.normal(size = N1,loc =0,scale=sd)
                    lm2 = LinearRegression()
                    mod2=lm2.fit(x,y)
                    result = mod2.pvalues
                    sigexs[i] = (result <= .05) 
            powers[j] = mean(sigexs)   
        plt =plt.plot(N, powers) 
        return(plt) 
# unfortunately i ran into some issues I could not overcome onvoling the regression in python which i think 
        #is where me error is 
LinRegPower(NSeq,B,A,1,1000) #test run
LinRegPower(1,B,A,1,1000) #test run
LinRegPower(NSeq,C,A,1,1000) #test run