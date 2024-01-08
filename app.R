# Loading libraries ####
library(shiny)
library(shinythemes)
library(agstudy1app)

# Running app ####
ui <- agstudy1app::ui()
server <- agstudy1app::server
options(shiny.autoload.r = FALSE)
shiny::shinyApp(ui = ui, server = server)