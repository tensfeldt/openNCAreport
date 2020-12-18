test_that("test table values", {
  
  `%>%` <- magrittr::`%>%`
  
  # load test case
  tc <- readRDS(system.file("test_data",
                            "test_tc.Rds",
                            package = "openNCAreport"))
  # params
  profile <- "SDEID"
  # This is an example test-case built into the package.
  tc_path <- system.file("test_data", package = "openNCAreport")
  flag <- "FLGACCEPTKEL"
  by <- "TREATXT"
  
  # apply some standard pre-proc
  tc <- tc %>% 
    assign_wds_labels() %>%
    filter_wds_exclusions(flg = flag,
                          profile = profile,
                          by = by) %>%
    select_wds_pars(dplyr::all_of(by), # use all_of() here as this is a string
                    AUCINFP,
                    AUCLAST,
                    AUC0..72,
                    CMAX1,
                    TMAX1,
                    THALF,
                    MRTP)
  
  # Build tables
  Nn <- tc$exclusions %>%
    dplyr::select(-dplyr::all_of(profile)) %>%
    gtsummary::tbl_summary(by = dplyr::all_of(by),
                           type = list(EXCL ~ 'continuous'),
                           statistic = c(EXCL ~ "{length}, {little_n}"),
                           digits = c(EXCL ~ 0),
                           label = c(EXCL ~"N, n")) %>%
    # remove auto-generated footnote
    gtsummary::modify_footnote(dplyr::everything() ~ NA)
  
  # Next we use the {gtsummary} engine to produce the summaries we want on each
  # parameter
  gts_tab <- tc$WDS %>%
    gtsummary::tbl_summary(by = dplyr::all_of(by),
                           digits = list(TMAX1 ~ c(2, 1, 1), # number of 
                                         THALF ~ c(2, 1),    # dig per 
                                         MRTP ~ c(2, 1)),    # stat 
                           statistic = c(
                             # param name ~ "{stat}" etc
                             AUCINFP ~ "{gm_mean} ({gm_cv})",
                             AUCLAST ~ "{gm_mean} ({gm_cv})",
                             AUC0..72 ~ "{gm_mean} ({gm_cv})",
                             CMAX1 ~ "{gm_mean} ({gm_cv})",
                             TMAX1 ~
                               "{median} ({lower_range}-{upper_range})",
                             THALF ~ "{mean} &plusmn {sd}",
                             MRTP ~ "{mean} &plusmn {sd}"
                           )) %>%
    # remove auto-generated footnote
    gtsummary::modify_footnote(dplyr::everything() ~ NA)
  
  # test the table contents 
  # Nn
  # expect equivalent here as some attributes aren't important to test
  expect_equivalent(Nn$table_body[1, ], data.frame(stringsAsFactors = FALSE,
                                              variable = c("EXCL"),
                                              row_type = c("label"),
                                              label = c("N, n"),
                                              stat_1 = c("16, 15"),
                                              stat_2 = c("17, 14"),
                                              stat_3 = c("16, 14"),
                                              stat_4 = c("16, 15")))
  
  # summary tab
  # labels
  expect_equal(gts_tab$table_body$label, c("AUCINF (NG.HR/ML)",
                                           "AUCLAST (NG.HR/ML)",
                                           "AUC0..72 (NG.HR/ML)",
                                           "CMAX (NG/ML)",
                                           "TMAX (HR)",
                                           "THALF (HR)",
                                           "MRTP"))
  # stats
  expect_equal(gts_tab$table_body$stat_1, c("224,342 (12)",
                                            "203,347 (10)",
                                            "145,937 (11)",
                                            "3,755 (18)",
                                            "4.00 (2.0-12.0)",
                                            "48.60 &plusmn 11.7",
                                            "69.69 &plusmn 15.6"))
  
  expect_equal(gts_tab$table_body$stat_2, c("243,952 (20)",
                                            "220,217 (15)",
                                            "160,160 (10)",
                                            "5,093 (17)",
                                            "2.51 (0.5-6.0)",
                                            "49.81 &plusmn 13.0",
                                            "69.35 &plusmn 17.2"))
  
  expect_equal(gts_tab$table_body$stat_3 , c("195,617 (18)",
                                             "182,749 (16)",
                                             "140,094 (13)",
                                             "4,767 (21)", 
                                             "1.50 (0.5-4.0)",
                                             "42.63 &plusmn 10.3",
                                             "58.17 &plusmn 12.7"))
  
  expect_equal(gts_tab$table_body$stat_4 , c(c("203,190 (23)",
                                               "185,700 (20)",
                                               "135,870 (14)",
                                               "4,098 (15)", 
                                               "3.00 (1.0-6.0)",
                                               "47.13 &plusmn 10.7",
                                               "66.43 &plusmn 15.0")))

  
})

