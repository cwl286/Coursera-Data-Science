hosp_help <- function(data, col, state, num){
  state_frame <- data[data[,7] == state, ]
  
  outcome_frame <- state_frame[, col]
  
  length <- dim(state_frame[!is.na(outcome_frame), ])[1]
  
  if (num == "worst"){
    rank <- state_frame[, 2][order(outcome_frame, state_frame[,2])[length]]
  }
  else if (num > length){
    rank <- NA
  }
  else {
    rank <- state_frame[, 2][order(outcome_frame, state_frame[,2])[num]]
  }

  rank
  
}