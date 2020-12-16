test_that("make_blank", {
  # this function should take any object and reutrn a blank factor
  expect_equal(make_blank("any text"), factor(""))
  expect_equal(make_blank(TRUE), factor(""))
  expect_equal(make_blank(datasets::iris), factor(""))
  expect_equal(make_blank(LETTERS), factor(""))
})


test_that("pred_factory", {
  # make set inclusion predicate for letters[1:5] (a, b, c, d, e)
  out <- pred_factory(letters[1:5])
  # check that pred works for members in set
  expect_true(out("b"))
  # check that pred works for members not in set
  expect_false(out("f"))

})
