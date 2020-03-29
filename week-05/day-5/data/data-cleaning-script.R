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

# Data cleaning, first pass
# Clean column names
monsters <- clean_names(monsters)
colnames(monsters)[1] <- "summary"
# Convert summary column to lowercase for consistency
monsters <- monsters %>% 
  mutate(
    summary = str_to_lower(summary)
  )

# Create two new columns, "CR" and "Count"
# Create a blank list to contain these columns
new_columns <- NULL
# Create the initial vector
headers <-
  monsters %>% 
  select(summary) %>% 
  filter(
    !(summary %in% c("average", "max"))
  ) %>% 
  unlist()

# Create the "CR" column
# To match the format of the clean data frame, the junk leading and trailing characters must first be excised
new_columns$cr <- headers %>% 
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
  as.numeric() %>% 
  round(3)

# Create the "count" column
new_columns$count <- headers %>% 
  str_replace_all(
    pattern = " ",
    replacement = ""
  ) %>% 
  str_extract(
    "\\(n=.*\\)"
  ) %>% 
  str_extract(
    "[0-9]{1,2}"
  ) %>% 
  as.numeric()

# To match the format of the clean data frame, each entry must be duplicated once
new_columns$cr <- c(new_columns$cr, new_columns$cr)

# Coerce new columns list into a data frame
new_columns <- as.data.frame(new_columns)

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
    cr = new_columns$cr,
    # Add count column
    count = new_columns$count
  ) %>% 
  # Convert into long format by pivoting the data
  pivot_longer(
    cols = hp:will,
    names_to = "statistic",
    values_to = "value"
  )

# Change column order
monsters <- monsters[,c(
  "cr",
  "count",
  "summary",
  "statistic",
  "value"
)]

# Export to CSV
write.csv(
  x = monsters,
  file = "data/clean-data.csv"
)
