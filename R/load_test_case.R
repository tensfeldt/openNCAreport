

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
