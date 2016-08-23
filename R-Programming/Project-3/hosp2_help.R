hosp2_help <- function(state_frame, col, num){
  outcome_vect <- as.numeric(state_frame[,col])  
  length <- dim(state_frame[!is.na(outcome_vect), ])[1]
  
  if (num == "worst"){
    rank <- state_frame[, 2][order(outcome_vect, state_frame[,2])[length]]
  }
  else if (num == "best"){
    rank <- state_frame[, 2][order(outcome_vect, state_frame[,2])[1]]
  }
  else if (num > length){
    rank <- NA
  }
  else {
    rank <- state_frame[, 2][order(outcome_vect, state_frame[,2])[num]]
  }
  
  rank
  
}