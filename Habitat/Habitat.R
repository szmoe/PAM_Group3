library(tibble)
library(dplyr)
library(kableExtra)

Habitat <- tibble::tibble(
  Site_ID = c("1", "2", "3", "4", "5","6", "7", "8", "9", "10", "11",
              "12", "13", "14", "15", "16", "17", "18", "19"),
  Habitat = c("", "", "", "", "","Grassland", "Cropland near pond", "Grassland", 
              "","Cropland", "Cropland", "", "", "", "", "", "", "", "")
)


Habitat %>%
  rename("Site ID" = Site_ID) %>%
  kable() %>%
  kable_styling("striped", position = "left", font_size = 10)
