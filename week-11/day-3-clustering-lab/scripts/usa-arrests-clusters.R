# Required Libraries ------------------------------------------------------

library(cluster)
library(dendextend)
library(factoextra)
library(janitor)
library(tidyverse)

# Set random seed for this session
set.seed(1L)


# Load and Clean Data -----------------------------------------------------

arrests <- USArrests %>% 
  clean_names() %>% 
  rownames_to_column("state") %>% 
  left_join(read_csv("data/state-usps-abbreviations.csv")) %>% 
  select(usps_abr, urban_pop, assault, murder, rape) %>% 
  rename(state = usps_abr) %>% 
  # Standardise the variables, otherwise assault will overshadow all other charges
  mutate_if(is.numeric, scale) %>% 
  # A new variable, crime_factor, contains the average standardised crime rate
  mutate(crime_factor = (assault + murder + rape) / 3)


# Preliminary Analysis ----------------------------------------------------

# Plot of all states against respective crime rates
arrests %>% 
  ggplot() + 
  aes(x = state) + 
  geom_point(aes(y = murder), colour = "red") + 
  geom_point(aes(y = assault), colour = "green") + 
  geom_point(aes(y = rape), colour = "blue")

# Plot of urban population against respective crime rates
arrests %>% 
  ggplot() + 
  aes(x = urban_pop) + 
  geom_point(aes(y = murder), colour = "red") + 
  geom_point(aes(y = assault), colour = "green") + 
  geom_point(aes(y = rape), colour = "blue")

# Plot of all states against average crime factor
arrests %>% 
  ggplot() + 
  aes(x = state, y = crime_factor) + 
  geom_point()

# Plot of urban population against average crime factor
arrests %>% 
  ggplot() + 
  aes(x = urban_pop, y = crime_factor) + 
  geom_point() + 
  geom_smooth()

