corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  all_files <- list.files(directory,full.name = TRUE)
  cor_vector <- numeric() 
  
  for (monitor in all_files){
    my_data <- read.csv(monitor)
    complete_data <- my_data[complete.cases(my_data), ]
    number_of_complete <- dim(complete_data)[1]
    
    if (number_of_complete > threshold){
      correlation <- cor(my_data$sulfate, my_data$nitrate, use = "complete.obs")
      cor_vector <- c(cor_vector, correlation)
    }
  }
  
  cor_vector
}
