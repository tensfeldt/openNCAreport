

#' Assign Working Data Set Labels
#'
#' This function uses the information provided in the MCT of the input test case
#' to first match parameters in the working data set to set conventions using
#' RegEx, these parameters are then assigned appropriate labels and units, which
#' are stored in each parameter's "label" attribute - this label will be picked
#' up by {gtsummary} further down the pipeline
#'
#' @param tc \code{openNCA_testcase} object, the input test case
#'
#' @return The input, \code{tc}, with labeled assigned to the Working Data Set
#'   (\code{WDS} slot)
#' @export
#'
#' @importFrom rlang .data
#'
#' @examples
assign_wds_labels <- function(tc){

    # data("nca_dependency_list", package = "openNCAAreport")
    # from nca_dependency_list pluck regex for matching vars
    re <- data.frame(re = purrr::map_chr(nca_dependency_list,
                                         purrr::pluck, "regex"),
                   stringsAsFactors = FALSE) %>%
    # keep labels from nca_dependency_list
    tibble::rownames_to_column(var = "nca_label") %>%
    # from nca_dependency_list get all parameter labels and unit_classes
    dplyr::mutate(label = purrr::map(.data$nca_label,
                                     ~purrr::pluck(nca_dependency_list[[.x]],
                                                   "parameter_label")),
           unit_class = purrr::map(.data$nca_label,
                                   ~purrr::pluck(nca_dependency_list[[.x]],
                                                 "unit_class")),
           unit = get_parameter_unit(.data$nca_label, tc$MCT)) %>%
    # find all vars in current WDS from test case
    dplyr::mutate(matched_var = purrr::map(re,
                                ~stringr::str_subset(string = get_wds_vars(tc),
                                                     pattern = .x))) %>%
    # remove cases where no vars are matched
    dplyr::filter(purrr::map_lgl(.data$matched_var,
                                 ~!vctrs::vec_is_empty(.x))) %>%
    # unwrap the (nested) matched_var column to give one-row per var
    tidyr::unnest("matched_var") %>%
    dplyr::rowwise() %>%
    # if the label is blank take the var name as a default
    dplyr::mutate(dplyr::across(c("label"),
                                ~dplyr::if_else(is.null(.x),
                                                true = .data$matched_var,
                                                false = .x)))

    # from the above re-correspondence df build the var labels and apply them
    labels <- purrr::map2_chr(re[["label"]], re[["unit"]],
                              ~glue::glue("{.x} ({.y})") %>%
                                stringr::str_replace_all(pattern =
                                                           "\\s\\(\\)$", ""))
    names(labels) <- re$matched_var
    tc$labels <- labels
    # append the wds into labels which makes it a parameter list for do.call
    labels <- append(labels, list(df = tc[["WDS"]]))
    tc$WDS <- do.call(update_label_df, labels)
    tc
}


#' Get Working Data Set Parameter Names
#'
#' @inheritParams filter_wds_exclusions
#'
#' @return the current set (names) of parameters in the WDS
#' @export
#'
#' @examples
get_wds_vars <- function(tc){
 names(tc[["WDS"]])
}

#' Select Working Data Set Parameters
#'
#' From the working data set, take these parameters for display in summary
#' tables
#'
#' @inheritParams filter_wds_exclusions
#' @param ... parameter names (as symbols ala {dplyr}) to keep in the working
#'   data set, any parameters not included are removed.
#'
#' @return \code{tc} \code{openNCA_testcase} object, the input test case with
#'   the modified WDS post parameter selection.
#' @export
#'
#' @examples
select_wds_vars <- function(tc, ...){
 vars <- rlang::enquos(...)
 tc[["WDS"]] <- dplyr::select(tc[["WDS"]], !!!vars)
 tc
}

#' Get Label for Parameter from NCA Dependency List
#'
#' @param x \code{chr}, the parameter name
#'
#' @return \code{chr} the parameter label
#' @export
#'
#' @examples
get_parameter_label <- function(x){
  # data("nca_dependency_list", package = "openNCAAreport")
  is_in_dep <- pred_factory(names(nca_dependency_list))
  # TODO this hack function takes NULL in the following map_if and returns the
  # parameter as a label. There's certainly a simpler way to do this
  var <- function(y){
    factor(x)
  }

  x %>%
    purrr::map_if(.p = is_in_dep,
                  .else = var,
                  ~purrr::pluck(nca_dependency_list, .x) %>%
                   purrr::pluck("parameter_label")) %>%
    purrr::map_if(.p = is.null, .f = var, .else = ~.x) %>%
    purrr::map_chr(as.character)
}

#' Get Unit Class for Parameter from NCA Dependency List
#'
#' @param x \code{chr}, the parameter name
#'
#' @return \code{chr} the parameter label
#' @export
#'
#' @examples
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

#' Get Unit for Parameter from NCA Dependency List
#'
#' @param x \code{chr}, the parameter name
#' @param mct \code{data.frame}, the MCT data set from the test case
#'
#' @return \code{chr} the parameter label
#' @export
#'
#' @examples
get_parameter_unit <- function(x, mct) {
  # TODO currently the logic around pasting/substituting "OUTPUTUNIT$" is
  # convoluted and could be simplified

  #grab output units valid for this test case from MCT
  mct_opu <-  stringr::str_subset(names(mct), "OUTPUTUNIT$")

  # make custom predicate
  is_opu <- pred_factory(mct_opu)
  is_in_dep <- pred_factory(names(nca_dependency_list))


  x %>%
    # take var(s) and pluck the "unit_class" from the nca_dependency list (if it
    # exists)
    purrr::map_if(.p = is_in_dep, .else = make_blank,
                  ~purrr::pluck(nca_dependency_list, .x) %>%
                   purrr::pluck("unit_class")) %>%
    # if unit_class is NULL replace with blank
    purrr::map_if(.p = is.null, .f = make_blank, .else = ~.x) %>%
    # Add "OUTPUTUNIT" onto var(s) ending with "U
    purrr::map_chr(~stringr::str_replace(.x,
                                         pattern = "U$",
                                         replacement = "OUTPUTUNIT")) %>%
    # take the unit from the MCT
    purrr::map_if(~purrr::pluck(mct, .x), .p = is_opu, .else = make_blank) %>%
    # cast as character
    purrr::map_chr(as.character)


}

