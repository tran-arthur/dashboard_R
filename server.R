library(shiny)
library(ggplot2)
library(maps)

function(input, output) {
  
  # Chargez les données depuis le script global.R
  source("global.R") 
  
  output$barchart <- renderPlot({
    ggplot(df_country, aes(x=country,y=count)) +
    geom_bar(stat = 'identity', fill = "steelblue") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) + #Rotation des noms des pays
    labs(title = "Barchart du nombre de milliardaires par pays")
  })
  
  output$map_count <- renderPlotly({
    
    # Création de la carte
    map <- map_data("world")
    map <- left_join(map, df_country, by = c("region" = "country"))
    
    ggplot(map, aes(x = long, y = lat, group = group,text=region, fill = count)) +
      geom_polygon(color = "white") + # Permet d'avoir des bordures blanches entre les pays
      scale_fill_gradient(low = "burlywood1", high = "saddlebrown") +
      labs(title = "Carte choroplète du nombre de milliardaires par pays",
           fill = "Nombre de milliardaires") +
      theme_minimal() # Permet d'avoir un fond blanc pour la carte
    
  })
  
  output$histogram <- renderPlot({
    ggplot(df_billionaires,aes(x=log_finalWorth)) + 
    geom_histogram(binwidth = 0.1, fill = "steelblue") +
    labs(x = "Valeur de la fortune des milliardaires (échelle logarithmique)", y = "Nombre",
         title="Histogramme de la distribution de la fortune des milliardaires")
  })
  
  output$map_worth <- renderPlotly({
    
    # Création de la carte
    map <- map_data("world")
    map <- left_join(map, df_country, by = c("region" = "country"))
    
    ggplot(map, aes(x = long, y = lat, group = group, text= region, fill = log_total_worth)) +
      geom_polygon(color = "white") + # Permet d'avoir des bordures blanches entre les pays
      scale_fill_gradient(low = "burlywood1", high = "saddlebrown") +
      
      labs(title = "Carte choroplète des fortunes des milliardaires par pays (échelle logarithmique)",
           fill = "Logarithme de la somme des fortunes") +
      theme_minimal() # Permet d'avoir un fond blanc pour la carte
    
  })
  
  output$boxplot <- renderPlot({
    
    ggplot(df_billionaires, aes(x=industries, y=log_finalWorth, fill=industries))+
      geom_boxplot()+
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) + #Rotation des noms des industries
      labs(title = "Boxplot des fortunes par industries (échelle logarithmique)")
    
  })

  output$dyn_piechart <- renderPlotly({
    # Permet de selectionner le piechart à afficher
    data_to_plot <- df_billionaires
    if (input$variable == "Sexe") {
      data_to_plot <- data_to_plot %>% count(gender)
      data_to_plot <- data_to_plot %>% mutate(label = ifelse(gender == "M", "homme", "femme"))
    } else {
      data_to_plot <- data_to_plot %>% count(selfMade)
      data_to_plot <- data_to_plot %>% mutate(label = ifelse(selfMade == "TRUE", "selfmade", "not selfmade"))
    }
    
    plot_ly(data = data_to_plot, labels = ~label, values = ~n, type = 'pie') %>%
    layout(title = paste("Diagramme de répartition par", input$variable)) %>%
    add_trace(marker = list(colors = c("salmon", "steelblue")))
  })
}