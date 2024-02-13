library(shiny)
library(plotly)

# Création de l'interface utilisateur
# Chaque fonction plotOutput(...) est responsable de l'affichage d'un visuel
# plotlyOutput(...) permet un affichage interactif
# div(...) ajoute un espace entre les graphiques

fluidPage(
  
  titlePanel("Dashboard sur les milliardaires du monde"),
  
  mainPanel(
    
    div(style = "height: 30px;"),
    plotOutput("barchart", width = "150%", height = "450px"),
    
    div(style = "height: 30px;"),
    plotlyOutput("map_count", width = "150%", height = "450px"),
    
    div(style = "height: 30px;"),
    plotOutput("histogram", width = "150%", height = "450px"),
    
    div(style = "height: 30px;"),
    plotlyOutput("map_worth", width = "150%", height = "450px"),
    
    div(style = "height: 30px;"),
    plotOutput("boxplot", width = "150%", height = "450px"),
    
    div(style = "height: 30px;"),
    fluidRow(
      selectInput("variable", "Sélectionnez une variable :",
                  choices = c("Selfmade", "Sexe"),
                  selected = "Sexe"),
    ),
    plotlyOutput("dyn_piechart")
    
  )
)





