lambda = 3 #setting avg arrival rate
mu = 2 #setting avg service rate of 1 input

time = 1000 # setting max time
t = 0 # set variable to 0 

Q_hist = 0 # set variable to 0 
s = 0 # set variable to 0 

T1 = rexp(1,rate=lambda) #taking a random exp sample of size 1
#and rate =2
Q = 1
event_times = T1
t = T1
num_event = 1

while (t<time) { #settings a max length of the simulation
  num_event = num_event+1 #adds 1 to the events # each time. to keep track of every event.
  if(Q>0) { #if the q isnt empty
    # we checked to make sure queue was not empty
    T1 = rexp(1,rate=lambda+mu) #generate time until the next event (mu+lambda)
    p = runif(1,0,1) #generate random p between 0 and 1 
    Q_hist[num_event] = Q #The Q = the length of the q for the event. so Q_hist = length of line
    Q = ifelse(p<lambda/(lambda+mu),Q+1,Q-1) 
    #add 1 to q if p<lamba/lamba+mu
    #subtracts 1 to q if p>=lamba/lamba+mu
  } else {
    # here, the queue was empty, so only arrivals are possible
    T1 = rexp(1,rate=lambda) #time of event is just when first person arrives
    Q_hist[num_event] = Q #The Q = the length of the q for the event.
    Q = 1 #first person arrives and q = 1 
  }
  t = t+T1 # summing the time until next event together
  event_times[num_event] = T1 #create list time until next event for each event
  s = s+T1*Q_hist[num_event] #s would be the cumulative Q length
}

plot(cumsum(event_times),Q_hist,type="s", xlab="Time",ylab="Queue length",
     main="M/M/1 Simulation") # create plot using the event times
mtext(paste("mean queue length=",s/t))

#Question 2
#ex 3 Proportion that Q =0
sum(event_times[which(Q_hist==0)])/t

# ex 4 Proportion that Q =1
sum(event_times[which(Q_hist==1)])/t

#ex 6 Average Q length 
s/t
