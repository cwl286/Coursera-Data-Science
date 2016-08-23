rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Change the data type in the following columns to numeric
  data[,11] <- as.numeric(data[,11])
  data[,17] <- as.numeric(data[,17])
  data[,23] <- as.numeric(data[,23])

  # Create a set of valid outcomes that can be input into this function.
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")

  ## Check that state and outcome are valid
  if (!is.element(state,data$State)){
    stop("invalid state")
  }
  if (!is.element(outcome, valid_outcomes)){
    stop("invalid outcome")
  }
  
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  if (num == "best"){
    rank <- best(state, outcome)
  }
  else if (outcome == "heart attack"){
    rank <- hosp_help(data, 11, state, num)
  }
  else if (outcome == "heart failure"){
    rank <- hosp_help(data, 17, state, num)
  }
  else if (outcome == "pneumonia"){
    rank <- hosp_help(data, 23, state, num)
  }
  rank
}