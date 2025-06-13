# Clean Moe's data
# List all CSV files in a folder
files <- list.files(path = "XA23_Moe", pattern = "*.csv", full.names = TRUE)
files <- list.files(path = "A025_Moe", pattern = "*.csv", full.names = TRUE)

# Read all CSVs into a list of data frames
dfs <- lapply(files, read.csv)

# Combine all data frames into one
merged <- do.call(rbind, dfs)

# Remove duplicate rows
merged_unique <- unique(merged)

# Remove duplicates based on 'Common.name' column
merged_unique <- merged[!duplicated(merged$Common.name), ]

# Add new column 'Site_ID' 
merged_unique$Audio_ID <- "xa23"
merged_unique$Site_ID <- "11"
merged_unique <- merged_unique[c("Scientific.name", "Common.name", "Audio_ID",
                                 "Site_ID")]
merged_unique$Audio_ID <- "A025"
merged_unique$Site_ID <- "10"
merged_unique <- merged_unique[c("Scientific.name", "Common.name", "Audio_ID",
                                 "Site_ID")]

# Save to new CSV
write.csv(merged_unique, "xa23_merged.csv", row.names = FALSE)
write.csv(merged_unique, "A025_merged.csv", row.names = FALSE)

# Read the two CSV files
df1 <- read.csv("A025_merged.csv")
df2 <- read.csv("xa23_merged.csv")

# Merge by stacking rows (row-wise)
merged <- rbind(df1, df2)

# Save to new CSV
write.csv(merged, "A025_xA23_species_list_Moe.csv", row.names = FALSE)

##-------------------------------------------------------------------------##

# Clean Robin's data
# List all CSV files in a folder
files <- list.files(path = "A024_Robin", pattern = "*.csv", full.names = TRUE)
files <- list.files(path = "A027_Robin", pattern = "*.csv", full.names = TRUE)

# Read all CSVs into a list of data frames
dfs <- lapply(files, read.csv)

# Combine all data frames into one
merged <- do.call(rbind, dfs)

# Remove duplicate rows
merged_unique <- unique(merged)

# Remove duplicates based on 'Common.name' column
merged_unique <- merged[!duplicated(merged$Common.name), ]

# Add new column 'Site_ID' 
merged_unique$Audio_ID <- "A024"
merged_unique$Site_ID <- "7"
merged_unique <- merged_unique[c("Scientific.name", "Common.name", "Audio_ID",
                                 "Site_ID")]
merged_unique$Audio_ID <- "A027"
merged_unique$Site_ID <- "6"
merged_unique <- merged_unique[c("Scientific.name", "Common.name", "Audio_ID",
                                 "Site_ID")]

# Save to new CSV
write.csv(merged_unique, "A024_merged.csv", row.names = FALSE)
write.csv(merged_unique, "A027_merged.csv", row.names = FALSE)

# Read the two CSV files
df1 <- read.csv("A024_merged.csv")
df2 <- read.csv("A027_merged.csv")

# Merge by stacking rows (row-wise)
merged <- rbind(df2, df1)

# Save to new CSV
write.csv(merged, "A024_A027_species_list_Robin.csv", row.names = FALSE)

##--------------------------------------------------------------------------##

# Clean Malte's data

merged_unique <- read_csv("A030_Malte.csv")

# Add new column 'Site_ID' 
merged_unique$Audio_ID <- "A030"
merged_unique$Site_ID <- "8"
merged_unique <- merged_unique[c("Scientific.name", "Common.name", "Audio_ID",
                                 "Site_ID")]

# Save to new CSV
write.csv(merged, "A030_species_list_Malte.csv", row.names = FALSE)

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






