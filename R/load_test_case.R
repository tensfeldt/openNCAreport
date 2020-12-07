

load_test_case <- function(path) {
files <- list.files(path, pattern = "(ARD|FLG|MCT|PARAM)", full.names = TRUE)

test_case <- c("ARD" = "ARD",
               "FLG" = "FLG",
               "MCT" = "MCT",
               "PARAM" = "PARAM")

purrr::walk(test_case,
            ~if(!any(grepl(.x, files))) stop(glue::glue("{(.x)} not found, please check the path")))


ls_data <- purrr::map_chr(test_case,
                          ~stringr::str_subset(string = files,
                                               pattern = .x)) %>%
           purrr::map(readr::read_csv, col_types = readr::cols()) %>%
           purrr::modify(~mutate(.x, across(where(is.character), as.factor)))

class(ls_data) <- "openNCA_testcase"
return(ls_data)
}

make_test_case <- function(ard, flg, mct, param) {

test_case <- list("ARD" = ard,
                  "FLG" = flg,
                  "MCT" = mct,
                  "PARAM" = param)

test_cast <- test_case %>%
             purrr::modify(~mutate(.x, across(where(is.character), as.factor)))



class(ls_data) <- "openNCA_testcase"
return(ls_data)
}

update_label <- function(x, label){
  attr(x, which = "label") = label
  x
}

update_label_df_var <- function(df, var, label) {
    df[[var]] <- update_label(df[[var]], label)
    df
}

update_labels_df <- function(df, ...){
  df_names <-  names(df)
  args <- list(...)
  names_args <- names(args)
  missing_vars <-  setdiff(names_args, df_names)
  if(length(missing_vars) > 0) stop("Some variables are not present in the input data")
  for(var in seq_along(args)){
    var_i <- names_args[var]
    if(var_i %in% df_names){
      lab_i <- args[[var]]
      df <- update_label_df_var(df, var_i, lab_i)
    }
  }
  df
}

get_ard <- function(tc) {
  stopifnot(class(tc) == "openNCA_testcase")
  return(purrr::pluck(tc, "ARD"))
}

get_mct <- function(tc) {
  stopifnot(class(tc) == "openNCA_testcase")
  return(purrr::pluck(tc, "MCT"))
}

get_flg <- function(tc) {
  stopifnot(class(tc) == "openNCA_testcase")
  return(purrr::pluck(tc, "FLG"))
}

get_param <- function(tc) {
  stopifnot(class(tc) == "openNCA_testcase")
  return(purrr::pluck(tc, "PARAM"))
}
