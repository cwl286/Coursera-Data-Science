best <- function(state, outcome) {
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
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  state_frame <- data[data[,7] == state, ]
  
  # outcome_frame collects data for the inputs state and outcome
  if (outcome == "heart attack"){
    outcome_frame<-state_frame[,11]
  }
  else if (outcome == "heart failure"){
    outcome_frame<-state_frame[,17]
  }
  else if (outcome == "pneumonia"){
    outcome_frame<-state_frame[,23]
  }
  
  minimum <- min(outcome_frame, na.rm=TRUE)
  
  min_index<- which(outcome_frame==minimum)
  
  hospital_name<- state_frame[min_index,2]
  
  hospital_name
}