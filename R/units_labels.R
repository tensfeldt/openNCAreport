filter_wds_exclusions <- function(tc, flg, profile, by) {
  exclusions <- tc[["WDS"]][[flg]][match(tc[["WDS"]][[profile]],
                                   names(tc[["WDS"]][[flg]]))]
  df_excl <- data.frame(EXCL = exclusions,
                        profile = tc[["WDS"]][[profile]],
                        by = tc[["WDS"]][[by]])

  tc$exclusions <- df_excl
  # filter out exclusions
  tc[["WDS"]] <- tc[["WDS"]][exclusions, ]
  tc
}



#TODO use match.arg to validate flag OR rethink the flag input logic
#TODO will this need the by variable?
compute_exclusions <- function(tc,
                               profile = "SDEID",
                               flg=NULL,
                               by = NULL) {

  df <- merge(x=tc[["ARD"]], y=tc[["FLG"]], by=tc$MCT[["FLGMERGE"]], all.x=TRUE)

  profile_excl <- split(purrr::pluck(df, flg), purrr::pluck(df, profile)) %>%
                        purrr::imap(~all(.x == 1)) %>%
                        purrr::map_lgl(~.x)

  df_excl <- tc$WDS
  # append the value of profile_excl for each profile in the WDS
  df_excl[["EXCL"]] <- profile_excl[match(df_excl[[profile]],
                                          names(profile_excl))]
  df_excl <- df_excl %>%
             dplyr::select(profile, by, "EXCL") %>%
             unique()

  # filter out exclusions
  tc[["WDS"]] <- tc[["WDS"]] %>%
    dplyr::filter(!profile %in% names(profile_excl)[profile_excl])
  # save table of exclusion correspondence to compute N, n later
  tc$exclusions <- df_excl

  tc
}


#' Assign Working Data Set Labels
#'
#' This function uses the information provided in the MCT of the input test case
#' to first match variables in the working data set to set conventions using
#' RegEx, these variables are then assigned appropriate labels and units, which
#' are stored in each variable's "label" attribute - this label will be picked
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


get_wds_vars <- function(tc){
 names(tc[["WDS"]])
}

select_wds_vars <- function(tc, ...){
 vars <- rlang::enquos(...)
 tc[["WDS"]] <- dplyr::select(tc[["WDS"]], !!!vars)
 tc
}

get_parameter_label <- function(x){
  # data("nca_dependency_list", package = "openNCAAreport")
  is_in_dep <- pred_factory(names(nca_dependency_list))
  # TODO this hack function takes NULL in the following map_if and returns the
  # variable as a label. There's certainly a simpler way to do this
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

