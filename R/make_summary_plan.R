make_summary_plan <- function(data,
                              summary_formula = list(numeric = is.numeric ~ sum_mean,
                                                     factor = is.factor ~ sum_fact),
                              by = NULL){
  browser()
  # input validation
  if(!all(map_lgl(summary_formula, check_fmla_operators))) stop("Your summary formulae contain operators other than `~` & `|`, which is currently not supported")


  summary_plan <- purrr::map(summary_formula,
                             ~list(predicate = get_fmla_response(.x),
                                   summary = get_fmla_predictors(.x)))
  
  summary_plan <- summary_plan %>%
                  map(~c(data = pluck(.x, 1) %>% map(~select(data, where(get(.x)))),
                          fn = pluck(.x, 2))) %>%
                  discard( ~ncol(.x$data) == 0)

  
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


  plan
}
