# Charger la librairie pour visualiser les données
library(ggplot2)

# Ajout pour lire les chiffres au dessus de 100 000 (sans que ça affiche 1e+05)
options(scipen = 999)

# Lire les données des centres d'archives à partir du fichier CSV
table <- read.csv2("data/archive_centers_data.csv")

# Fond/grille du graphique
ggplot(data = table, aes(x = quantity_of_archives, y = archive_center))

# Placement des points indiquant les kilomètres linéaires d'archives par AD sur le graphique 
ggplot(data = table, aes(x = quantity_of_archives, y = archive_center)) + geom_point()

# Customisation du graphique (avec notamment scale_size pour la taille des points et scale_x_continuous pour préciser l'axe des kilomètres linéaires)
ggplot(data = table, aes(x = quantity_of_archives, 
                         y = archive_center,
                         colour = francearchives_notices_count,
                         size = francearchives_notices_with_digital_objects))  +
  geom_point() + 
  scale_size(range = c(5, 14)) +
  scale_x_continuous(breaks = seq(0, 30, by = 2)) +
  labs(x = "Quantité d'archives en kilomètres linéaires", y = "Centres d'archives départementaux", 
       colour = "Nombre total de notices sur francearchives.gouv",
       size = "Nombre total de notices contenant des archives numérisées sur francearchives.gouv",
       title = "Volume physique et visibilité numérique des archives départementales",
       subtitle = "Bourgogne Franche-comté",
       caption = "Données de francearchives.gouv") +
  theme_bw()

