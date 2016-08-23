complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  all_files <- list.files(directory, full.name = TRUE)
  data <- data.frame() 
  temp <- data.frame()
  temp_true <-data.frame()
  sum <- 0
  new_row <- data.frame()
  
  for (i in id){
    temp <- read.csv(all_files[i])
    temp_true <- complete.cases(temp)
    sum <-sum(temp_true)
    
    data <- rbind(data, data.frame(i, sum))
    
    temp <- data.frame()
    temp_true <-data.frame()
    sum <- 0   
  }
  colnames(data) <-c("id", "nobs")
  data
  
}