# Checking packages
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


# Loading libraries
library(shiny)
library(shinythemes)
library(agstudy1app)


# Creating UI

ui <- navbarPage(
  title = "GPACH Surveillance of Agriculture Injuries in Iowa",
  theme = shinythemes::shinytheme("flatly"),
  tabPanel(
    title = "Application User Guide",
    withMathJax(includeHTML("./docs/app_guide.html"))
  ),
  tabPanel(
    title = "Modeling overview",
    withMathJax(includeHTML("./docs/modeling_overview.html"))
  ),
  tabPanel(
    title = "Predicted Probabilities",
    pageWithSidebar(
      ## App title
      headerPanel(
        paste0(
          "Predicted Probabilities for the Surveillance of Iowa's",
          " Agricultural Injuries"
        )
      ),

      ## Sidebar panel for inputs
      sidebarPanel(
        ### Input: selector for sex
        selectInput(
          inputId = "sex",
          label = "Sex",
          choices = c(
            "Average of effect" = "NULL",
            "Male" = "Male",
            "Female" = "Female"
          )
        ),

        ### Input: selector for cause of injury value
        selectInput(
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
        selectInput(
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
        sliderInput(
          inputId = "min_age",
          label = "Minimum Age",
          min = min(agstudy1app::iwc_itr_only$age),
          max = max(agstudy1app::iwc_itr_only$age),
          value = median(agstudy1app::iwc_itr_only$age),
          step = 1
        ),

        ### Input: Numeric entry for maximum age to consider
        sliderInput(
          inputId = "max_age",
          label = "Maximum Age",
          min = min(agstudy1app::iwc_itr_only$age),
          max = max(agstudy1app::iwc_itr_only$age),
          value = median(agstudy1app::iwc_itr_only$age),
          step = 1
        ),

        ### Input: Check box to denote if age should be considered
        checkboxInput(
          "age",
          "Include age in calculation of predicted probabilities",
          FALSE
        ),

        ### Input: Check box to denote if multiple probabilities to should
        ### produced
        checkboxInput(
          "mult",
          "Calculate multiple predicted probabilities",
          FALSE
        ),
      ),

      ## Main panel for displaying outputs
      mainPanel(
        tableOutput(outputId = "view")
      )
    )
  )
)

server <- function(input, output) {
  # To view the predicted probabilities
  output$view <- renderTable(expr = {
    ## Checking whether age should be included in the predicted probabilities
    check_age <- input$age

    if (check_age) {
      ### If age should be then we do the following:

      #### Creating easy to access variables for min and max age, and logical
      #### denoting whether multiple probabilities should be calculated
      min_age <- input$min_age
      max_age <- input$max_age
      check_mult <- input$mult

      #### Adjusting for incorrect inputs of min and max age (i.e., if the user
      #### switches them)
      temp1 <- min_age
      temp2 <- max_age
      if (min_age > max_age) {
        max_age <- temp1
        min_age <- temp2
      }

      #### Coming up with a vector of age values
      if ((round(max_age - min_age, 0) > 0) & (check_mult == FALSE)) {
        ##### This produces a mean age for a single probability of an age range
        age_seq <- mean(c(max_age, min_age))
      } else if ((round(max_age - min_age, 0) > 0) & (check_mult == TRUE)) {
        ##### This produces a sequence of ages for multiple probabilities of an
        ##### age range
        age_seq <- seq(from = min_age, to = max_age, by = 1)
      } else if ((round(max_age - min_age, 0) == 0) & (check_mult == TRUE)) {
        ##### This produces a mean age for a single probability given only 1 age
        ##### value was inputted
        age_seq <- mean(c(max_age, min_age))
      } else if ((round(max_age - min_age, 0) == 0) & (check_mult == FALSE)) {
        ##### This produces a mean age for a single probability given only age
        ##### value is inputted
        ##### and the user only wants a single probability_
        age_seq <- mean(c(max_age, min_age))
      }

      #### Calculating predicted probabilities
      if (length(age_seq) == 1) {
        pred_prob(
          sex = input$sex,
          cause = input$cause,
          nature = input$nature,
          age = age_seq
        )
      } else {
        hold <- lapply(
          X = seq_along(age_seq),
          FUN = function(i) {
            pred_prob(
              sex = input$sex,
              cause = input$cause,
              nature = input$nature,
              age = age_seq[i]
            )
          }
        )
        dplyr::bind_rows(hold)
      }
    } else {
      pred_prob(
        sex = input$sex,
        cause = input$cause,
        nature = input$nature,
        age = NULL
      )
    }
  })
}

shinyApp(ui, server)
