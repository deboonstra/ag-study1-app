#' Runs the GPCAH Surveillance of Agriculture Injuries in Iowa Web Application
#'
#' Runs a local version of the web application using [shiny::shinyApp()]
#' and [shiny::runApp()].
#'
#' @details This will only execute if the current working directory contains the
#' *Web Application User Guide* (`"./docs/app_guide.html"`) and the *Modeling
#' Framework* (`"./docs/modeling_overview.html"`).
#'
#' @seealso [shiny::shinyApp()], [shiny::runApp()]
#'
#' @examples
#' if (interactive()) {
#'  agstudy1app::launch()
#' }
#'
#' @export launch
launch <- function() {
  ui <- agstudy1app::ui()
  server <- agstudy1app::server
  test1 <- file.exists("./docs/app_guide.html")
  test2 <- file.exists("./docs/modeling_overview.html")
  if (test1 && test2) {
    options(shiny.autoload.r = FALSE)
    shiny::shinyApp(ui = ui, server = server)
  }
}