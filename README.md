
<!-- README.md is generated from README.Rmd. Please edit that file -->

# agstudy1app – GPACH Surveillance of Agriculture Injuries in Iowa Web Application Package

The goal of agstudy1app is to be a supplementary package for the GPCAH
Surveillance of Agriculture Injuries in Iowa Web Application.

## Installation

You can install the development version of agstudy1app from
[GitHub](https://github.com/deboonstra/agstudy1app/tree/main) with:

## Installation

``` r
# install.packages("remotes")
remotes::install_github("deboonstra/agstudy1app")
```

## Useage

This is a basic example which shows you how to calculate the predicted
probabilities of a forty-five year old injured person using the
`pred_prob` function.

``` r
library(agstudy1app)
agstudy1app::pred_prob(age = mean(agstudy1app::iwc_itr_only$age))
```

| Source                | Sex | Cause | Nature |      Age | Probability |        LB |        UB |
|:----------------------|:----|:------|:-------|---------:|------------:|----------:|----------:|
| Workers’ compensation |     |       |        | 44.69383 |   0.5778771 | 0.5437128 | 0.6113121 |
| Trauma registry       |     |       |        | 44.69383 |   0.4221229 | 0.3886879 | 0.4562872 |

### Parameter values

The possible valid injury characteristics are listed in the help
document for `pred_prob`.

``` r
?agstudy1app::pred_prob()
```
