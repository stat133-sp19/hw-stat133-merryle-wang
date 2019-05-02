#title:aux_mean
#description: calculates mean
#params trials,prob
#return the mean
aux_mean <- function(trials,prob){
  return(trials*prob)
}

#title:aux_variance
#description: calculates variance
#params trials,prob
#return the variance
aux_variance <- function(trials,prob){
  return(trials*prob*(1-prob))
}


#title:aux_mode
#description: calculates mode (most likely to appear)
#params trials,prob
#return the mode
aux_mode <- function(trials,prob){
  m <- trials*prob + prob
  if(m%%1 == 0){
    return(c(as.integer(m),as.integer(m-1)))
  }else{
    return(as.integer(m))
  }
}
#title:aux_skewness
#description: calculates skewness
#params trials,prob
#return the skewness
aux_skewness <- function(trials,prob){
  top <- 1 - 2*prob
  return(top/sqrt(aux_variance(trials,prob)))
}


#title:aux_kurtosis
#description: calculates kurtosis
#params trials,prob
#return the kurtosis
aux_kurtosis <- function(trials,prob){
  top <- 1 - 6*prob*(1-prob)
  bottom <- trials*prob*(1-prob)
  return(top/bottom)
}
