source('../../R/private.R')

context("checkers")

test_that("check_prob works", {
  expect_true(check_prob(0.5))
  expect_length(check_prob(0.5),1)
  expect_error(check_prob(-1),"p has to be a number between 0 and 1")
})
test_that("check_trials works", {
  expect_equal(check_trials(5),TRUE)
  expect_length(check_trials(5),1)
  expect_error(check_trials(3.5),"invalid trials value")
})
test_that("check_success works", {
  expect_equal(check_success(3,5),TRUE)
  expect_equal(check_success(c(3,4,5),5),TRUE)
  expect_error(check_success(5,3),"success cannot be greater than trials")
})
