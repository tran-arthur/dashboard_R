library(shiny)

# Création de l'application shiny
shinyApp(
  ui <- source("ui.R"),
  server <- source("server.R")
) 