# Required Libraries ------------------------------------------------------

library(cluster)
library(dendextend)
library(factoextra)
library(GGally)
library(janitor)
library(tidyverse)

# Set random seed for this session
# Ensures that results are reproducable; *only* for the sake of analysis
set.seed(1L)

# Load and Clean Data -----------------------------------------------------

mallrats <- read_csv("mall-customers.csv") %>% 
  clean_names() %>% 
  select(-customer_id) %>% 
  rename(
    annual_income = annual_income_k,
    spending_score = spending_score_1_100
  ) %>% 
  mutate(gender = as.factor(gender)) %>% 
  # Scale the numeric columns, because they have very different numerical values and units
  mutate_if(is.numeric, scale)
