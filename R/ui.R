#' UI for the GPCAH Surveillance of Agriculture Injuries in Iowa Web Application
#'
#' Creates the UI for the web application based on navigation bar page that
#' includes an application user guide, an overview of the modeling framework,
#' and the web application.
#'
#' @details The UI depends on [shiny::navbarPage()] to create the navigation
#' bar page and [shinythemes::shinytheme()] to define the
#' [Bootswatch](https://bootswatch.com) theme of the application.
#'
#' For this UI, there are three pages to select from. The first is titled
#' *Web Application User Guide*, which is the user guide for the web
#' application. The second is an overview of modeling framework used to
#' calculate the predicted probabilities and is titled *Modeling Framework*.
#' The final page is titled *Web Application* and is the application itself.
#'
#' The user guide and modeling framework documents are based on two HTML
#' fragment stored within the `docs/` sub-directory. If these documents are
#' **NOT** created then *knit* the accompanied `.Rmd`s as one chooses. The
#' `makefile` can *knit* both documents with a simple call the the make file.
#'
#' @return A `list` created by [shiny::navbarPage()] containing HTML metadata to
#' be used by [agstudy1app::server].
#'
#' @export ui
ui <- shiny::navbarPage(
  title = paste0(
    "GPACH Surveillance of Agriculture Injuries",
    " in Iowa Web Application"
  ),
  theme = shinythemes::shinytheme("flatly"),
  shiny::tabPanel(
    title = "Web Application User Guide",
    shiny::withMathJax(
      htmltools::includeHTML("./docs/app_guide.html")
    )
  ),
  shiny::tabPanel(
    title = "Modeling Framework",
    shiny::withMathJax(
      htmltools::includeHTML("./docs/modeling_overview.html")
    )
  ),
  shiny::tabPanel(
    title = "Web Application",
    shiny::pageWithSidebar(
      ## App title
      shiny::headerPanel(
        paste0(
          "Predicted Probabilities for GPACH Surveillance of Agriculture",
          " Injuries in Iowa"
        )
      ),

      ## Sidebar panel for inputs
      shiny::sidebarPanel(
        ### Input: selector for sex
        shiny::selectInput(
          inputId = "sex",
          label = "Sex",
          choices = c(
            "Average of effect" = "NULL",
            "Male" = "Male",
            "Female" = "Female"
          )
        ),

        ### Input: selector for cause of injury value
        shiny::selectInput(
          inputId = "cause",
          label = "Cause of injury",
          choices = c(
            "Average of effect" = "NULL",
            "MVT" = "MVT",
            "Falls" = "Falls",
            "Fire/burn" = "Fire/burn",
            "Cut/pierce or struck by/against" = "Cut/pierce or struck by/against",
            "Machinery" = "Machinery",
            "Natural/Environment" = "Natural/Environment",
            "Missing/unspecified" = "Missing/unspecified",
            "Other" = "Other"
          )
        ),

        ### Input: selector for nature of injury value
        shiny::selectInput(
          inputId = "nature",
          label = "Nature of injury",
          choices = c(
            "Average of effect" = "NULL",
            "Fractures/dislocation/sprains/strains" = "Fractures/dislocation/sprains/strains",
            "Open Wound/superficial/contusion" = "Open Wound/superficial/contusion",
            "Burns" = "Burns",
            "Amputations" = "Amputations",
            "Missing/unspecified" = "Missing/unspecified",
            "Other" = "Other"
          )
        ),

        ### Input: Numeric entry for minimum age to consider
        shiny::sliderInput(
          inputId = "min_age",
          label = "Minimum Age",
          min = min(agstudy1app::iwc_itr_only$age),
          max = max(agstudy1app::iwc_itr_only$age),
          value = median(agstudy1app::iwc_itr_only$age),
          step = 1
        ),

        ### Input: Numeric entry for maximum age to consider
        shiny::sliderInput(
          inputId = "max_age",
          label = "Maximum Age",
          min = min(agstudy1app::iwc_itr_only$age),
          max = max(agstudy1app::iwc_itr_only$age),
          value = median(agstudy1app::iwc_itr_only$age),
          step = 1
        ),

        ### Input: Check box to denote if age should be considered
        shiny::checkboxInput(
          "age",
          "Include age in calculation of predicted probabilities",
          FALSE
        ),

        ### Input: Check box to denote if multiple probabilities to should
        ### produced
        shiny::checkboxInput(
          "mult",
          "Calculate multiple predicted probabilities",
          FALSE
        ),
      ),

      ## Main panel for displaying outputs
      shiny::mainPanel(
        shiny::tableOutput(outputId = "view")
      )
    )
  )
)