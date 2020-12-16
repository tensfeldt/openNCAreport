test_that("gm_mean", {
  expect_equal(gm_mean(1:10), 4.52872868811677)
  expect_equal(gm_mean(1E3:10E4), 38539.1045558238)
})

test_that("gm_cv", {
  expect_equal(gm_cv(1:10), 84.3457731869319)
  expect_equal(gm_cv(1E3:10E4), 109.065888923162)
})

test_that("mean_pl_sd", {
  expect_equal(mean_pl_sd(1:10), 8.52765035409749)
  expect_equal(mean_pl_sd(1E3:10E4), 79079.2713372239)
})

test_that("mean_mi_sd", {
  expect_equal(mean_mi_sd(1:10), 2.47234964590251)
  expect_equal(mean_mi_sd(1E3:10E4), 21920.7286627761)
})

test_that("upper_range", {
  expect_equal(upper_range(1:10), 10)
  expect_equal(upper_range(1E3:10E4), 10E4)
})

test_that("lower_range", {
  expect_equal(lower_range(1:10), 1)
  expect_equal(lower_range(1E3:10E4), 1E3)
})

test_that("little_n", {
  expect_equal(little_n(datasets::airquality$Wind > 15), 10)
  expect_equal(little_n(c(TRUE, FALSE, FALSE)), 1)
})
