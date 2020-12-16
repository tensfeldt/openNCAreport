#' Predicate Function Factory
#'
#' This 'function factory' will make a predicate for if a string is in the set
#' of input strings
#'
#' @param set a \code{chr} vector representing the set of allowed values
#'
#' @return This function will return a function that can be used as a predicate
#'   in purrr::map_if
#' @export
#'
#' @examples \dontrun{letters_pred <- pred_factory(letters)}
pred_factory <- function(set){
  function(x){
    x %in% set
  }
}


#' Return Blank Factor
#'
#' This function takes any object and returns a blank factor
#' for use as the .else argument in map_if
#'
#' @param x any object
#'
#' @return always returns a blank factor (length 1)
#' @export
#'
make_blank <- function(x){
  factor("")
}

