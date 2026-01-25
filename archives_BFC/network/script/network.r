# Charger les librairies
library(visNetwork)
library(tidyverse)

# Charger les edges et les nodes des fichiers CSV (encore une fois utilisation de sep = ";")
nodes <- read.csv("data/csv/nodes.csv", sep = ";", stringsAsFactors = FALSE)
edges <- read.csv("data/csv/edges.csv", sep = ";", stringsAsFactors = FALSE)

# Effacement de la colonne label après coup parce que ça rendait le graphique illisible
edges$label <- NULL

# Faire en sorte que les liens est des couleurs différentes en fonction de si il est question de contenus ou de formats d'exposition 
edges$color[edges$title == "Proximité de contenu"] <- "lightblue"
edges$color[edges$title == "Proximité de format"]  <- "red"

# Mettre en évidence les noeuds les plus proches 
visNetwork(nodes, edges, height = "500px", width = "100%") %>% 
  visOptions(highlightNearest = TRUE) %>%
  visLayout(randomSeed = 123)

# Personnaliser les options de selection et utilisation de forceAtlas2Based pour que les titres ne se chevauchent pas
visNetwork(nodes, edges, height = "500px", width = "100%") %>% 
  visOptions(highlightNearest = TRUE, 
             nodesIdSelection = list(enabled = TRUE,
                                     selected = "21_AD",
                                     values = nodes$id,
                                     style = 'width: 200px; height: 26px;
                                 background: #f8f8f8;
                                 color: darkblue;
                                 border:none;
                                 outline:none;')) %>%
  visLayout(randomSeed = 123) %>%
  visPhysics(
  solver = "forceAtlas2Based",
  forceAtlas2Based = list(gravitationalConstant = -50),
  stabilization = TRUE
)

