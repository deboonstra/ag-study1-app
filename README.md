
<!-- README.md is generated from README.Rmd. Please edit that file -->

# agstudy1app – GPACH Surveillance of Agriculture Injuries in Iowa Web Application Package

The goal of `agstudy1app` is to be a supplementary package for the GPCAH
Surveillance of Agriculture Injuries in Iowa Web Application,
<https://ph-ivshiny.iowa.uiowa.edu/deboonstra/agstudy1app/>.

## Installation

You can install the development version of `agstudy1app` package from
[GitHub](https://github.com/deboonstra/agstudy1app/tree/main) with:

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
agstudy1app::pred_prob(age = 45)
```

| Source                | Sex | Cause | Nature | Age | Probability |        LB |        UB |
|:----------------------|:----|:------|:-------|----:|------------:|----------:|----------:|
| Workers’ compensation |     |       |        |  45 |   0.5753956 | 0.5411740 | 0.6089094 |
| Trauma registry       |     |       |        |  45 |   0.4246044 | 0.3910906 | 0.4588260 |

### Parameter values

The possible valid injury characteristics are listed in the help
document for `pred_prob`.

``` r
?agstudy1app::pred_prob()
```

## On-device useage of web application

Currently, the web application does not allow the user to download the
predicted probabilities calculated. Therefore, to obtain the
probabilities for external use, installation of the
[`agstudy1app`](https://github.com/deboonstra/agstudy1app) package is
required. Then, simply call the `agstudy1app::pred_prob()` function with
the injury characteristics of interest. If one choose to run the web
application on their local machine, they will need to `git clone` the
[`agstudy1app`](https://github.com/deboonstra/agstudy1app) repository to
their desired location. Then, in an interactive session of *R*, where
`agstudy1app` is the current working directory, execute the following
command.

``` r
agstudy1app::app()
```
