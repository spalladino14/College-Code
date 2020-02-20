#Spencer Palladino 
#Homework 5 
#Stat 4365
v = (1:10)
print(v) # we can use this to test our functions 
#Question 1 
#Make functions for each of the 5 stats
#Min
calcmin = function (x) {
  # calc min value of vector
  currentmin = Inf
  for (i in 1:length(x)) {
    if (x[i] < currentmin) {
      currentmin = x[i]
    }
  }
  return(currentmin)
}
calcmin(v) #making sure this function for min works
#Max
calcmax = function (x) {
  # find max value of vector  
  currentmax = -Inf
  for (i in 1:length(x)) {
    if (x[i] > currentmax) {
      currentmax = x[i]
    }
  }
  return(currentmax)
}
calcmax(v) #making sure this function for max works
#Median
calcmedian = function(x) {
  # find median of vector
  x= sort(x) 
  if (length(x) == 1) {
    med = x[1]  
  }
  else if (length(x) %% 2 == 1) {
    # for odd nums in vector
    med = x[ceiling(length(x)/2)] # round up
  } 
  else {
    # for even nums in vector
    n = ceiling(length(x)/2)
    med = (x[n] + x[n+1]) /2 
  }
  return (med)  
}
calcmedian(v) #test if median function works
#Quartiles
calcquartiles= function(x,quartile) {
  # find the quartile (1st and 3rd) of a vector
  x = sort(x) 
  med = calcmedian(x)
  if (quartile == 1) {
    x_half = x[x < med]
    z = calcmedian(x_half)
  }
  else if (quartile == 3) {
    x_half = x[x > med]
    z = calcmedian(x_half)
  }
  return (z)
}
#All together now
Quartile = function(x) {
  stat = NULL
  # min
  stat['min'] = calcmin(x)
  #1st quartile
  stat['q1'] = calcquartiles(x,1)
  # median
  stat['median'] = calcmedian(x)
  #3rd quartile
  stat['q3'] = calcquartiles(x,3)
  # max
  stat['max'] = calcmax(x)
  return (stat)
}
Quartile(v) #test our function and it works 
#i felt like making seperate functions for everything was far easier and less 
#confusing so hopefully this is ok. 

#Question 2 
x1 = (1:50)
y1 = (51:100)
regfit = lm(y1~x1)
summary(regfit)
leastsquaresregression = function(x,y) {
  xmean = mean(x)
  ymean = mean(y)
  sx = sqrt(sum((x- sum(x)/length(x))^2/(length(x))))
  sy = sqrt(sum((y- sum(y)/length(y))^2/(length(y))))
  xdif = x - xmean
  ydif = y - ymean
  r = sum(xdif * ydif) / sqrt(sum(xdif^2) *sum(ydif^2))
  #calculate b1
  b1 = r * (sy/sx)
  #calculate b0
  b0 = ymean - (b1 * xmean)
  #Calc SSE
  y10 = b0 + (b1*x)
  res = y - y10
  sse = sum(res^2)
  #calc t stat to get p-value
  df = length(x) - 2
  se = sx/(sqrt(length(x)))
  tvalue <- b1/se
  pvalue=2*pt(tvalue,df, lower=FALSE)
  #print stats 
  stat = NULL
  stat['b0'] = b0
  stat['b1'] = b1
  stat['sse'] = sse
  stat['p-value'] = pvalue
  output = list(stat, res)
  return(output)
}
leastsquaresregression(x1,y1)
