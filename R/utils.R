get_fmla_response <- function(fmla) {
 if(!is_two_sided(fmla)) stop("Input formula is not two-sided")
 elements <- attr(terms(fmla), which = "variables") 
 elements[[2]]
}

get_fmla_predictors <- function(fmla) {
 if(is_two_sided(fmla)){
   all.vars(fmla[-2])
 } else {
   elements <- attr(terms(fmla), which = "variables") 
   elements %>% map(as.symbol)
 }
}

is_two_sided <- function(fmla) {
  is.name(fmla[[1]]) && length(fmla) == 3 &&
  deparse(fmla[[1]]) %in% names(.Options$operators) # is element an operator?
}

is_two_sided <- function(fmla) {
  is.name(fmla[[1]]) && length(fmla) == 3 &&
  deparse(fmla[[1]]) %in% names(.Options$operators) # is element an operator?
}
