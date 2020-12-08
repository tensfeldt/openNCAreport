append_wds_units <- function(tc){
  vars <- names(tc$WDS)
  names(vars) <- vars
  tc$units <- vars %>%
              purrr::imap(~get_parameter_unit(.x, tc$MCT))
  tc
}


get_parameter_label <- function(x){
  x %>%
    purrr::map_chr(~purrr::pluck(nca_dependency_list, .x) %>%
                    purrr::pluck("parameter_label"))
}

get_parameter_unit_class <- function(x){
  x %>%
    purrr::map_chr(~purrr::pluck(nca_dependency_list, .x) %>%
                    purrr::pluck("unit_class"))
}

get_parameter_unit <- function(x, mct) {
  # TODO currently the logic around pasting/substituting "OUTPUTUNIT$" is
  # convoluted and could be simplified

  #grab output units valid for this test case from MCT
  mct_opu <-  stringr::str_subset(names(mct), "OUTPUTUNIT$")
  # remove outputunit from end of str
  mct_u <- stringr::str_replace(mct_opu, "OUTPUTUNIT$", "")
  # this 'function factory' will make a predicate for if a variable is in the
  # set of outputunits
  pred_factory <- function(output_units_mct){
   function(x){
     x %in% output_units_mct
   }
  }
  # make custom predicate
  is_opu <- pred_factory(mct_opu)
  is_in_dep <- pred_factory(names(nca_dependency_list))

  make_blank <- function(x){
    factor("")
  }

  x %>%
    purrr::map_if(.p = is_in_dep, .else = make_blank,
                  ~purrr::pluck(nca_dependency_list, .x) %>%
                   purrr::pluck("unit_class")) %>%
    purrr::map_chr(~stringr::str_replace(.x, pattern = "U$", replacement = "OUTPUTUNIT")) %>%
    purrr::map_if(~pluck(mct, .x), .p = is_opu, .else = make_blank) %>%
    purrr::map_chr(as.character)


}

