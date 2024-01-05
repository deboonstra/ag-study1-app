#' Runs the GPCAH Surveillance of Agriculture Injuries in Iowa Web Application
#'
#' Runs a local version of the web application using [shiny::shinyApp()].
#'
#' @param ui The UI definition of the app (for example, a call to fluidPage()
#' with nested controls). Default is [agstudy1app::ui()].
#' @param server A function with three parameters: input, output, and session.
#' The function is called once for each session ensuring that each app is
#' independent. Default is [agstudy1app::server()].
#'
#' @seealso [shiny::shinyApp()], [shiny::runApp()]
#'
#' @export app
app <- function(ui = agstudy1app::ui, server = agstudy1app::server) {
  require(shiny)
  require(shinythemes)
  app <- shiny::shinyApp(ui = ui, server = server)
  shiny::runApp(app)
}
