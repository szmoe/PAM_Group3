# Clean Moe's data
# List all CSV files in a folder
file_moe1 <- list.files(path = "./BIRDNET_data/XA23_Moe", pattern = "*.csv", full.names = TRUE)
file_moe2 <- list.files(path = "./BIRDNET_data/A025_Moe", pattern = "*.csv", full.names = TRUE)

# Read all CSVs into a list of data frames
dfs_moe1 <- lapply(file_moe1, read.csv)
dfs_moe2 <- lapply(file_moe2, read.csv)

# Combine all data frames into one
merged_moe1 <- do.call(rbind, dfs_moe1)
merged_moe2 <- do.call(rbind, dfs_moe2)

# Remove duplicates based on 'Common.name' column
merged_unique_moe1 <- merged_moe1[!duplicated(merged_moe1$Common.name), ]
merged_unique_moe2 <- merged_moe2[!duplicated(merged_moe2$Common.name), ]

# Add new column 'Site_ID' 
merged_unique_moe1$Audio_ID <- "xa23"
merged_unique_moe1$Site_ID <- "11"
merged_unique_moe1 <- merged_unique_moe1[c("Scientific.name", "Common.name", "Audio_ID",
                                 "Site_ID")]

merged_unique_moe2$Audio_ID <- "A025"
merged_unique_moe2$Site_ID <- "10"
merged_unique_moe2 <- merged_unique_moe2[c("Scientific.name", "Common.name", "Audio_ID",
                                 "Site_ID")]

# Save to new CSV
write.csv(merged_unique_moe1, "xa23_merged.csv", row.names = FALSE)
write.csv(merged_unique_moe2, "A025_merged.csv", row.names = FALSE)

# Read the two CSV files
dfm1 <- read.csv("A025_merged.csv")
dfm2 <- read.csv("xa23_merged.csv")

# Merge by stacking rows (row-wise)
merged_moe <- rbind(dfm1, dfm2)

# Save to new CSV
write.csv(merged_moe, "A025_xA23_species_list_Moe.csv", row.names = FALSE)

##-------------------------------------------------------------------------##

# Clean Robin's data
# List all CSV files in a folder
file_robin1 <- list.files(path = "./BIRDNET_data/A024_Robin", pattern = "*.csv", full.names = TRUE)
file_robin2 <- list.files(path = "./BIRDNET_data/A027_Robin", pattern = "*.csv", full.names = TRUE)

# Read all CSVs into a list of data frames
dfs_robin1 <- lapply(file_robin1, read.csv)
dfs_robin2 <- lapply(file_robin2, read.csv)

# Combine all data frames into one
merged_robin1 <- do.call(rbind, dfs_robin1)
merged_robin2 <- do.call(rbind, dfs_robin2)

# Remove duplicates based on 'Common.name' column
merged_unique_robin1 <- merged_robin1[!duplicated(merged_robin1$Common.name), ]
merged_unique_robin2 <- merged_robin2[!duplicated(merged_robin2$Common.name), ]

# Add new column 'Site_ID' 
merged_unique_robin1$Audio_ID <- "A024"
merged_unique_robin1$Site_ID <- "7"
merged_unique_robin1 <- merged_unique_robin1[c("Scientific.name", "Common.name", "Audio_ID",
                                 "Site_ID")]

merged_unique_robin2$Audio_ID <- "A027"
merged_unique_robin2$Site_ID <- "6"
merged_unique_robin2 <- merged_unique_robin2[c("Scientific.name", "Common.name", "Audio_ID",
                                 "Site_ID")]

# Save to new CSV
write.csv(merged_unique_robin1, "A024_merged.csv", row.names = FALSE)
write.csv(merged_unique_robin2, "A027_merged.csv", row.names = FALSE)

# Read the two CSV files
dfr1 <- read.csv("A024_merged.csv")
dfr2 <- read.csv("A027_merged.csv")

# Merge by stacking rows (row-wise)
merged_robin <- rbind(dfr2, dfr1)

# Save to new CSV
write.csv(merged_robin, "A024_A027_species_list_Robin.csv", row.names = FALSE)

##--------------------------------------------------------------------------##

# Clean Malte's data

merged_unique_malte <- read_csv("./BIRDNET_data/A030_Malte.csv")

# Add new column 'Site_ID' 
merged_unique_malte$Audio_ID <- "A030"
merged_unique_malte$Site_ID <- "8"
merged_unique_malte <- merged_unique_malte[c("Scientific.name", "Common.name", "Audio_ID",
                                 "Site_ID")]

# Remove duplicates based on 'Common.name' column
merged_unique_malte <- merged_unique_malte[!duplicated(merged_unique_malte$Common.name), ]

# Save to new CSV
write.csv(merged_unique_malte, "A030_species_list_Malte.csv", row.names = FALSE)

##--------------------------------------------------------------------------##

# Merge all data for Group 3

# Read CSV files
df1 <- read.csv("A024_A027_species_list_Robin.csv")
df2 <- read.csv("A030_species_list_Malte.csv")
df3 <- read.csv("A025_xA23_species_list_Moe.csv")

# Merge by stacking rows (row-wise)
merged <- rbind(df1, df2, df3)

# Save to new CSV
write.csv(merged, "Species_list_Group3.csv", row.names = FALSE)

##-------------------------------------------------------------------------##

# Extract total recorded species

# Load data.table package
library(data.table)

# Read the CSV file
dt <- fread("Species_list_Group3.csv")

# Clean and merge by Scientific.name
cleaned <- dt[, .(
  Common.name = first(Common.name),
  Audio_IDs = paste(unique(Audio_ID), collapse = " "),
  Site_IDs = paste(unique(Site_ID), collapse = " ")
), by = Scientific.name]

# View result
print(cleaned)

# Write to CSV
fwrite(cleaned, "Total_recorded_species_Group3.csv")

# Check the total number of species
df <- read.csv("Total_recorded_species_Group3.csv")
nrow(df)

# Display species variations

library(tidyverse)
library(chillR)

# Read CSV file
species_data <- read_csv("./Total_recorded_species/Species_list_Group3.csv")

# Create presence/absence matrix
# species_matrix <- species_data %>%
#   distinct(Common.name, Site_ID) %>%
#   mutate(present = 1) %>%
#   pivot_wider(names_from = Site_ID, values_from = present, values_fill = 0)

# Convert to long format for ggplot
species_long <- species_matrix %>%
  pivot_longer(-Common.name, names_to = "Site_ID", values_to = "Presence")

levels(species_long$Site_ID)


library(ggplot2)
library(forcats)

# Change the character to numeric and display Site_ID in chronological order
species_long$Site_ID <- factor(as.numeric(as.character(species_long$Site_ID)),
                               levels = sort(unique(as.numeric(as.character(species_long$Site_ID)))))
levels(species_long$Site_ID)

# Plot heatmap
p_species <- ggplot(species_long, aes(x = fct_reorder(Common.name, Presence, .fun = sum),
                                      y = Site_ID,
                                      fill = as.factor(Presence))) +
  geom_tile(color = "white") +
  scale_fill_manual(values = c("0" = "#FFD700", "1" = "#FF8C00"), name = "Presence",
                    labels = c("0" = "FALSE", "1" = "TRUE")) +
  labs(
    title = "Species Presence Across Sites",
    x = "Species (Common Name)",
    y = "Site ID"
  ) +
  scale_y_discrete(limits = rev(levels(species_long$Site_ID))) + # reverses y-axis order
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 75, hjust = 1, vjust = 1, size = 7),
    axis.text.y = element_text(size = 9),
    plot.title = element_text(hjust = 0.5),
    legend.position = "right"
  )


p_species
  
# Change orientation
p_species <- ggplot(species_long, aes(x = Site_ID,
                                      y = fct_reorder(Common.name, Presence, .fun = sum),
                                      fill = as.factor(Presence))) +
  geom_tile(color = "white") +
  scale_fill_manual(values = c("0" = "#FFD700", "1" = "#FF8C00"), name = "Presence",
                    labels = c("0" = "FALSE", "1" = "TRUE")) +
  labs(
    title = "Species Presence Across Sites",
    y = "Species (Common Name)",
    x = "Site ID"
  ) +
 # scale_y_discrete(limits = rev(levels(species_long$Site_ID))) + 
  theme_minimal() 
  # theme(
  #   axis.text.x = element_text(angle = 75, hjust = 1, vjust = 1, size = 7),
  #   axis.text.y = element_text(size = 9),
  #   plot.title = element_text(hjust = 0.5),
  #   legend.position = "right"
  # )


p_species

