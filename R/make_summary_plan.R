make_summary_plan <- function(data,
                              # TODO we need to have mechanism to reference variables directly
                              summary_formula = NULL,
                              by = NULL){
  # input validation
  if(!all(purrr::map_lgl(summary_formula, check_fmla_operators))) stop("Your summary formulae contain operators other than `~` & `|`, which is currently not supported")

  # tidy plan
  summary_plan <- purrr::map(summary_formula,
                             ~list(predicate = get_fmla_response(.x),
                                   summary = get_fmla_predictors(.x)))

  # sort out grouping vars
  by <- rlang::enquo(by)
  # if by (unquoted) is not NULL, run data prep with grouping
  if(!is.null(rlang::quo_get_expr(by))){
  # separate groups and working variables
  df_grps <- data %>%
             dplyr::select(!!by)
  
  df_wrk <- data %>%
            dplyr::select(-!!by)
  
  summary_plan <- summary_plan %>%
                  # from the plan, select the data based on predicate and store
                  # the asssoc summary fns
                  purrr::map(~c(data = purrr::pluck(.x, 1) %>%
                                       purrr::map(~dplyr::select(df_wrk, .x)),
                                fn = purrr::pluck(.x, 2))) %>%
                  # drop entries with no data
                  purrr::discard(~ncol(.x$data) == 0) %>%
                  # add grouping variables
                  purrr::map(~purrr::modify_at(.x, .at = "data",
                                              ~cbind(df_grps, .x))) %>%
                  # pivot_longer all the data
                  purrr::map(~purrr::modify_at(.x, .at = "data",
                                               ~tidyr::pivot_longer(data = .x,
                                                                    cols = -!!by,
                                                                    names_to = "variable") %>%
                                               dplyr::group_by(!!by, variable) %>%
                                               tidyr::nest()))
  } else {
  # else run data pre-proc without grouping  
  summary_plan <- summary_plan %>%
                  # from the plan, select the data based on predicate and store
                  # the asssoc summary fns
                  purrr::map(~c(data = purrr::pluck(.x, 1) %>%
                                       purrr::map(~dplyr::select(data, where(get(.x)))),
                                fn = purrr::pluck(.x, 2))) %>%
                  # drop entries with no data
                  purrr::discard(~ncol(.x$data) == 0) %>%
                  # pivot_longer all the data
                  purrr::map(~purrr::modify_at(.x, .at = "data",
                                               ~tidyr::pivot_longer(data = .x,
                                                                    cols = dplyr::everything(),
                                                                    names_to = "variable") %>%
                                               dplyr::group_by(variable) %>%
                                               tidyr::nest()))
  }

  summary_plan
}


compute_summary <- function(data, fun) {
  data %>%
    tidyr::unnest("data") %>%
    dplyr::group_by(grp, variable) %>%
    dplyr::summarise(dplyr::across(value, get(fun), .names = "{fun}"))
}
