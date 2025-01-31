# Pakete laden
library(readxl)
library(tidyverse)

# Tabellen einlesen und mit einem Label versehen
tabelle_170_holz <- read_excel("C:/Users/veren/OneDrive/Dokumente/Holztechnikum/Diplomarbeit/Analyse/170Holz/Kombiniert.xlsx") %>%
  mutate(Tabelle = "170 Holz")
tabelle_170_holz_daemmung <- read_excel("C:\\Users\\veren\\OneDrive\\Dokumente\\Holztechnikum\\Diplomarbeit\\Analyse\\170HolzDämmung\\Kombiniert.xlsx") %>%
  mutate(Tabelle = "170 Holz + Dämmung")
tabelle_250_holz <- read_excel("C:\\Users\\veren\\OneDrive\\Dokumente\\Holztechnikum\\Diplomarbeit\\Analyse\\250Holz\\Kombiniert.xlsx") %>%
  mutate(Tabelle = "250 Holz")
tabelle_250_holz_daemmung <- read_excel("C:\\Users\\veren\\OneDrive\\Dokumente\\Holztechnikum\\Diplomarbeit\\Analyse\\250HolzDämmung\\Kombiniert.xlsx") %>%
  mutate(Tabelle = "250 Holz + Dämmung")
tabelle_306_holz <- read_excel("C:\\Users\\veren\\OneDrive\\Dokumente\\Holztechnikum\\Diplomarbeit\\Analyse\\306Holz\\Kombiniert.xlsx") %>%
  mutate(Tabelle = "306 Holz")
tabelle_306_holz_daemmung <- read_excel("C:\\Users\\veren\\OneDrive\\Dokumente\\Holztechnikum\\Diplomarbeit\\Analyse\\306HolzDämmung\\Kombiniert.xlsx") %>%
  mutate(Tabelle = "306 Holz + Dämmung")

# Alle Tabellen zusammenführen
alle_tabellen <- bind_rows(
  tabelle_170_holz %>% select(Frequency, Differenz, Tabelle),
  tabelle_170_holz_daemmung %>% select(Frequency, Differenz, Tabelle),
  tabelle_250_holz %>% select(Frequency, Differenz, Tabelle),
  tabelle_250_holz_daemmung %>% select(Frequency, Differenz, Tabelle),
  tabelle_306_holz %>% select(Frequency, Differenz, Tabelle),
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

# Grafik erstellen
ggplot(alle_tabellen, aes(x = Frequency, y = Differenz, color = Tabelle)) +
  geom_line(size = 0.5) +  # Linientyp
  labs(
    title = "Dämpfung",  # Titel der Grafik
    x = "Frequency (Hz)",  # x-Achse: Frequenz
    y = "Dämpfung (dB)"  # y-Achse: Mittelwert
  ) +
  theme_minimal()  # Minimalistisches Design
