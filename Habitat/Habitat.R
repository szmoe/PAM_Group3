library(tibble)
library(dplyr)
library(kableExtra)

Habitat <- tibble::tibble(
  Site_ID = c("6", "7", "8", "10", "11"),
  Habitat = c("Grassland", "Near-pond", "Grassland", "Cropland", "Cropland")
)


Habitat %>%
  rename("Site ID" = Site_ID) %>%
  kable() %>%
  kable_styling("striped", position = "left", font_size = 10)
