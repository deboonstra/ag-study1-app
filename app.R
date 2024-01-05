# Loading libraries ####
library(shiny)
library(shinythemes)
library(agstudy1app)

# Running app ####
options(shiny.autoload.r = FALSE) # not loading R/ sub-directory
agstudy1app::app()