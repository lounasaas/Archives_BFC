# Charger les librairies
library(leaflet)
library(sf)
library(leaflet.extras)
library(leaflet.minicharts)
library(htmltools)

# Lire le shapefile qui contient les polygones
departements <- st_read('data/shp/departements_BFC.shp')

# Charger le CSV des centres d'archives départementales (ajout ici sep = ; parce qu'il y a des virgules dans mes informations visibles dans les popup)
archives <- read.csv("data/csv/archive_center_data.csv",sep = ";", stringsAsFactors = FALSE)

# Créer une icône pour les centres d'archives
url <- "https://raw.githubusercontent.com/lounasaas/Archives_BFC/refs/heads/main/archiver.png"
archives_icon <- makeIcon(url, url, 25, 25)

# Initialiser la carte avec les dossiers du shapefile
map <- leaflet() %>% 
  # Ajouter la carte en utilisant OpenStreetMape
  addProviderTiles(providers$OpenStreetMap)  %>% 
  
  # Définir l'affichage initial de la carte 
  setView(lng = 4.73647774631472,
          lat = 47.1654067212711, 
          zoom = 7 ) %>%
  
  # Ajouter des marqueurs pour chaque centre d'archives avec les données du CSV (ajout de <img src= pour ajouter des images)
  addMarkers(data = archives,
             lng = ~long, 
             lat = ~lat,
             icon = archives_icon,
             group = "Centres d'archives",
             popup = ~paste0(
               "<b>", archive_center_name, "</b><br>",
               "<img src='", image,
               "' style='width:100%; height:auto; border-radius:4px;'><br><br>",
               "Quantité d'archives en kilomètres linéaires : ", quantity_of_archives, "<br>",
               "Notices avec objets numériques sur francearchives.gouv : ", francearchives_notices_with_digital_objects, "<br>",
               "Nombre total de notices sur francearchives.gouv : ", francearchives_notices_count, "<br>",
               "Horaires : ", schedule, "<br>",
               "<a href='", website, "' target='_blank'>Site web</a><br>"
               )) %>%
  
  # Ajouter les polygones qui représentent les départements
  addPolygons(data = departements, 
              color = "#008000", 
              weight = 1, 
              smoothFactor = 0,
              group = "Départements",
              label = ~nom
  ) %>%
  
  # Ajouter la légende de la carte et faire les titres et sous-titres
  addLegend("topright", 
            colors = c("transparent"), 
            labels = c("Louna Saas - louna.saas@gmail.com"),
            title = "Centres d'archives départementales de Bourgogne Franche-Comté") %>%
  
  # Ajouter une mini carte en bas à gauche
  addMiniMap("bottomleft") %>%
  
  # Ajouter une commande de calque permettant aux utilisateurs de basculer entre les groupes de superposition
  addLayersControl(overlayGroups = c("Départements", "Centres d'archives"),
                   options = layersControlOptions(collapsed = TRUE))

# Visualiser la carte
map

