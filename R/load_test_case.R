

#' Load NCA Test Case from Path
#'
#' The function works in one of two ways, either the user specifies a path to a
#' directory containing a collection of four csv data sets with the patterns
#' "ARD", "MCT", "FLG, and "PARAM" in the file names. Or the user has the
#' options to include paths to each file.
#'
#' @param path directory containing the ARD, FLG, MCT, and PARAM data sets in
#'   csv format
#' @param ard_path path to the ARD in csv format
#' @param flg_path path to the FLG in csv format
#' @param mct_path path to the MCT in csv format
#' @param param_path path to the PARAM in csv format
#'
#' @return a \code{openNCA_testcase} object
#' @details
#' @export
#'
#' @examples
load_test_case <- function(path = NULL,
                           ard_path = NULL,
                           flg_path = NULL,
                           mct_path = NULL,
                           param_path = NULL
                           ) {
if(is.null(path) & all(c(is.null(ard_path),is.null(flg_path),
                         is.null(mct_path),is.null(param_path)))){
 stop("You must supply either a single path, or individual paths to each file")
}

if(!is.null(path)){

files <- list.files(path, pattern = "(ARD|FLG|MCT|PARAM)", full.names = TRUE)

test_case <- c("ARD" = "ARD",
               "FLG" = "FLG",
               "MCT" = "MCT",
               "PARAM" = "PARAM")

purrr::walk(test_case,
            ~if(!any(grepl(.x, files))){
              stop(glue::glue("{(.x)} not found, please check the path"))
              })



ls_data <- purrr::map_chr(test_case,
                          ~stringr::str_subset(string = files,
                                               pattern = .x)) %>%
           purrr::map(readr::read_csv, col_types = readr::cols()) %>%
           purrr::modify(~dplyr::mutate(.x, dplyr::across(where(is.character),
                                                          as.factor)))

tc <- make_test_case(ard = ls_data[["ARD"]],
                     flg = ls_data[["FLG"]],
                     mct = ls_data[["MCT"]],
                     param = ls_data[["PARAM"]])
} else {
  tc <- make_test_case(ard = readr::read_csv(ard_path),
                       flg = readr::read_csv(flg_path),
                       mct = readr::read_csv(mct_path),
                       param = readr::read_csv(param_path))
}

return(tc)
}

#' Create an openNCA Test Case Object
#'
#' This function creates an object of class \code{openNCA_testcase} which
#' represents a unit of analysis. At a minimum this object contains four data
#' sets; The Analysis Ready Data set (ARD), the Model Configuration Template
#' data set (MCT), the Flags data set (FLG), and the parameters data set
#' (PARAM). These are all stored as \code{data.frame} objects.
#'
#' @param ard \code{data.frame}
#' @param flg \code{data.frame}
#' @param mct \code{data.frame}
#' @param param \code{data.frame}
#'
#' @return a \code{openNCA_testcase} object
#' @export
#'
#' @examples
make_test_case <- function(ard, flg, mct, param) {
# TODO make a more general s4/r6 constructor

test_case <- list("ARD" = ard,
                  "FLG" = flg,
                  "MCT" = mct,
                  "PARAM" = param)

test_cast <- test_case %>%
             purrr::modify(~dplyr::mutate(.x, dplyr::across(where(is.character),
                                                            as.factor)))


# make a 'working data set' for modifying
test_case$WDS <- test_case$PARAM
# Make slots (empty) for units and labels to appended later
test_case$unit <- NULL
test_case$unit_class <- NULL
test_case$label <- NULL
test_case$exclusions <- NULL

class(test_case) <- "openNCA_testcase"
return(test_case)
}

update_label <- function(x, label){
  attr(x, which = "label") <- label
  x
}

#' Update the Label of a Variable in a \code{data.frame}
#'
#' @param df a \code{data.frame}
#' @param var \code{chr}, the name of the variable to add a label to
#' @param label \code{chr}, the new label to give to \code{var}
#'
#' @return the input \code{data.frame} \code{df} with the variable \code{var}
#'   updated with a label
#'
#' @examples
update_label_df_var <- function(df, var, label) {
    df[[var]] <- update_label(df[[var]], label)
    df
}

#' Update \code{data.frame} Variable Lables
#'
#' This function will update multiple variable labels at once
#'
#' @param df a \code{data.frame}
#' @param ... The variables to label, should be called like: \code{var_1 =
#'   "label_1"}
#'
#' @return The input, \code{df}, with the listed labels applied
#' @export
#'
#' @examples \dontrun{
#'   update_label_df(iris, Sepal.Length = "Sepal Length",
#'                   Species = "Iris Species")
#'                   }
update_label_df <- function(df, ...){
  df_names <-  names(df)
  args <- list(...)
  names_args <- names(args)
  missing_vars <-  setdiff(names_args, df_names)
  if(length(missing_vars) > 0) {
    stop("Some variables are not present in the input data")
  }
  for(var in seq_along(args)){
    var_i <- names_args[var]
    if(var_i %in% df_names){
      lab_i <- args[[var]]
      df <- update_label_df_var(df, var_i, lab_i)
    }
  }
  df
}

#' Get ARD Dataset from Test-Case
#'
#' Simple convenience function for accessing the ARD Dataset
#'
#' @param tc an \code{openNCA_testcase} object
#'
#' @return The ARD, a \code{data.frame} for the test case
#' @export
get_ard <- function(tc) {
  stopifnot(class(tc) == "openNCA_testcase")
  return(purrr::pluck(tc, "ARD"))
}

#' Get MCT Dataset from Test-Case
#'
#' Simple convenience function for accessing the MCT Dataset
#'
#' @param tc an \code{openNCA_testcase} object
#'
#' @return The MCT, a \code{data.frame} for the test case
#' @export
get_mct <- function(tc) {
  stopifnot(class(tc) == "openNCA_testcase")
  return(purrr::pluck(tc, "MCT"))
}

#' Get FLG Dataset from Test-Case
#'
#' Simple convenience function for accessing the FLG Dataset
#'
#' @param tc an \code{openNCA_testcase} object
#'
#' @return The FLG, a \code{data.frame} for the test case
#' @export
get_flg <- function(tc) {
  stopifnot(class(tc) == "openNCA_testcase")
  return(purrr::pluck(tc, "FLG"))
}

#' Get PARAM Dataset from Test-Case
#'
#' Simple convenience function for accessing the PARAM Dataset
#'
#' @param tc an \code{openNCA_testcase} object
#'
#' @return The PARAM Dataset, a \code{data.frame} for the test case
#' @export
get_param <- function(tc) {
  stopifnot(class(tc) == "openNCA_testcase")
  return(purrr::pluck(tc, "PARAM"))
}

#' Get WDS from Test-Case
#'
#' Simple convenience function for accessing the Working Dataset
#'
#' @param tc an \code{openNCA_testcase} object
#'
#' @return The working dataset, a \code{data.frame} for the test case
#' @export
get_wds <- function(tc) {
  stopifnot(class(tc) == "openNCA_testcase")
  return(purrr::pluck(tc, "WDS"))
}

#' Remove Profiles Flagged for Exclusion from the Working Data Set
#'
#' @param tc \code{openNCA_testcase} object, the input test case
#' @param flg \code{chr}, the parameter name in the WDS which corresponds to the
#'   exclusion flag
#' @param profile \code{chr}, the parameter name in the WDS which corresponds to
#'   an identifier of one experimental unit of analysis
#' @param by \code{chr}, the parameter name in the WDS which corresponds to
#'   summary grouping parameter
#'
#' @return tc \code{openNCA_testcase} object, the input test case with the
#'   modified WDS post exclusion
#' @export
#'
#' @examples
filter_wds_exclusions <- function(tc, flg, profile, by) {
  exclusions <- as.logical(tc[["WDS"]][[flg]]) 
  
  exclusions <- exclusions[match(tc[["WDS"]][[profile]],
                                         tc[["WDS"]][[profile]])]
  df_excl <- data.frame(EXCL = exclusions)

  df_excl[[profile]] <- tc[["WDS"]][[profile]]
  df_excl[[by]] <- tc[["WDS"]][[by]]

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

