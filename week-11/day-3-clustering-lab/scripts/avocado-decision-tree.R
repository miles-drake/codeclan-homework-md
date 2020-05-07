# Required Libraries ------------------------------------------------------

library(janitor)
library(rpart)
library(rpart.plot)
library(tidyverse)

# Set random seed for this session
random_seed <- 1L
set.seed(random_seed)


# Load and Clean Data -----------------------------------------------------

avocado <- read_csv("data/avocado.csv") %>% 
  clean_names() %>% 
  rename(
    id = x1,
    plu_4046 = x4046,
    plu_4225 = x4225,
    plu_4770 = x4770
  ) %>% 
  mutate(
    region = str_extract_all(region, "[A-Z]")
  ) %>% 
  rowwise() %>% 
  mutate(
    region = str_c(region, collapse = "")
  )


# Partition Data ----------------------------------------------------------

# Create a test sample index, of size equal to 1/5th of the data set
test_sample_index <- sample(1:nrow(avocado), size = nrow(avocado)*0.2)

# Create test set
test_set  <- slice(avocado, test_sample_index)

# Create training set
training_set <- slice(avocado, -test_sample_index)


# Build Decision Tree -----------------------------------------------------

# Likelihood of a sale of an avocado being ~*~ organic ~*~
# Grass-fed, cruelty-free avocado
avocado_tree <- rpart(
  formula = type ~ average_price + total_volume + year + region,
  data = training_set,
  method = "class"
)

rpart.plot(avocado_tree, yesno = 2)
