library(dplyr)

# Création du dataframe
file_name <- "billionaires.csv"
df_billionaires <- read.csv(file_name)

# Ajout d'une colonne du logartihme des fortunes des milliardaires
df_billionaires$log_finalWorth <- log(df_billionaires$finalWorth)


# Création d'un dataframe qui trie les données par pays

  # Colonne total_worth
df_country <- df_billionaires %>%
  group_by(country) %>%
  filter(country != "") %>%
  summarize(total_worth = sum(finalWorth)) %>%
  mutate(country = ifelse(country == "United States", "USA", country))
  # Permet d'utiliser la meme notation pour le dataframe que pour la carte

  # Column log_total_worth
df_country$log_total_worth <- log(df_country$total_worth)

  # Column count
count <- table(df_billionaires$country)
count <- count[names(count) != ""]
df_country$count <- as.numeric(count)
df_country <- df_country %>% arrange(desc(count))
df_country$country <- factor(df_country$country, levels = df_country$country)

# Création d'un dataframe qui compte le nombre de selfmade
selfmade_counts <- df_billionaires %>%
  group_by(selfMade) %>%
  summarise(count = n())

selfmade_counts$percentage <- (selfmade_counts$count / sum(selfmade_counts$count)) * 100