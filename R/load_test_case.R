

load_test_case <- function(path) {
files <- list.files(path, pattern = "(ARD|FLG|MCT|PARAM)_||D{4}\\.csv")

test_case <- c("ARD" = "ARD",
               "FLG" = "FLG",
               "MCT" = "MCT",
               "PARAM" = "PARAM")

purrr::walk(test_case,
            ~if(!any(grepl(.x, files))) stop(glue::glue("{(.x)} not found, please check the path")))

# build paths
files <- file.path(path, files)
ls_data <- purrr::imap_chr(test_case,
                           ~stringr::str_subset(string = files,
                                                pattern = .x)) %>%
           purrr::imap(readr::read_csv)

class(ls_data) <- "openNCA_testcase"
return(ls_data)
}

