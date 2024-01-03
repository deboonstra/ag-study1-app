# Checking packages ####
if (!("shiny" %in% installed.packages()[, 1])) {
  utils::install.packages("shiny")
}
if (!("shinythemes" %in% installed.packages()[, 1])) {
  utils::install.packages("shinythemes")
}
if (!("remotes" %in% installed.packages()[, 1])) {
  utils::install.packages("remotes")
}
if (!("agstudy1app" %in% installed.packages()[, 1])) {
  remotes::install_github("deboonstra/agstudy1app")
}


# Loading libraries ####
library(shiny)
library(shinythemes)
library(agstudy1app)

# Running app ####
shiny::runApp(appDir = "app")
