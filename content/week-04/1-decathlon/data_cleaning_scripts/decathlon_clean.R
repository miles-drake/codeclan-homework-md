# Libraries
library(tidyverse)
library(janitor)

# Read in the raw data, and create a copy for verification
decathlon <- read_rds("raw_data/decathlon.rds")
decathlon_original <- decathlon

# Fix sport names, currently held in columns, for later use
# Since this table will later be converted to "long" format, we do not want these column names to be cleaned
# We instead prefer them to be human-readable in R Studio
# This is, ultimately, a style choice, and is easily reverted if the goal is to have a human-readable CSV file
names(decathlon)[1:10] <- c(
  "Sprint, 100m",
  "Long Jump",
  "Shot Put",
  "High Jump",
  "Sprint, 400m",
  "Hurdle, 100m",
  "Discus",
  "Pole Vault",
  "Javelin",
  "Sprint, 1500m"
)

# Data cleaning
decathlon <- decathlon %>% 
  
  # Convert row names to new column (stored in column 1)
  rownames_to_column("name") %>% 
  
  # Convert to "long" tibble format, where the event is a new variable, with value score/time
  pivot_longer(
    2:11,
    names_to = "event_name",
    values_to = "event_score"
  ) %>% 
  
  # Convert remaining column names to snake case
  clean_names() %>% 
  
  # Aesthetic changes
  mutate(
    name = str_to_title(name), # Force title case for athlete names for consistency
    name = str_replace_all(name, "Mcmullen", "McMullen"), # Special case for athlete McMullen
    competition = str_replace_all(competition, "OlympicG", "Olympics") # Rename "OlympicG" to "Olympics"
  )

# Write clean data to CSV
write_csv(decathlon, "clean_data/decathlon_clean.csv")
