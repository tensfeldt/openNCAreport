test_that("assign_wds_labels", {
  # load the test data
  test_tc <-
    readRDS(system.file("test_data",
                        "test_tc.Rds",
                        package = "openNCAreport"))

  # verify the test case is unlabelled
  expect_null(attr(test_tc[["WDS"]]$TMAX1, which = "label"))

  # use function to update the labels
  test_tc <- assign_wds_labels(test_tc)

  # check some labels
  expect_equal(attr(test_tc[["WDS"]]$TMAX1, which = "label"), 'TMAX (HR)')
  expect_equal(attr(test_tc[["WDS"]]$AUC2, which = "label"), 'AUCT (NG.HR/ML)')
  expect_equal(attr(test_tc[["WDS"]]$CMAX1, which = "label"), 'CMAX (NG/ML)')

})


test_that("get_parameter_unit", {
  # load the test data
  test_tc <-
    readRDS(system.file("test_data",
                        "test_tc.Rds",
                        package = "openNCAreport"))

  # test label for expected var
  out_1 <- get_parameter_unit(x = "TMAX", mct = test_tc[["MCT"]])
  expect_equal(out_1, "HR")

  # test label for unexpected var
  out_2 <- get_parameter_unit(x = "SDEID", mct = test_tc[["MCT"]])
  expect_equal(out_2, "")

})

test_that("get_parameter_unit_class", {

  # test label for expected var
  out_1 <- get_parameter_unit_class(x = "TMAX")
  expect_equal(out_1, "TIMEU")

  # test label for unexpected var
  out_2 <- get_parameter_unit_class(x = "SDEID")
  expect_equal(out_2, "")

})

test_that("get_parameter_label", {

  # test label for expected var
  out_1 <- get_parameter_label(x = "TMAX")
  expect_equal(out_1, "TMAX")

  # test label for unexpected var
  out_2 <- get_parameter_unit_class(x = "SDEID")
  expect_equal(out_2, "")

})

test_that("update_label_df", {
  out <- update_label_df(datasets::iris,
                         Sepal.Length = "Sepal Length (cm)",
                         Sepal.Width = "Sepal Width (cm)")

  # labels will be in the attributes
  out_1 <- attr(out$Sepal.Length, which = "label")
  out_2 <- attr(out$Sepal.Width, which = "label")

  # test
  expect_equal(out_1, "Sepal Length (cm)")
  expect_equal(out_2, "Sepal Width (cm)")
  }
)



