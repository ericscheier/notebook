library(shiny)

parseURL <- function(query, variable, params){
  if (!is.null(query[[variable]])) {
    params[[variable]] <<- query[[variable]]
  }
}

shinyApp(
  ui = fluidPage(
    mainPanel(
      plotOutput("plot"),
      plotOutput("another.plot")
    )
  ),
  server = function(input, output, session) {
    params <<- list(n=5, q=10)
    observe({
      query <- parseQueryString(session$clientData$url_search)
      for (variable in names(query)){
        parseURL(query=query, variable=variable, params=params)
      }
      # if (!is.null(query[['n']])) {
      #   params[['n']] <<- query[['n']]
      # }
      # if (!is.null(query[['q']])) {
      #   params[['q']] <<- query[['q']]
      # }
    })
    output$plot <- renderPlot({
      # Add a little noise to the cars data
      plot(cars[sample(nrow(cars), params$n), ])
    })
    output$another.plot <- renderPlot({
      plot(cars[sample(nrow(cars), params$q), ])
    })
  }
)