# Give me that juice
# Give me that juice
# With the orange and lime
# It's tasting mighty fine
# Come on now give me that juice


# Required libraries ------------------------------------------------------

library(janitor)
library(tidyverse)


# Load and clean data -----------------------------------------------------

data <- read_csv("orange-juice.csv") %>% 
  clean_names() %>% 
  select(-store7, -store) %>% 
  # Give columns more descriptive names
  rename(
    week_of_purchase = weekof_purchase,
    discount_ch = disc_ch,
    discount_mm = disc_mm,
    loyalty_ch = loyal_ch,
    pct_discount_mm = pct_disc_mm,
    pct_discount_ch = pct_disc_ch
  ) %>% 
  mutate(
    purchase = factor(
      x = purchase,
      levels = c("CH", "MM"),
      labels = c("Citrus Hill", "Minute Maid")
    )
  )
