# README.md

## Summary

**binomial** is a R package that provides functions to help calculate statistics for binomial random variables and plot binomial distributions. This package was created for the workout03 assignment for Stat133 Spring 19.

## Installation
Using **devtools** R package, the user can install this version from GitHub using these commands.

```
# if you do not have devtools yet
install.packages("devtools")

# installing the "binomial" package without vignettes
devtools::install_github("stat133-sp19/hw-stat133-merryle-wang/workout03/binomial")

# installing the "binomial" package with vignettes
devtools::install_github("stat133-sp19/hw-stat133-merryle-wang/workout03/binomial",build_vignettes = TRUE)
```


## Quick Start
```
library(binomial)
# creates a binomial random variable
x <- bin_variable(10,0.3)

# prints out the parameters of this random variable
print(x)

# calculates and prints statistics of this random variable
print(summary(x))

# creates dataframe containing the binomial distribution given 10 trials and a 0.3 success rate
bin_distribution(10,0.3)

# plots the dataframe containing the distribution
plot(bin_distribution(10,0.3)
```
