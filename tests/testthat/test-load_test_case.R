test_that("load_test_case", {

  ard <- system.file("test_data",
                     "ARD_0026.csv",
                     package = "openNCAreport")

  flg <- system.file("test_data",
                     "FLG_0026.csv",
                     package = "openNCAreport")

  mct <- system.file("test_data",
                     "MCT_0026.csv",
                     package = "openNCAreport")

  param <- system.file("test_data",
                       "PARAM_0026.csv",
                       package = "openNCAreport")

  test_tc <- load_test_case(ard_path = ard,
                            flg_path = flg,
                            mct_path = mct,
                            param_path = param)


})
