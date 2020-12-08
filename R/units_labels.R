append_wds_units <- function(tc){
  vars <- names(tc$WDS)
  names(vars) <- vars
  tc$units <- vars %>%
              purrr::possibly(~get_parameter_unit(.x, tc$MCT))
  tc
}

append_wds_unit_classes <- function(tc){
  vars <- names(tc$WDS)
  names(vars) <- vars
  tc$unit_class <- vars %>%
              purrr::imap_chr(~get_parameter_unit_class(.x))
  tc
}

append_wds_labels <- function(tc){
  vars <- names(tc$WDS)
  names(vars) <- vars
  tc$labels <- vars %>%
              purrr::imap(~get_parameter_label(.x))
  tc
}

get_parameter_label <- function(x){

  is_in_dep <- pred_factory(names(nca_dependency_list))


  x %>%
    purrr::map_if(.p = is_in_dep,
                  .else = make_blank,
                  ~purrr::pluck(nca_dependency_list, .x) %>%
                   purrr::pluck("parameter_label")) %>%
    purrr::map_if(.p = is.null, .f = make_blank, .else = ~.x) %>%
    purrr::map_chr(as.character)
}

get_parameter_unit_class <- function(x){

  is_in_dep <- pred_factory(names(nca_dependency_list))

  x %>%
    purrr::map_if(.p = is_in_dep,
                  .else = make_blank,
                  ~purrr::pluck(nca_dependency_list, .x) %>%
                   purrr::pluck("unit_class")) %>%
    purrr::map_if(.p = is.null, .f = make_blank, .else = ~.x) %>%
    purrr::map_chr(as.character)
}

get_parameter_unit <- function(x, mct) {
  # TODO currently the logic around pasting/substituting "OUTPUTUNIT$" is
  # convoluted and could be simplified

  #grab output units valid for this test case from MCT
  mct_opu <-  stringr::str_subset(names(mct), "OUTPUTUNIT$")

  # make custom predicate
  is_opu <- pred_factory(mct_opu)
  is_in_dep <- pred_factory(names(nca_dependency_list))


  x %>%
    # take var(s) and pluck the "unit_class" from the nca_dependency list (if it exists)
    purrr::map_if(.p = is_in_dep, .else = make_blank,
                  ~purrr::pluck(nca_dependency_list, .x) %>%
                   purrr::pluck("unit_class")) %>%
    # Add "OUTPUTUNIT" onto var(s) ending with "U"
    purrr::map_chr(~stringr::str_replace(.x, pattern = "U$", replacement = "OUTPUTUNIT")) %>%
    # take the unit from the MCT
    purrr::map_if(~pluck(mct, .x), .p = is_opu, .else = make_blank) %>%
    # cast as character
    purrr::map_chr(as.character)


}

