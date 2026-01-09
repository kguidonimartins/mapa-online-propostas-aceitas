if (!require("tidyverse")) install.packages("tidyverse")
if (!require("here")) install.packages("here")
if (!require("fs")) install.packages("fs")
if (!require("sf")) install.packages("sf")
if (!require("readxl")) install.packages("readxl")
if (!require("janitor")) install.packages("janitor")
if (!require("glue")) install.packages("glue")
if (!require("mapview")) install.packages("mapview")
if (!require("leaflet")) install.packages("leaflet")
if (!require("htmlwidgets")) install.packages("htmlwidgets")

### Carrega os shapefiles dos 3 editais

Edital001 <-
  here("docs/propostas-aceitas/repasse-FBDS-BNES_shapefiles-propostas-aceitas-MR2/shapefile-selecionados-edital1.gpkg") %>%
  read_sf() %>%
  st_transform(4326)

Edital002 <-
  here("docs/propostas-aceitas/repasse-FBDS-BNES_shapefiles-propostas-aceitas-MR2/shapefile-selecionados-edital2.gpkg") %>%
  read_sf() %>%
  st_transform(4326)

Edital003 <-
  here("docs/propostas-aceitas/repasse-FBDS-BNES_shapefiles-propostas-aceitas-MR2/shapefile-selecionados-edital3.gpkg") %>%
  read_sf() %>%
  st_transform(4326)

### Cria mapa interativo usando mapview

# Define cores distintas para cada edital
cores_editais <- c(
  "Edital 1" = "#E74C3C",  # Vermelho
  "Edital 2" = "#3498DB",  # Azul
  "Edital 3" = "#2ECC71"   # Verde
)

# Cria o mapa com os 3 editais sobrepostos
mapa_interativo <-
  mapview(
    list(Edital001, Edital002, Edital003),
    map.types = c("CartoDB.Positron", "OpenStreetMap", "Esri.WorldImagery"),
    alpha.regions = 0.9,
    alpha = 0.9,
    col.regions = list(cores_editais["Edital 1"],
                      cores_editais["Edital 2"],
                      cores_editais["Edital 3"]),
    color = list(cores_editais["Edital 1"],
                 cores_editais["Edital 2"],
                 cores_editais["Edital 3"]),
    layer.name = list("Edital 1", "Edital 2", "Edital 3"),
    legend = TRUE,
    homebutton = TRUE
  )

# Salva o mapa como HTML
mapview::mapshot(
  mapa_interativo,
  url = here("code/mapa-online-propostas-aceitas/index.html"),
  remove_controls = NULL,
  title = "Propostas Aceitas - Editais 1, 2 e 3"
)

message("Mapa interativo salvo em: ", here("mapa-propostas-aceitas.html"))

