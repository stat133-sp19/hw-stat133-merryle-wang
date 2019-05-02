#title:check_prob
#description: makes sure the probability is valid
#param prob
#return TRUE if good, else error
check_prob <- function(prob){
  if(is.numeric(prob) &&prob >= 0 && prob <= 1){
    return(TRUE)
  } else {
    stop('p has to be a number between 0 and 1')
  }
}

#title:check_trials
#description: makes sure that the trial number is valid
#param trials
#return TRUE if good, else error
check_trials <- function(trials){
  if(is.numeric(trials) && trials >= 0 && trials %%1 == 0){
    return(TRUE)
  } else {
    stop("invalid trials value")
  }
}


#title:check_success
#description: makes sure that the success number is valid
#param success,trials
#return TRUE if good, else error
check_success <- function(success,trials){
  if(is.numeric(success) && is.numeric(trials) && success >= 0 && success%%1 == 0 && success <= trials){
    return(TRUE)
  }else{
    if(success > trials){
      stop('success cannot be greater than trials')
    }else{
      stop('inavlid success value')
    }
  }

}
