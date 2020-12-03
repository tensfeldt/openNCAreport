
# These summary functions MUST only return a single value -----------------

#' Geometric Mean
#'
#' @param x A numeric vector
#' @inheritParams base::mean
#'
#' @return the geometric mean of \code{x}, a single numeric
#' @export
#'
#' @examples
#' \dontrun{gm_mean(1:10)}
gm_mean <- function(x, na.rm = TRUE){
  exp(sum(log(x[x > 0]), na.rm = na.rm)/length(x))
}

#' Geometric Coefficient of Variation
#'
#' @inheritParams gm_mean
#'
#' @return the geometric coefficient of variation of \code{x}, a single numeric
#' @export
#'
#' @examples
#' \dontrun{gm_cv(1:10)}
gm_cv <- function(x, na.rm = TRUE) {
  sqrt(exp(stats::sd(log(x), na.rm = na.rm) ^ 2) - 1) * 100
}

#' Mean Plus One Standard Deviation
#'
#' @inheritParams gm_mean
#'
#' @return the arithmetic mean of \code{x} plus one standard deviation, a single numeric
#' @export
#'
#' @examples
#' \dontrun{mean_pl_sd(1:10)}
mean_pl_sd <- function(x, na.rm=TRUE) {
  mean(x, na.rm = na.rm) + stats::sd(x, na.rm = na.rm)
}

#' Mean Minus One Standard Deviation
#'
#' @inheritParams gm_mean
#'
#' @return the arithmetic mean of \code{x} minus one standard deviation, a single numeric
#' @export
#'
#' @examples
#' \dontrun{mean_mi_sd(1:10)}
mean_mi_sd <- function(x, na.rm = TRUE) {
  mean(x, na.rm = na.rm) - stats::sd(x, na.rm = na.rm)
}


upper_range <- function(x, na.rm = TRUE){
  range(x, na.rm = na.rm)[2]
}

lower_range <- function(x, na.rm = TRUE){
  range(x, na.rm = na.rm)[1]
}
