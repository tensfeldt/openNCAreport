
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

  # grab output units valid for this test case from MCT
  mct_opu <-  stringr::str_subset(names(mct), "OUTPUTUNIT$")
  # this 'function factory' will make a predicate for if a variable is in the
  # set of outputunits
  pred_factory <- function(output_units_mct){
   function(x){
     x %in% output_units_mct
   }
  }
  # make custom predicate
  is_opu <- pred_factory(mct_opu)

  make_blank <- function(x){
    factor("")
  }

  x %>%
    purrr::map_chr(~purrr::pluck(plist, .x) %>%
                    purrr::pluck("unit_class")) %>%
    purrr::map_chr(~stringr::str_replace(.x, pattern = "U$", replacement = "OUTPUTUNIT")) %>%
    purrr::map_if(~pluck(mct, .x), .p = is_opu, .else = make_blank) %>%
    purrr::map_chr(as.character)

}

