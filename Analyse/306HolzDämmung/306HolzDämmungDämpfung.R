# Pakete laden
library(readxl)
library(dplyr)
library(writexl)
library(openxlsx)

tabelle1 <- read.xlsx("./Analyse/306HolzDämmung/306HolzDämmung_neu.xlsx")
tabelle2 <- read_excel("./Analyse/Freifeld/Freifeld_neu.xlsx") 
colnames(tabelle1)
colnames(tabelle2)

kombinierte_tabelle <- inner_join(
  tabelle1 %>% select(Frequency, Mittelwert),
  tabelle2 %>% select(Frequency, Mittelwert),
  by = "Frequency",
  suffix = c("_1", "_2")
)

kombinierte_tabelle <- kombinierte_tabelle %>%
  mutate(Differenz = Mittelwert_1 - Mittelwert_2)

# Ergebnisse anzeigen
head(kombinierte_tabelle)


# Optional: Ergebnisse exportieren
write_xlsx(kombinierte_tabelle, "./Analyse/306HolzDämmung/Kombiniert.xlsx")


library(ggplot2)

# 3. Excel-Datei einlesen
daten <- read_excel("./Analyse/306HolzDämmung/Kombiniert.xlsx")

# 4. Überprüfen, ob die Tabelle korrekt geladen wurde
head(daten)  

# 5. Sicherstellen, dass die Spalten numerisch sind
daten$Frequency <- as.numeric(daten$Frequency)
daten$`Differenz` <- as.numeric(daten$`Differenz`)

# 6. Grafik erstellen
grafik <- ggplot(daten, aes(x = Frequency, y = `Differenz`)) + 
  geom_line(color = "blue", size = 0.5) +  # Linie für den Verlauf
  labs(
    title = "Dämpfung 30,6 cm Holz mit Dämmung",  # Titel der Grafik
    x = "Frequenz (Hz)",               # Beschriftung der x-Achse
    y = "Dämpfung (dB)"                # Beschriftung der y-Achse
  ) +
  theme_minimal()  # Einfaches und übersichtliches Design

# 7. Grafik anzeigen
print(grafik)
