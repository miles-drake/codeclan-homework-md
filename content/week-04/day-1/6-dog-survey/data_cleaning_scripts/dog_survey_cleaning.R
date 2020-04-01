# Libraries
library(tidyverse)
library(janitor)

# Read in the raw data, and create a copy for verification
survey <- read_csv("raw_data/dog_survey.csv")
survey_original <- survey

# Verification
source("data_cleaning_scripts/dog_survey_verification.R")

# Data cleaning
survey <- survey %>% 
  
  # Convert "Title" column to snake case
  clean_names() %>% 
  
  # Remove the empty columns "X10" and "X11"
  select(
    -x10, -x11
  ) %>% 
  
  # Remove the entries where one individual wrote in multiple dogs
  # We are using the "gender" column to isolate these cases
  filter(
    dog_gender %>% 
      # Remove all entries containing "and" or a comma
      str_detect("and|,") %in% c(FALSE, NA)
  ) %>% 
  
  # At a later point, we will be repurposing the "dog_gender" column into a logical "dog_male" column
  rename(
    dog_male = dog_gender
  ) %>% 
  
  mutate(
    
    # Coerce "id" column into integer format
    id = id %>% 
      as.integer(),
    
    # Force consistent formatting in "title" column
    title = title %>% 
      str_sub(start = 1L, end = 3L),
    
    # Force correct formatting in "email" column
    email = email %>% 
      str_to_lower() %>% 
      # Retain entry only if it contains an @, otherwise introduce an NA value
      str_detect("@") %>% 
        ifelse(email, NA),
    
    # Coerce "amount_spent_on_dog_food" column into numeric format
    amount_spent_on_dog_food = amount_spent_on_dog_food %>% 
      # Strip all non-currency characters
      # We assume that negative values are intended to be positive, so we also strip the minus symbol
      str_replace_all("[^0-9£.]", "") %>% 
      # Strip only the first GBP symbol
      # This intentionally introduces NA values where the respondant has answered with a range of values
      str_replace("£", "") %>% 
      # Coerce into numeric format
      # This introduces NA values for entries that are a range of values, or are invalid answers
      as.numeric(),
    
    # Convert "dog_size" column into a numeric format
    dog_size = dog_size %>% 
      str_to_lower() %>% 
      str_replace("xs", "0") %>% 
      str_replace("xl", "4") %>% 
      str_sub(start = 1L, end = 1L) %>% 
      str_replace("s", "1") %>% 
      str_replace("m", "2") %>% 
      str_replace("l", "3") %>% 
      # Coerce into integer format
      # This introduces NA values for entries that do not fit the above code
      as.integer(),
    
    # Convert "dog_gender" column into a logical "dog_male" column
    dog_male = dog_male %>% 
      # Consider only first letter of string; convert into lowercase
      str_sub(start = 1L, end = 1L) %>% 
      str_to_lower() %>% 
      str_replace_all("m", "1") %>% # Replace all male dogs with TRUE
      str_replace_all("f", "0") %>% # Replace all female dogs with FALSE
      # Coerce into integer format
      # This intentionally replaces nonbinary values with NA
      as.integer() %>% 
      as.logical(),
    
    # Convert "age" column into numeric format
    dog_age = dog_age %>% 
      str_replace_all("[^0-9]", "") %>% # Strip all non-numeric characters
      as.integer()
    
  ) %>% 
  
  # Show only distinct entries
  distinct() %>% 
  
  # Arrange by "id"
  arrange(id)

# Write clean data to CSV
write_csv(survey, "clean_data/dog_survey_clean.csv")
