#' @title bin_choose
#' @description calculates the choose function
#' @param n a number, total to choose from
#' @param k a number, how many chosen
#' @return n choose k
#' @examples bin_choose(10,3)
#' @export
bin_choose <- function(n,k){
  if(k > n){
    stop('k cannot be greater than n')
  }
  return(factorial(n)/(factorial(k)*factorial(n-k)))
}

#' @title bin_probability
#' @description evaluates the binomial formula
#' @param success, number of successes
#' @param trials, total number of trials
#' @param prob, chance of success
#' @return result of bin formula
#' @examples bin_probability(3,5,0.3)
#' @export
bin_probability <- function(success,trials,prob){
  if(check_trials(trials) && check_prob(prob) && check_success(success,trials)){
    return(bin_choose(trials,success)*(prob^success)*((1-prob)^(trials-success)))
  }
}

#' @title bin_distribution
#' @description gets the whole discrete distribution
#' @param trials, total number of trials
#' @param prob, chance of success
#' @return data frame contains the distribution
#' @examples bin_distribution(5,0.5)
#' @export
bin_distribution <- function(trials,prob){
  success <- 0:trials
  probability <- bin_probability(success,trials,prob)
  df <- data.frame(success,probability)
  class(df) <- c("bindis","data.frame")
  return(df)
}



#' @title plot.bindis
#' @description given a distribution, plots it
#' @param dis (a bindis)
#' @return a ggplot
#' @examples plot(bin_distribution(5,0.5))
#' @import ggplot2
#' @export
plot.bindis <- function(dis){
  ggplot(data = dis,aes(x = success,y = probability)) +
    geom_col()
}


#' @title bin_cumulative
#' @description gets the discrete distribution and the CDF
#' @param trials total number of trials
#' @param prob chance of success
#' @return a dataframe containing the distribution and cumulative
#' @examples bin_cumulative(5,0.5)
#' @export
bin_cumulative <- function(trials,prob){
  success <- 0:trials
  probability <- bin_probability(success,trials,prob)
  cumulative <- cumsum(probability)
  df <- data.frame(success,probability,cumulative)
  class(df) <- c("bincum","data.frame")
  return(df)
}

#' @title plot.bincum
#' @description given a cumulative distribution, plots it
#' @param dis (a bincum)
#' @return a ggplot
#' @examples plot(bin_cumulative(5,0.5))
#' @import ggplot2
#' @export
plot.bincum <- function(dis){
  ggplot(data = dis,aes(x = success,y = cumulative)) +
    geom_line() +
    geom_point() +
    ylab("probability")
}


#' @title bin_variable
#' @description makes a binomial random variable
#' @param trials, total number of trials
#' @param prob, chance of success
#' @return a binvar object
#' @examples bin_variable(5,0.5)
#' @export
bin_variable <- function(trials,prob){
  if(check_trials(trials) && check_prob(prob)){
    ret <- list(trials,prob)
    class(ret) <- "binvar"
    return(ret)
  }
}


#' @title print.binvar
#' @description makes a binomial random variable readable output
#' @param bin a binvar object
#' @return nothing, just prints
#' @examples print(bin_variable(5,0.5))
#' @export
print.binvar <- function(bin){
  print("Binomial variable")
  print("",quote=FALSE)
  print("Parameters",quote=FALSE)
  print(paste0("- number of trials : ",bin[[1]]),quote=FALSE)
  print(paste0("- prob of success : ",bin[[2]]),quote=FALSE)
}

#' @title summary.binvar
#' @description makes a binomial random variable's summary
#' @param bin a binvar object
#' @return the binvar's different measures
#' @examples summary(bin_variable(5,0.5))
#' @export
summary.binvar <- function(bin){
  t <- bin[[1]]
  p <- bin[[2]]
  ret <- list(t,p,aux_mean(t,p),aux_variance(t,p),aux_mode(t,p)
              ,aux_skewness(t,p),aux_kurtosis(t,p))
  class(ret) <- "summary.binvar"
  return(ret)
}

#' @title print.summary.binvar
#' @description makes a binomial random variable's summary readable output
#' @param binsum a summary.binvar object
#' @return nothing, just prints
#' @examples print(summary(bin_variable(5,0.5)))
#' @export
print.summary.binvar <- function(binsum){
  print("Summary Binomial")
  print("",quote=FALSE)
  print("Parameters",quote=FALSE)
  print(paste0("- number of trials : ",binsum[[1]]),quote=FALSE)
  print(paste0("- prob of success : ",binsum[[2]]),quote=FALSE)
  print("",quote=FALSE)
  print("Measures",quote=FALSE)
  print(paste0("- mean : ",binsum[[3]]),quote=FALSE)
  print(paste0("- variance : ",binsum[[4]]),quote=FALSE)
  print(paste0("- mode : ",binsum[[5]]),quote=FALSE)
  print(paste0("- skewness : ",binsum[[6]]),quote=FALSE)
  print(paste0("- kurtosis : ",binsum[[7]]),quote=FALSE)
}
