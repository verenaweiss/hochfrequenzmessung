# Pakete laden
library(readxl)
library(tidyverse)

# Tabellen einlesen und mit einem Label versehen
tabelle_170_holz_daemmung <- read_excel("./Analyse/170HolzDämmung/Kombiniert.xlsx") %>%
  mutate(Tabelle = "170 Holz + Dämmung")
tabelle_250_holz_daemmung <- read_excel("./Analyse/250HolzDämmung/Kombiniert.xlsx") %>%
  mutate(Tabelle = "250 Holz + Dämmung")
tabelle_306_holz_daemmung <- read_excel("./Analyse/306HolzDämmung/Kombiniert.xlsx") %>%
  mutate(Tabelle = "306 Holz + Dämmung")

# Alle Tabellen zusammenführen
alle_tabellen <- bind_rows(
  tabelle_170_holz_daemmung %>% select(Frequency, Differenz, Tabelle),
  tabelle_250_holz_daemmung %>% select(Frequency, Differenz, Tabelle),
  tabelle_306_holz_daemmung %>% select(Frequency, Differenz, Tabelle)
)

# Umbenennen der Spalten für Konsistenz
colnames(alle_tabellen) <- c("Frequency", "Differenz", "Tabelle")

# Sicherstellen, dass die Spalten numerisch sind
alle_tabellen <- alle_tabellen %>%
  mutate(
    Frequency = as.numeric(Frequency),
    Differenz = as.numeric(Differenz)
  )

ggplot(alle_tabellen, aes(x = Frequency, y = Differenz, color = Tabelle)) +
  geom_line(size = 0.6) +  # Linientyp
  scale_color_manual(
    values = c("170 Holz + Dämmung" = "red", "250 Holz + Dämmung" = "darkgreen", "306 Holz + Dämmung" = "blue")  # Farben anpassen
  ) +
  labs(
    title = "Dämpfung Holz mit Dämmung",  # Titel der Grafik
    x = "Frequenz (MHz)",  # x-Achse: Frequenz
    y = "Dämpfung (dB)"  # y-Achse: Mittelwert
  ) +
  theme_minimal() +  # Minimalistisches Design
  theme(
    plot.title = element_text(size = 16, face = "bold", family = "Cambria"),  # Titel: Schriftgröße, Fett, Schriftart
    axis.title.x = element_text(size = 12, family = "Cambria"),  # X-Achsentitel: Schriftgröße, Schriftart
    axis.title.y = element_text(size = 12, family = "Cambria"),  # Y-Achsentitel: Schriftgröße, Schriftart
    axis.text = element_text(size = 12, family = "Cambria"),  # Achsenticks: Schriftgröße, Schriftart
    legend.title = element_text(size = 12, family = "Cambria"),  # Legendentitel: Schriftgröße, Schriftart
    legend.text = element_text(size = 12, family = "Cambria")  # Legendentext: Schriftgröße, Schriftart
  )
