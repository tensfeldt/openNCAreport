check_fmla_operators <- function(fmla) {
  #TODO this doesnt work because .Options$operators can return false, investigate.
  # this function checks if the operators in fmla are in c("~", "+"), otherwise return FALSE
  operators <- intersect(names(.Options$operators), all.names(fmla))
  all(operators %in% c("+", "~")) 
} 

get_fmla_response <- function(fmla) {
  #TODO fix this logic
 # if(!is_two_sided(fmla)) stop("Input formula is not two-sided")
  # get all vars
  vars <- attr(terms(formula(fmla)), which = "variables")
  # get response
  res <- as.character(vars[[2]]) # The response variable name
  res
}

# get_fmla_predictors <- function(fmla) {
#  if(is_two_sided(fmla)){
#    all.vars(fmla[-2])
#  } else {
#    labels(terms(fmla))
#  }
# }

get_fmla_predictors <- function(fmla) {
 labels(terms(fmla))
}


is_two_sided <- function(fmla) {
  is.name(fmla[[1]]) && length(fmla) == 3 &&
  deparse(fmla[[1]]) %in% names(.Options$operators) # is element an operator?
}

is_two_sided <- function(fmla) {
  is.name(fmla[[1]]) && length(fmla) == 3 &&
  deparse(fmla[[1]]) %in% names(.Options$operators) # is element an operator?
}
