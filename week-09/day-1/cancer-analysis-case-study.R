# Libraries ---------------------------------------------------------------

library(janitor)
library(tidyverse)


# Define Variables --------------------------------------------------------

plot_width <- 764L


# Load Data ---------------------------------------------------------------

# Downloaded from https://www.opendata.nhs.scot/dataset/annual-cancer-incidence
# Number of new cancer registrations in Scotland by sex and age since 1992
# Publication Date 24 April 2018

health_board_codes <- read_csv("data/geography-codes-and-labels.csv") %>% 
  clean_names() %>% 
  select(-country)

incidence_data_scotland <- read_csv("data/incidence-at-scotland-level.csv") %>% 
  clean_names() %>% 
  select(-country) %>% 
  filter(year <= 2017)

incidence_data_cancer_network <- read_csv("data/incidence-by-cancer-network-region.csv") %>% 
  clean_names() %>% 
  filter(year <= 2017)

incidence_data_health_board <- read_csv("data/incidence-by-health-board.csv") %>% 
  clean_names() %>% 
  filter(year <= 2017)

incidence_data_health_board <- incidence_data_health_board %>% 
  left_join(health_board_codes, by = "hb") %>% 
  select(hb_name, cancer_site_icd10code:sir_upper95pc_confidence_interval)


# Vectors -----------------------------------------------------------------

years <- incidence_data_scotland %>% 
  select(year) %>% 
  unique()

major_breaks <- c(1995, 2000, 2005, 2010, 2015)


# Data Subsets ------------------------------------------------------------

incidence_data_scotland_male <- incidence_data_scotland %>% 
  filter(cancer_site == "All cancer types", sex == "Male") %>% 
  select(year, crude_rate)

incidence_data_scotland_female <- incidence_data_scotland %>% 
  filter(cancer_site == "All cancer types", sex == "Female") %>% 
  select(year, crude_rate)

incidence_data_scotland_bysex <- inner_join(
  x = incidence_data_scotland_male,
  y= incidence_data_scotland_female,
  by = "year",
  suffix = c("_male", "_female")
)

###

incidences_male <- incidence_data_scotland %>% 
  filter(cancer_site == "All cancer types", sex == "Male") %>% 
  select(year, incidences_all_ages)

incidences_female <- incidence_data_scotland %>% 
  filter(cancer_site == "All cancer types", sex == "Female") %>% 
  select(year, incidences_all_ages)

incidences_by_sex <- inner_join(
  x = incidences_male,
  y= incidences_female,
  by = "year",
  suffix = c("_male", "_female")
)

rm(incidences_male, incidences_female)


# Plots -------------------------------------------------------------------

incidence_data_scotland %>% 
  filter(cancer_site == "All cancer types", sex == "All") %>% 
  ggplot() + 
  aes(
    x = year,
    y = incidences_all_ages / 1000
  ) + 
  geom_line(
    size = 1.5,
    alpha = 0.5
  ) + 
  geom_smooth(
    size = 1.5
  ) + 
  scale_x_continuous(
    breaks = major_breaks,
    labels = major_breaks
  ) + 
  labs(
    x = "Year",
    y = "Number of cancers diagnosed (thousands)",
    title = "Number of Cancers Diagnosed in Scotland over Time",
    subtitle = "From the Scottish Cancer Registry (SMR06), Publication Date 24 April 2018"
  )

incidence_data_scotland %>% 
  filter(cancer_site == "All cancer types", sex == "All") %>% 
  ggplot() + 
  aes(
    x = year,
    y = crude_rate
  ) + 
  geom_line(
    size = 1.5,
    alpha = 0.5
  ) + 
  geom_smooth(
    size = 1.5
  ) + 
  scale_x_continuous(
    breaks = major_breaks,
    labels = major_breaks
  ) + 
  labs(
    x = "Year",
    y = "Incidence rate (all ages) per 100,000 people",
    title = "Incidence Rate of All Cancers in Scotland",
    subtitle = "From the Scottish Cancer Registry (SMR06), Publication Date 24 April 2018"
  )


incidence_data_scotland %>% 
  filter(cancer_site == "All cancer types", sex == "All") %>% 
  ggplot() + 
  aes(
    x = year,
    y = crude_rate
  ) + 
  geom_line(
    size = 1.5,
    alpha = 0.5
  ) + 
  geom_smooth(
    size = 1.5
  ) + 
  scale_x_continuous(
    breaks = major_breaks,
    labels = major_breaks
  ) + 
  labs(
    x = "Year",
    y = "Incidence rate (all ages) per 100,000 people",
    title = "Incidence Rate of All Cancers in Scotland",
    subtitle = "From the Scottish Cancer Registry (SMR06), Publication Date 24 April 2018"
  )

incidence_data_scotland_bysex %>% 
  ggplot() + 
  aes(x = year) + 
  geom_line(
    aes(y = crude_rate_female, colour = "dark green"),
    size = 1.5,
    alpha = 0.5
  ) + 
  geom_smooth(
    aes(y = crude_rate_female, colour = "dark green"),
    size = 1.5
  ) + 
  geom_line(
    aes(y = crude_rate_male, colour = "red"),
    size = 1.5,
    alpha = 0.5
  ) + 
  geom_smooth(
    aes(y = crude_rate_male, colour = "red"),
    size = 1.5
  ) + 
  scale_x_continuous(
    breaks = major_breaks,
    labels = major_breaks
  ) + 
  labs(
    x = "Year",
    y = "Incidence rate (all ages) per 100,000 people",
    title = "Incidence Rate of All Cancers in Scotland by Sex",
    subtitle = "From the Scottish Cancer Registry (SMR06), Publication Date 24 April 2018"
  ) + 
  scale_color_discrete(
    name = "Sex",
    labels = c("Female", "Male")
  )

incidence_data_scotland %>% 
  filter(cancer_site == "All cancer types", sex == "All") %>% 
  ggplot() + 
  aes(
    x = year,
    y = crude_rate
  ) + 
  geom_line(
    size = 1.5,
    alpha = 0.5
  ) + 
  geom_smooth(
    size = 1.5
  ) + 
  scale_x_continuous(
    breaks = major_breaks,
    labels = major_breaks
  ) + 
  labs(
    x = "Year",
    y = "Incidence rate (all ages) per 100,000 people",
    title = "Incidence Rate of All Cancers in Scotland",
    subtitle = "From the Scottish Cancer Registry (SMR06), Publication Date 24 April 2018"
  )


# Incidences by Sex -------------------------------------------------------

plot_incidences_by_sex <- incidences_by_sex %>% 
  ggplot() + 
  aes(x = year) + 
  geom_line(
    aes(y = incidences_all_ages_female, colour = "dark green"),
    size = 1.5,
    alpha = 0.5
  ) + 
  geom_smooth(
    aes(y = incidences_all_ages_female, colour = "dark green"),
    size = 1.5
  ) + 
  geom_line(
    aes(y = incidences_all_ages_male + 719.1667, colour = "red"),
    size = 1.5,
    alpha = 0.5
  ) + 
  geom_smooth(
    aes(y = incidences_all_ages_male + 719.1667, colour = "red"),
    size = 1.5
  ) + 
  scale_x_continuous(
    breaks = major_breaks,
    labels = major_breaks
  ) + 
scale_y_continuous(
  breaks = NULL,
  labels = NULL
  ) +
  labs(
    x = "",
    y = "",
    title = "",
    subtitle = ""
  ) + 
  scale_color_discrete(
    name = "Sex",
    labels = c("Female", "Male")
  )


# Export Plots to PNG -----------------------------------------------------

plot_incidences_by_sex %>% 
  dev.print(file="test.png", device = "png", width = plot_width, units = "px")
