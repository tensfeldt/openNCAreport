
get_parameter_label <- function(x, plist){
  x %>%
    purrr::map_chr(~purrr::pluck(plist, .x) %>%
                    purrr::pluck("parameter_label"))
}

get_parameter_unit_class <- function(x, plist){
  x %>%
    purrr::map_chr(~purrr::pluck(plist, .x) %>%
                    purrr::pluck("unit_class"))
}

get_parameter_unit <- function(x, plist, mct) {
  x %>%
    purrr::map_chr(~purrr::pluck(plist, .x) %>%
                    purrr::pluck("unit_class")) %>%
    purrr::map_chr(~stringr::str_replace(.x, pattern = "U$", replacement = "OUTPUTUNIT")) %>%
    purrr::map_if(~pluck(mct, .x), .p = is_mctoutputunit, .else = "")


  # ul <- gsub("U$", "", uc, ignore.case=TRUE, perl=TRUE)
  # ulo <- paste0(ul, "OUTPUTUNIT")
  #
  # if(is.element(ulo, mctoutputunits)) {
  #   parametersmatched[[i]]$unit <- mct[[ulo]]
  # } else {
  #   parametersmatched[[i]]$unit <- ""
  # }
  #

}


is_mctoutputunit <- function(x){
  # TODO this needs to be built into the package
  output_units <-
    c(
      "TIMEOUTPUTUNIT",
      "AMOUNTOUTPUTUNIT",
      "DOSEOUTPUTUNIT",
      "VOLUMEOUTPUTUNIT",
      "CONCOUTPUTUNIT",
      "KELOUTPUTUNIT",
      "CLOUTPUTUNIT",
      "AUCOUTPUTUNIT",
      "AUMCOUTPUTUNIT",
      "AUCNORMOUTPUTUNIT",
      "AUROUTPUTUNIT",
      "CONCNORMOUTPUTUNIT",
      "VOLUMENORMOUTPUTUNIT",
      "CLNORMOUTPUTUNIT",
      "RATEOUTPUTUNIT"
    )
  x %in% output_units
}
