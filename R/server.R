#' Server for the GPCAH Surveillance of Agriculture Injuries in Iowa Web
#' Application
#'
#' Creates the server side for the web application.
#'
#' @param input The input from the user of the web application. These inputs are
#' based on the injury characteristics and demographics of the injury record of
#' interest.
#' @param output The a table to be viewed by the user.
#'
#' @details The server creation depends on [shiny::renderTable()] and the
#' [agstudy1app:pred_prob()] functions. For more information on how the output
#' is generated see the [Web Application User Guide](https://ph-ivshiny.iowa.uiowa.edu/deboonstra/agstudy1app/).
#'
#' @return A `view` document created by [shiny::renderTable()].
#'
#' @export server
server <- function(input, output) {
  # To view the predicted probabilities
  output$view <- shiny::renderTable(expr = {
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
        agstudy1app::pred_prob(
          sex = input$sex,
          cause = input$cause,
          nature = input$nature,
          age = age_seq
        )
      } else {
        hold <- lapply(
          X = seq_along(age_seq),
          FUN = function(i) {
            agstudy1app::pred_prob(
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
      agstudy1app::pred_prob(
        sex = input$sex,
        cause = input$cause,
        nature = input$nature,
        age = NULL
      )
    }
  })
  return(output$view)
}