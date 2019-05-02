source('../../R/functions.R')
source('../../R/private.R')

context("binomial")

test_that("bin_choose works", {
  expect_equal(bin_choose(5,2),10)
  expect_length(bin_choose(5,2),1)
  expect_error(bin_choose(2,5),'k cannot be greater than n')
})
test_that("bin_probability works", {
  expect_equal(bin_probability(2,5,0.5),0.3125)
  expect_length(bin_probability(2,5,0.5),1)
  expect_equal(bin_probability(0:2,5,0.5),c(0.03125,0.15625,0.31250))
})
test_that("bin_distribution works", {
  expect_equal(bin_distribution(5,0.5)$probability,c(0.03125, 0.15625, 0.31250, 0.31250, 0.15625, 0.03125))
  expect_length(bin_distribution(5,0.5)$success,6)
  expect_is(bin_distribution(5,0.5),'bindis')
})
test_that("bin_cumulative works", {
  expect_equal(bin_cumulative(5,0.5)$cumulative,c(0.03125, 0.18750,0.50000,0.81250,0.96875,1))
  expect_length(bin_cumulative(5,0.5)$success,6)
  expect_is(bin_cumulative(5,0.5),'bincum')
})
