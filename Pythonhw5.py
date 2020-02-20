# -*- coding: utf-8 -*-
"""
Created on Fri Nov 15 16:42:05 2019

@author: spenc
"""
#Spencer Palladino 
#Homework 5 
#Stat 4365
#Question 1 
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import math
from scipy import stats
v = np.array([1, 2, 3, 4, 5, 6,7,8,9,10])
#min function
def calcmin(x):
   Min = x[0]
   for num in x:
       if num < Min:
           Min=num
   return Min
calcmin(v) #test min function
#max function
def calcmax(x):
   Max = x[0]
   for num in x:
       if num > Max:
           Max=num
   return Max
calcmax(v) #test max function
#median function 
def calcmedian(x):
    sortedx = sorted(x)
    lstLen = len(x)
    index = (lstLen - 1) // 2

    if (lstLen % 2):
        return sortedx[index]
    else:
        return (sortedx[index] + sortedx[index + 1])/2.0
#quartile function 
def calcquartiles(x, quartile):
    x = sorted(x)
    x = np.array(x)
    med = calcmedian(x)
    if (quartile == 1):
        x_half = x[x < med]
        z= calcmedian(x_half)
        return z
    elif (quartile == 3):
        x_half = x[x > med]
        z= calcmedian(x_half)
        return z
calcquartiles(v, 1) # test 1st quartile 
calcquartiles(v, 3)# test 3rd quartile 
#All together now 
def Quartile(x):
    return calcmin(x), calcquartiles(x,1), calcmedian(x), calcquartiles(x,3), calcmax(x)
Quartile(v) #test our function and it works

#Question 2 
x1 = np.arange(1, 50)
y1 = np.arange(51, 100)
def leastsquaresregression(x,y):
    x = np.array(x)
    y = np.array(y)
    meanx = np.mean(x)
    meany = np.mean(y)
    sx = math.sqrt(sum((x- sum(x)/len(x))**2/(len(x))))
    sy = math.sqrt(sum((y- sum(y)/len(y))**2/(len(y))))
    n = len(x)
    # Using the formula to calculate m and c
    numer = 0
    denom = 0
    for i in range(n):
        numer += (x[i] - meanx) * (y[i] - meany)
        denom += (x[i] - meanx) ** 2
        b1 = numer / denom
        b0 = meany - (b1 * meanx)
    y10 = b0 +(b1*x)
    res = y - y10
    sse = sum(res**2)
    df = len(x) -2
    se = sx/(math.sqrt(len(x)))
    tvalue = b1/se
    pvalue = stats.t.cdf(tvalue,df=df)
    # return stuff
    return(b0, b1, sse, res, pvalue)
leastsquaresregression(x1,y1)
# in the order of intercept , slope, SSE, residuals, p-value




































