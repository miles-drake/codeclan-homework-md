# d20srd D&D v.3.5e Monster Data
# Data Cleaning Script
# Miles Drake
# 2020-03-29

# Libraries
library(dplyr)
library(janitor)
library(readxl)
library(stringr)
library(tidyr)

# Import Excel file and create a copy of the original data for verification
monsters <- read_xlsx("data/raw-data.xlsx")
monsters_raw <- monsters

# Data cleaning
# Clean column names
monsters <- clean_names(monsters)
colnames(monsters)[1] <- "summary"
# Convert summary column to lowercase for consistency
monsters <- monsters %>% 
  mutate(
    summary = str_to_lower(summary)
  )

# Create two new columns, "CR" and "Count"
# Create the initial vector
headers <-
  monsters %>% 
  select(summary) %>% 
  filter(
    !(summary %in% c("average", "max"))
  ) %>% 
  unlist()

# Create the "challenge ratings" column
# To match the format of the clean data frame, the junk leading and trailing characters must first be excised
challenge_ratings <- headers %>% 
  str_replace_all(
    pattern = " ",
    replacement = ""
  ) %>% 
  str_replace_all(
    pattern = "challengerating=",
    replacement = ""
  ) %>% 
  str_replace_all(
    pattern = "\\(n=.*\\)",
    replacement = ""
  ) %>% 
  # Convert fractions to numeric values
  lapply(
    function(x) eval(
      parse(text = x)
    )
  ) %>% 
  # Coerce into numeric format
  as.numeric() %>% 
  # Round to 3 s.f. for sanity
  round(3)

# To match the format of the clean data frame, each entry must be duplicated once
challenge_ratings <-
  c(challenge_ratings, challenge_ratings) %>% 
  sort()

# Data cleaning, second pass
monsters <- 
  monsters %>% 
  clean_names() %>% 
  # Remove challenge rating rows
  filter(
    summary %in% c("average", "max")
  ) %>% 
  mutate(
    # Add challenge rating column
    cr = challenge_ratings
  ) %>% 
  # Convert into long format by pivoting the data
  pivot_longer(
    cols = hp:will,
    names_to = "statistic",
    values_to = "value"
  )

# Change column order
monsters <- monsters[,c(2,3,1,4)]

# Export to CSV
write.csv(
  x = monsters,
  file = "data/clean-data.csv"
)
