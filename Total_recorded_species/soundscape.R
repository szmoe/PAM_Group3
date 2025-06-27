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
merged_unique_moe1 <- merged_unique_moe1[c("Scientific.name", "Common.name", "Confidence" ,"Audio_ID",
                                 "Site_ID")]

merged_unique_moe2$Audio_ID <- "A025"
merged_unique_moe2$Site_ID <- "10"
merged_unique_moe2 <- merged_unique_moe2[c("Scientific.name", "Common.name", "Confidence", "Audio_ID",
                                 "Site_ID")]

# Save to new CSV
write.csv(merged_unique_moe1, "./Species_per_site/xa23_merged.csv", row.names = FALSE)
write.csv(merged_unique_moe2, "./Species_per_site/A025_merged.csv", row.names = FALSE)

# Read the two CSV files
dfm1 <- read.csv("./Species_per_site/A025_merged.csv")
dfm2 <- read.csv("./Species_per_site/xa23_merged.csv")

# Merge by stacking rows (row-wise)
merged_moe <- rbind(dfm1, dfm2)

# Save to new CSV
write.csv(merged_moe, "./Species_per_group_member/A025_xA23_species_list_Moe.csv",
          row.names = FALSE)

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
merged_unique_robin1 <- merged_unique_robin1[c("Scientific.name", "Common.name", "Confidence","Audio_ID",
                                 "Site_ID")]

merged_unique_robin2$Audio_ID <- "A027"
merged_unique_robin2$Site_ID <- "6"
merged_unique_robin2 <- merged_unique_robin2[c("Scientific.name", "Common.name", "Confidence","Audio_ID",
                                 "Site_ID")]

# Save to new CSV
write.csv(merged_unique_robin1, "./Species_per_site/A024_merged.csv", row.names = FALSE)
write.csv(merged_unique_robin2, "./Species_per_site/A027_merged.csv", row.names = FALSE)

# Read the two CSV files
dfr1 <- read.csv("./Species_per_site/A024_merged.csv")
dfr2 <- read.csv("./Species_per_site/A027_merged.csv")

# Merge by stacking rows (row-wise)
merged_robin <- rbind(dfr2, dfr1)

# Save to new CSV
write.csv(merged_robin, "./Species_per_group_member/A024_A027_species_list_Robin.csv", 
          row.names = FALSE)

##--------------------------------------------------------------------------##

# Clean Malte's data

merged_unique_malte <- read.csv("./BIRDNET_data/A030_Malte.csv")

# Add new column 'Site_ID' 
merged_unique_malte$Audio_ID <- "A030"
merged_unique_malte$Site_ID <- "8"
merged_unique_malte <- merged_unique_malte[c("Scientific.name", "Common.name", "Confidence","Audio_ID",
                                 "Site_ID")]

# Remove duplicates based on 'Common.name' column
merged_unique_malte <- merged_unique_malte[!duplicated(merged_unique_malte$Common.name), ]

# Save to new CSV
write.csv(merged_unique_malte, "./Species_per_group_member/A030_species_list_Malte.csv", 
          row.names = FALSE)

##--------------------------------------------------------------------------##

# Merge all data for Group 3

# Read CSV files
df1 <- read.csv("./Species_per_group_member/A024_A027_species_list_Robin.csv")
df2 <- read.csv("./Species_per_group_member/A030_species_list_Malte.csv")
df3 <- read.csv("./Species_per_group_member/A025_xA23_species_list_Moe.csv")

# Merge by stacking rows (row-wise)
merged <- rbind(df1, df2, df3)

# Save to new CSV
write.csv(merged, "./Total_recorded_species/Species_list_Group3.csv", row.names = FALSE)

##-------------------------------------------------------------------------##
# Clean the rest of the data
# List all CSV files in a folder
file_A021 <- list.files(path = "./BIRDNET_data/A021_Felix", pattern = "*.csv", full.names = TRUE)
file_A022 <- list.files(path = "./BIRDNET_data/A022_Felix", pattern = "*.csv", full.names = TRUE)
file_A023 <- list.files(path = "./BIRDNET_data/A023", pattern = "*.csv", full.names = TRUE)
file_A026 <- list.files(path = "./BIRDNET_data/A026_Felix", pattern = "*.csv", full.names = TRUE)
#file_A028 <- list.files(path = "./BIRDNET_data/A028", pattern = "*.csv", full.names = TRUE)
file_A029 <- list.files(path = "./BIRDNET_data/A029_Maike", pattern = "*.csv", full.names = TRUE)
#file_A031 <- list.files(path = "./BIRDNET_data/A031", pattern = "*.csv", full.names = TRUE)
file_A032 <- list.files(path = "./BIRDNET_data/A032_Felix", pattern = "*.csv", full.names = TRUE)
file_A033 <- list.files(path = "./BIRDNET_data/A033", pattern = "*.csv", full.names = TRUE)
file_A034 <- list.files(path = "./BIRDNET_data/A034", pattern = "*.csv", full.names = TRUE)
file_A035 <- list.files(path = "./BIRDNET_data/A035_Felix", pattern = "*.csv", full.names = TRUE)
file_A036 <- list.files(path = "./BIRDNET_data/A036_Felix", pattern = "*.csv", full.names = TRUE)
file_A037 <- list.files(path = "./BIRDNET_data/A037_Maike", pattern = "*.csv", full.names = TRUE)

# Read all CSVs into a list of data frames
dfs_A021 <- lapply(file_A021, read.csv)
dfs_A022 <- lapply(file_A022, read.csv)
dfs_A023 <- lapply(file_A023, read.csv)
dfs_A026 <- lapply(file_A026, read.csv)
#dfs_A028 <- lapply(file_A028, read.csv)
dfs_A029 <- lapply(file_A029, read.csv)
#dfs_A031 <- lapply(file_A031, read.csv)
dfs_A032 <- lapply(file_A032, read.csv)
dfs_A033 <- lapply(file_A033, read.csv)
dfs_A034 <- lapply(file_A034, read.csv)
dfs_A035 <- lapply(file_A035, read.csv)
dfs_A036 <- lapply(file_A036, read.csv)
dfs_A037 <- lapply(file_A037, read.csv)

# Combine all data frames into one
merged_A021 <- do.call(rbind, dfs_A021)
merged_A022 <- do.call(rbind, dfs_A022)
merged_A023 <- do.call(rbind, dfs_A023)
merged_A026 <- do.call(rbind, dfs_A026)
merged_A029 <- do.call(rbind, dfs_A029)
merged_A032 <- do.call(rbind, dfs_A032)
merged_A033 <- do.call(rbind, dfs_A033)
merged_A034 <- do.call(rbind, dfs_A034)
merged_A035 <- do.call(rbind, dfs_A035)
merged_A036 <- do.call(rbind, dfs_A036)
merged_A037 <- do.call(rbind, dfs_A037)

# Remove duplicates based on 'Common.name' column
merged_unique_A021 <- merged_A021[!duplicated(merged_A021$Common.name), ]
merged_unique_A022 <- merged_A022[!duplicated(merged_A022$Common.name), ]
merged_unique_A023 <- merged_A023[!duplicated(merged_A023$Common.name), ]
merged_unique_A026 <- merged_A026[!duplicated(merged_A026$Common.name), ]
merged_unique_A029 <- merged_A029[!duplicated(merged_A029$Common.name), ]
merged_unique_A032 <- merged_A032[!duplicated(merged_A032$Common.name), ]
merged_unique_A033 <- merged_A033[!duplicated(merged_A033$Common.name), ]
merged_unique_A034 <- merged_A034[!duplicated(merged_A034$Common.name), ]
merged_unique_A035 <- merged_A035[!duplicated(merged_A035$Common.name), ]
merged_unique_A036 <- merged_A036[!duplicated(merged_A036$Common.name), ]
merged_unique_A037 <- merged_A037[!duplicated(merged_A037$Common.name), ]

# Add new column 'Site_ID' 
merged_unique_A021$Audio_ID <- "A021"
merged_unique_A021$Site_ID <- "1"
merged_unique_A021 <- merged_unique_A021[c("Scientific.name", "Common.name", "Confidence" ,"Audio_ID",
                                           "Site_ID")]

merged_unique_A022$Audio_ID <- "A022"
merged_unique_A022$Site_ID <- "15"
merged_unique_A022 <- merged_unique_A022[c("Scientific.name", "Common.name", "Confidence", "Audio_ID",
                                           "Site_ID")]

merged_unique_A023$Audio_ID <- "A023"
merged_unique_A023$Site_ID <- "16"
merged_unique_A023 <- merged_unique_A023[c("Scientific.name", "Common.name", "Confidence", "Audio_ID",
                                           "Site_ID")]

merged_unique_A026$Audio_ID <- "A026"
merged_unique_A026$Site_ID <- "19"
merged_unique_A026 <- merged_unique_A026[c("Scientific.name", "Common.name", "Confidence", "Audio_ID",
                                           "Site_ID")]

merged_unique_A029$Audio_ID <- "A029"
merged_unique_A029$Site_ID <- "17"
merged_unique_A029 <- merged_unique_A029[c("Scientific.name", "Common.name", "Confidence", "Audio_ID",
                                           "Site_ID")]

merged_unique_A032$Audio_ID <- "A032"
merged_unique_A032$Site_ID <- "18"
merged_unique_A032 <- merged_unique_A032[c("Scientific.name", "Common.name", "Confidence", "Audio_ID",
                                           "Site_ID")]

merged_unique_A033$Audio_ID <- "A033"
merged_unique_A033$Site_ID <- "13"
merged_unique_A033 <- merged_unique_A033[c("Scientific.name", "Common.name", "Confidence", "Audio_ID",
                                           "Site_ID")]

merged_unique_A034$Audio_ID <- "A034"
merged_unique_A034$Site_ID <- "12"
merged_unique_A034 <- merged_unique_A034[c("Scientific.name", "Common.name", "Confidence", "Audio_ID",
                                           "Site_ID")]

merged_unique_A035$Audio_ID <- "A035"
merged_unique_A035$Site_ID <- "2"
merged_unique_A035 <- merged_unique_A035[c("Scientific.name", "Common.name", "Confidence", "Audio_ID",
                                           "Site_ID")]

merged_unique_A036$Audio_ID <- "A036"
merged_unique_A036$Site_ID <- "3"
merged_unique_A036 <- merged_unique_A036[c("Scientific.name", "Common.name", "Confidence", "Audio_ID",
                                           "Site_ID")]

merged_unique_A037$Audio_ID <- "A037"
merged_unique_A037$Site_ID <- "14"
merged_unique_A037 <- merged_unique_A037[c("Scientific.name", "Common.name", "Confidence", "Audio_ID",
                                           "Site_ID")]

# Save to new CSV
write.csv(merged_unique_A021, "./Species_per_site/A021_merged.csv", row.names = FALSE)
write.csv(merged_unique_A022, "./Species_per_site/A022_merged.csv", row.names = FALSE)
write.csv(merged_unique_A023, "./Species_per_site/A023_merged.csv", row.names = FALSE)
write.csv(merged_unique_A026, "./Species_per_site/A026_merged.csv", row.names = FALSE)
write.csv(merged_unique_A029, "./Species_per_site/A029_merged.csv", row.names = FALSE)
write.csv(merged_unique_A032, "./Species_per_site/A032_merged.csv", row.names = FALSE)
write.csv(merged_unique_A033, "./Species_per_site/A033_merged.csv", row.names = FALSE)
write.csv(merged_unique_A034, "./Species_per_site/A034_merged.csv", row.names = FALSE)
write.csv(merged_unique_A035, "./Species_per_site/A035_merged.csv", row.names = FALSE)
write.csv(merged_unique_A036, "./Species_per_site/A036_merged.csv", row.names = FALSE)
write.csv(merged_unique_A037, "./Species_per_site/A037_merged.csv", row.names = FALSE)

# Read the two CSV files
dfA021 <- read.csv("./Species_per_site/A021_merged.csv")
dfA022 <- read.csv("./Species_per_site/A022_merged.csv")
dfA023 <- read.csv("./Species_per_site/A023_merged.csv")
dfA026 <- read.csv("./Species_per_site/A026_merged.csv")
dfA029 <- read.csv("./Species_per_site/A029_merged.csv")
dfA032 <- read.csv("./Species_per_site/A032_merged.csv")
dfA033 <- read.csv("./Species_per_site/A033_merged.csv")
dfA034 <- read.csv("./Species_per_site/A034_merged.csv")
dfA035 <- read.csv("./Species_per_site/A035_merged.csv")
dfA036 <- read.csv("./Species_per_site/A036_merged.csv")
dfA037 <- read.csv("./Species_per_site/A037_merged.csv")

# Merge by stacking rows (row-wise)
merged_other <- rbind(dfA021, dfA022, dfA023, dfA026, dfA029, dfA032, dfA033,
                      dfA034, dfA035, dfA036, dfA037)

# Save to new CSV
write.csv(merged_other, "./Species_per_group_member/A021_22_23_26_29_32_33_34_35_36_37_species_list_other.csv",
          row.names = FALSE)

# Merge with group 3 data
dfother <- read.csv("./Species_per_group_member/A021_22_23_26_29_32_33_34_35_36_37_species_list_other.csv")
dfgroup3 <- read.csv("./Total_recorded_species/Species_list_Group3.csv")
merged_other_group3 <- rbind(dfother, dfgroup3)

write.csv(merged_other_group3, "./Total_recorded_species/Species_list_other.csv",
          row.names = FALSE)

##-------------------------------------------------------------------------##

# # Extract total recorded species
# 
# # Load data.table package
# library(data.table)
# 
# # Read the CSV file
# dt <- fread("./Total_recorded_species/Species_list_Group3.csv")
# 
# # Clean and merge by Scientific.name
# cleaned <- dt[, .(
#   Common.name = first(Common.name),
#   Confidence = paste(round(unique(Confidence), 2), collapse = ",   "),
#   Audio_IDs = paste(unique(Audio_ID), collapse = ",   "),
#   Site_IDs = paste(unique(Site_ID), collapse = ",   ")
# ), by = Scientific.name]
# 
# # View result
# print(cleaned)
# 
# # Write to CSV
# fwrite(cleaned, "./Total_recorded_species/Total_recorded_species_Group3.csv")

# Extract total recorded species

# Load data.table package
library(data.table)

# Read CSV
dt <- fread("./Total_recorded_species/Species_list_other.csv")

# Process and merge by Scientific.name, keeping the correct links
cleaned <- dt[, {
  temp <- .SD[order(Confidence)]  # sort within group by Confidence
  list(
    Common.name = first(Common.name),
    Confidence = paste(round(temp$Confidence, 2), collapse = ",   "),
    Audio_IDs = paste(temp$Audio_ID, collapse = ",   "),
    Site_IDs = paste(temp$Site_ID, collapse = ",   ")
  )
}, by = Scientific.name]

print(cleaned)

# Write cleaned file
fwrite(cleaned, "./Total_recorded_species/Total_recorded_species_other_sorted.csv")

#----------------------------------------------------------------------------------#

# Check the total number of species
df <- read.csv("./Total_recorded_species/Total_recorded_species_other_sorted.csv")
nrow(df)

# Display species variations

library(tidyverse)
library(chillR)

# Read CSV file
species_data <- read_csv("./Total_recorded_species/Species_list_other.csv")

# Create presence/absence matrix
species_matrix <- species_data %>%
  distinct(Common.name, Site_ID) %>%
  mutate(present = 1) %>%
  pivot_wider(names_from = Site_ID, values_from = present, values_fill = 0)

# Convert to long format for ggplot
species_long <- species_matrix %>%
  pivot_longer(-Common.name, names_to = "Site_ID", values_to = "Presence")

levels(species_long$Site_ID)


library(ggplot2)
# library(forcats)

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

