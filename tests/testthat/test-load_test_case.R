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
  # check names
  expect_named(test_tc, c("ARD", "FLG", "MCT", "PARAM", "WDS"))


  # Object should be identical to the stored record

  expected <- readRDS(system.file("test_data",
                                  "test_tc.Rds",
                                  package = "openNCAreport"))
  expect_equal(test_tc, expected)

  # check error behavior
  # cant give path and other paths
  expect_error(test_tc <- load_test_case(path = "",
                                         ard_path = ard,
                                         flg_path = flg,
                                         mct_path = mct,
                                         param_path = param),
      "You must supply either a single path, or individual paths to each file")

  expect_error(test_tc <- load_test_case(path = "bad/path"),
               "Path does not exist, please check again")


})
