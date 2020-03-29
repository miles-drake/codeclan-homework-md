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

# Clean column names
monsters <- 
  monsters %>% 
  clean_names()
colnames(monsters)[1] <- "summary"

# Create the "challenge ratings" column
# To match the format of the clean tibble, the junk leading and trailing strings must first be excised, then each entry duplicated once
challenge_ratings <-
  monsters %>% 
  select(summary) %>% 
  filter(
    !(summary %in% c("Average", "Max"))
  ) %>% 
  mutate(
    summary = str_replace_all(
      string = summary,
      pattern = "Challenge rating = ",
      replacement = ""
    ),
    summary = str_sub(
      string = summary,
      start = 1,
      end = -9
    ),
    summary = str_replace_all(
      string = summary,
      pattern = " ",
      replacement = ""
    )
  ) %>% 
  unlist() %>% 
  # Convert fractions to numeric values
  lapply(
    function(x) eval(
      parse(text = x)
    )
  ) %>% 
  # Coerce into numeric format
  as.numeric() %>% 
  round(3)

challenge_ratings <-
  c(challenge_ratings, challenge_ratings) %>% 
  sort()

# Data cleaning
monsters <- 
  monsters %>% 
  clean_names() %>% 
  # Remove challenge rating rows
  filter(
    summary %in% c("Average", "Max")
  ) %>% 
  mutate(
    # Add challenge rating column
    cr = challenge_ratings,
    # Coerce summary column into lowercase
    summary = str_to_lower(summary)
  ) %>% 
  # Convert into long format by pivoting the data
  pivot_longer(
    cols = hp:will,
    names_to = "statistic",
    values_to = "value"
  )

monsters <- monsters[,c(2,3,1,4)]

# Export to CSV
write.csv(
  x = monsters,
  file = "data/clean-data.csv"
)
