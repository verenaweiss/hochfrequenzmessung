# Pakete laden
library(readxl)
library(writexl)
library(tidyverse)

# Excel-Dateien einlesen
tabelle1 <- read_excel("./Analyse/Messungen/170Holz_20240724_01.xls")
tabelle2 <- read_excel("./Analyse/Messungen/170Holz_20240724_02.xls")
tabelle3 <- read_excel("./Analyse/Messungen/170Holz_20240724_03.xls")



# Daten zusammenführen (tidyverse Methode)
werte <- bind_cols(
  tabelle1 %>% select(Frequency, `Generator Level/V`),
  tabelle2 %>% select(`Generator Level/V`),
  tabelle3 %>% select(`Generator Level/V`)
)

# Spaltennamen anpassen
colnames(werte) <- c("Frequency", "Tabelle1", "Tabelle2", "Tabelle3")

# Sicherstellen, dass die "Frequency" Spalte numerisch ist
werte$Frequency <- as.numeric(werte$Frequency)

# Alle "Generator Level/V" Spalten in numerische Werte umwandeln
werte$Tabelle1 <- as.numeric(werte$Tabelle1)
werte$Tabelle2 <- as.numeric(werte$Tabelle2)
werte$Tabelle3 <- as.numeric(werte$Tabelle3)

# Überprüfen der Daten nach dem Laden
head(werte)

# Fehlende Werte (NA) durch den Mittelwert der jeweiligen Spalte ersetzen
werte <- werte %>%
  mutate(
    Tabelle1 = ifelse(is.na(Tabelle1), mean(Tabelle1, na.rm = TRUE), Tabelle1),
    Tabelle2 = ifelse(is.na(Tabelle2), mean(Tabelle2, na.rm = TRUE), Tabelle2),
    Tabelle3 = ifelse(is.na(Tabelle3), mean(Tabelle3, na.rm = TRUE), Tabelle3)
  )

# Berechnung des Mittelwerts pro Zeile
werte <- werte %>%
  mutate(Mittelwert = rowMeans(select(werte, Tabelle1, Tabelle2, Tabelle3), na.rm = TRUE))

# Überprüfen, ob die Spalte "Mittelwert" erfolgreich hinzugefügt wurde
head(werte)

# Falls es NA-Werte in der Mittelwert-Spalte gibt, beheben
werte$Mittelwert <- ifelse(is.na(werte$Mittelwert), 0, werte$Mittelwert)

# Diagramm erstellen
ggplot(werte, aes(x = Frequency, y = Mittelwert)) +  # x = Frequency, y = Mittelwert
  geom_line(color = "blue") +  # Liniendiagramm
  labs(
    title = "Mittelwerte 17 cm Holz100",  # Titel des Diagramms
    x = "Frequenz (Hz)",  # x-Achse: Frequency
    y = "Mittelwert (Generator Level/V)"  # y-Achse: Mittelwert
  ) +
  theme_minimal()  # Minimalistisches Design

write_xlsx(werte, "./Analyse/170Holz/170Holz_neu.xlsx")
