# Pakete laden
library(readxl)
library(tidyverse)

# Tabellen einlesen und mit einem Label versehen
tabelle_170_holz <- read_excel("./Analyse/170Holz/170Holz_neu.xlsx") %>%
  mutate(Tabelle = "170 Holz")
tabelle_170_holz_daemmung <- read_excel("./Analyse/170HolzDämmung/170HolzDämmung_neu.xlsx") %>%
  mutate(Tabelle = "170 Holz + Dämmung")
tabelle_250_holz <- read_excel("./Analyse/250Holz/250Holz_neu.xlsx") %>%
  mutate(Tabelle = "250 Holz")
tabelle_250_holz_daemmung <- read_excel("./Analyse/250HolzDämmung/250HolzDämmung_neu.xlsx") %>%
  mutate(Tabelle = "250 Holz + Dämmung")
tabelle_306_holz <- read_excel("./Analyse/306Holz/306Holz_neu.xlsx") %>%
  mutate(Tabelle = "306 Holz")
tabelle_306_holz_daemmung <- read_excel("./Analyse/306HolzDämmung/306HolzDämmung_neu.xlsx") %>%
  mutate(Tabelle = "306 Holz + Dämmung")

# Alle Tabellen zusammenführen
alle_tabellen <- bind_rows(
  tabelle_170_holz %>% select(Frequency, Mittelwert, Tabelle),
  tabelle_170_holz_daemmung %>% select(Frequency, Mittelwert, Tabelle),
  tabelle_250_holz %>% select(Frequency, Mittelwert, Tabelle),
  tabelle_250_holz_daemmung %>% select(Frequency, Mittelwert, Tabelle),
  tabelle_306_holz %>% select(Frequency, Mittelwert, Tabelle),
  tabelle_306_holz_daemmung %>% select(Frequency, Mittelwert, Tabelle)
)

# Umbenennen der Spalten für Konsistenz
colnames(alle_tabellen) <- c("Frequency", "Mittelwert", "Tabelle")

# Sicherstellen, dass die Spalten numerisch sind
alle_tabellen <- alle_tabellen %>%
  mutate(
    Frequency = as.numeric(Frequency),
    Mittelwert = as.numeric(Mittelwert)
  )

# Grafik erstellen
ggplot(alle_tabellen, aes(x = Frequency, y = Mittelwert, color = Tabelle)) +
  geom_line(size = 0.5) +  # Linientyp
  labs(
    title = "Verlauf des Mittelwerts",  # Titel der Grafik
    x = "Frequency (Hz)",  # x-Achse: Frequenz
    y = "Mittelwert (Generator Level/V)"  # y-Achse: Mittelwert
  ) +
  theme_minimal()  # Minimalistisches Design
