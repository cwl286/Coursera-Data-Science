rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  
  # Create a set of valid outcomes that can be input into this function.
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  
  # Create a list of each state and territory appearing in data
  # and a variable state_len for the length of state_vect
  state_vect <- sort(unique(data$State))
  state_len <- length(state_vect)
  
  # Create an empty vector to hold hospital names of a particukar rank
  hosp_vect <- rep("", state_len)
  
  ## Check that outcome is valid
  if (!is.element(outcome, valid_outcomes)){
    stop("invalid outcome")
  }
  
  ## For each state/territory, find the hospital of the given rank
  for (i in 1:state_len){
    state_frame <- data[data[,7] == state_vect[i], ]    
    
    if (outcome == "heart attack"){
      hosp_vect[i] <- hosp2_help(state_frame, 11, num)
    }
    else if (outcome == "heart failure"){
      hosp_vect[i] <- hosp2_help(state_frame, 17, num)
    }
    else if (outcome == "pneumonia"){
      hosp_vect[i] <- hosp2_help(state_frame, 23, num)
    }
  }
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  hosp_frame <- data.frame(hospital = hosp_vect, state = state_vect)
  
  hosp_frame
}
