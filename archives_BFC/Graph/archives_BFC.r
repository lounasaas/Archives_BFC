# Load the required libraries for data visualization
library(ggplot2)

#Pour lire les chiffres au dessus de 100 000 (sans faire 1e+05)
options(scipen = 999)

# Read the archive centers dataset from a CSV file
table <- read.csv2("data/archive_centers_data.csv")

# Background scatter plot
ggplot(data = table, aes(x = quantity_of_archives, y = archive_center))

# Scatter plot of archive centers and their quantity of archives
ggplot(data = table, aes(x = quantity_of_archives, y = archive_center)) + geom_point()

# Customized scatter plot with additional aesthetics (scale_size pour la taille des points) (scale_x_continuous pour ajouter plus de chiffres sur l'axe du bas de 2 en 2)
ggplot(data = table, aes(x = quantity_of_archives, 
                         y = archive_center,
                         colour = francearchives_notices_count,
                         size = francearchives_notices_with_digital_objects))  +
  geom_point() + 
  scale_size(range = c(5, 14)) +
  scale_x_continuous(breaks = seq(0, 30, by = 2)) +
  labs(x = "Quantité d'archives en kilomètres linéaires", y = "Centres d'archives départementaux", 
       colour = "Nombre total de notices sur francearchives.gouv",
       size = "Nombre total de notices d'archives numérisées sur francearchives.gouv",
       title = "Volume physique et visibilité numérique des archives départementales",
       subtitle = "Bourgogne Franche-comté",
       caption = "Données de francearchives.gouv") +
  theme_bw()

