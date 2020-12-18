#' NCA dependency list
#'
#' A list containing attributes for NCA PK parameters
#'
#' @format A list with 204 slots, one per parameter, each slow has a further 8 nested slots
#'
#' \describe{
#'   \item{parameter label}{price, in US dollars}
#'   \item{cdisc_label}{}
#'   \item{regex}{A RegEx pattern that links vars in the params data to their slot here}
#'   \item{valid_models}{}
#'   \item{display_list_models}{}
#'   \item{predecessors}{}
#' }
"nca_dependency_list"
