make_summary_plan <- function(data,
                              summary_formula = list(numeric = is.numeric ~ sum_mean,
                                                     factor = is.factor ~ sum_fact),
                              by = NULL){
  browser()
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
                                       purrr::map(~dplyr::select(df_wrk, where(get(.x)))),
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
  }
                  
                  

  
  # by <- rlang::enquo(by)
  # # if by (unquoted) is NULL, create blank quosure
  # if(is.null(rlang::quo_get_expr(by))){
  #   summary_plan <-  summary_plan %>%
  #     # select variables of each type
  #     purrr::pmap() %>%
  #     # drop any empty datasets
  #     purrr::discard(~ncol(.x) == 0) %>%
  #     # add grouping variable
  #     purrr::map(~tidyr::pivot_longer(data = .x,
  #                                     cols = dplyr::everything(),
  #                                     names_to = "variable") %>%
  #                  dplyr::group_by(variable) %>%
  #                  nest() %>%
  #                  dplyr::mutate(statistic = statistic))
  # 
  # 
  # } else {
  # 
  #   # take grouping variable(s)
  #   df_grps <- data %>%
  #     select(!!by)
  # 
  # 
  #   plan <-  class_tests %>%
  #     # select variables of each type (minus grouping var)
  #     purrr::imap(~dplyr::select(data, where(.x), -!!by)) %>%
  #     # drop any empty datasets
  #     purrr::discard(~ncol(.x) == 0) %>%
  #     # add grouping variable
  #     purrr::map(~bind_cols(.x, df_grps) %>%
  #                  tidyr::pivot_longer(-!!by, names_to = "variable") %>%
  #                  dplyr::group_by(!!by, variable) %>%
  #                  nest() %>%
  #                  dplyr::mutate(statistic = statistic))
  # 
  # }


  summary_plan
}
