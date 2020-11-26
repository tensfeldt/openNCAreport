make_summary_plan <- function(data,
                              summary_formula = list(numeric = is.numeric ~ sum_mean,
                                                     factor = is.factor ~ sum_fact),
                              by = NULL){
  # grab predicate functions and assoc summary functions
  sum_fmla <- list(numeric = is.numeric ~ sum_mean + sum_iqr,
                   factor = is.factor ~ sum_fact)

  sum_fun <- purrr::map(sum_fmla, ~purrr::pluck(.x, 3) %>%
                        as.list() %>%
                        purrr::discard(~deparse(.x) == "+"))

  by <- rlang::enquo(by)
  # if by (unquoted) is NULL, create blank quosure
  if(is.null(rlang::quo_get_expr(by))){


    plan <-  pred_summary %>%
      # select variables of each type
      purrr::imap(~dplyr::select(data, where(.x))) %>%
      # drop any empty datasets
      purrr::discard(~ncol(.x) == 0) %>%
      # add grouping variable
      purrr::map(~tidyr::pivot_longer(data = .x,
                                      cols = dplyr::everything(),
                                      names_to = "variable") %>%
                   dplyr::group_by(variable) %>%
                   nest() %>%
                   dplyr::mutate(statistic = statistic))


  } else {

    # take grouping variable(s)
    df_grps <- data %>%
      select(!!by)


    plan <-  class_tests %>%
      # select variables of each type (minus grouping var)
      purrr::imap(~dplyr::select(data, where(.x), -!!by)) %>%
      # drop any empty datasets
      purrr::discard(~ncol(.x) == 0) %>%
      # add grouping variable
      purrr::map(~bind_cols(.x, df_grps) %>%
                   tidyr::pivot_longer(-!!by, names_to = "variable") %>%
                   dplyr::group_by(!!by, variable) %>%
                   nest() %>%
                   dplyr::mutate(statistic = statistic))

  }


  plan
}
