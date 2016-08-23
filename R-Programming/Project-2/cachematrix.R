makeCacheMatrix <- function(x = matrix()){
  
  ## makeCacheMatrix takes an input matrix x and returns a list of four functions
  ## which do the following:
  ##
  ## (1) set the value of the matrix
  ## (2) get the value of the matrix
  ## (3) set the value of the inverse of x
  ## (4) get the value of the inverse of x
  ## 
  ## This list is input into the function cacheSolve.
  ## 
  
  m <-NULL
  set <- function(y){
    # Use the <<- operator to assign a value to an object 
    # in an environment that is different from the current environment. 
    #    
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setsolve <- function(solve) m <<- solve
  getsolve <- function() m
  list (set = set,
        get = get,
        setsolve = setsolve,
        getsolve = getsolve)
}

cacheSolve <- function(x = matrix(), ...){
  
  ## Input the list output by makeCacheMatric
  ## Output the inverse of the matrix that was input into makeCacheMatrix.
  ## 
  
  m <- x$getsolve()
  
  # If the inverse has already been calculated, the following conditional
  # retrieves the cached inverse and bypasses the remaining code.
  if(!is.null(m)){
    message("Getting cached matrix")
    return(m)
  }
  
  # If the above conditional is skipped, we calculate the inverse and also
  # set the value of the cached inverse via "setsolve".
  inverse <- x$get()
  m <- solve(inverse, ...)
  x$setsolve(m)
  m
}