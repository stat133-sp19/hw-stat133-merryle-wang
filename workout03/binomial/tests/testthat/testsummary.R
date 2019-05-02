source('../../R/privateaux.R')

context("summary")

test_that("aux_mean works", {
  expect_equal(aux_mean(5,0.3),1.5)
  expect_length(aux_mean(5,0.3),1)
  expect_equal(aux_mean(2,0.5),1)
})
test_that("aux_variance works", {
  expect_equal(aux_variance(10,0.3),2.1)
  expect_length(aux_variance(5,0.3),1)
  expect_equal(aux_variance(2,0.5),0.5)
})
test_that("aux_mode works", {
  expect_equal(aux_mode(10,0.3),3)
  expect_length(aux_mode(5,0.3),1)
  expect_equal(aux_mode(2,0.5),1)
})
test_that("aux_skewness works", {
  expect_equal(aux_skewness(10,0.5),0)
  expect_length(aux_skewness(5,0.3),1)
  expect_equal(aux_skewness(2,0.5),0)
})
test_that("aux_kurtosis works", {
  expect_equal(aux_kurtosis(10,0.5),-0.2)
  expect_length(aux_kurtosis(5,0.3),1)
  expect_equal(aux_kurtosis(2,0.5),-1)
})
