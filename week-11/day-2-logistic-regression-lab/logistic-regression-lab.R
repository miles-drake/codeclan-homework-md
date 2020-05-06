# Required Libraries ------------------------------------------------------

library(janitor)
library(modelr)
library(readxl)
library(tidyverse)


# Data Preparation --------------------------------------------------------

# Set random seed for this session
# Ensures that any written analysis matches the model
random_seed <- 1L
set.seed(random_seed)

# Import and clean data set
churn <- read_xlsx("data/telecomms-churn.xlsx") %>% 
  clean_names() %>% 
  select(-customer_id) %>% 
  # Coerce senior_citizen into the same format as the rest of the data set
  mutate(
    senior_citizen = if_else(senior_citizen == 1, "Yes", "No")
  ) %>% 
  # Coerce character variables into factors
  mutate_if(is.character, as.factor)


# Plots -------------------------------------------------------------------

churn_rate_tbl <- function(variable_name){
  variable_name <- as.name(variable_name)
  churn %>% 
    group_by(!!variable_name) %>% 
    summarise(
      count = n(),
      churn_yes = sum(churn == "Yes"),
      churn_no = sum(churn == "No"),
      churn_rate = churn_yes / count
    )
}

churn_rate_plot <- function(churn_rate_tbl, variable_name){
  variable_name <- as.name(variable_name)
  churn_rate_tbl %>% 
    ggplot() + 
    aes(x = !!variable_name, y = churn_rate) + 
    geom_col()
}

churn_rate_gender <- churn_rate_tbl("gender")
plot_churn_rate_gender <- churn_rate_plot(churn_rate_gender, "gender")

churn_rate_senior_citizen <- churn_rate_tbl("senior_citizen")
plot_churn_rate_senior_citizen <- churn_rate_plot(churn_rate_senior_citizen, "senior_citizen")

churn_rate_partner <- churn_rate_tbl("partner")
plot_churn_rate_partner <- churn_rate_plot(churn_rate_partner, "partner")

churn_rate_dependents <- churn_rate_tbl("dependents")
plot_churn_rate_dependents <- churn_rate_plot(churn_rate_dependents, "dependents")

churn_rate_phone_service <- churn_rate_tbl("phone_service")
plot_churn_rate_phone_service <- churn_rate_plot(churn_rate_phone_service, "phone_service")

churn_rate_internet_service <- churn_rate_tbl("internet_service")
plot_churn_rate_internet_service <- churn_rate_plot(churn_rate_internet_service, "internet_service")

churn_rate_contract <- churn_rate_tbl("contract")
plot_churn_rate_contract <- churn_rate_plot(churn_rate_contract, "contract")

# The strong predictors are likely to be the following:
# contract, dependents, internet_service, partner, senior_citizen
# Due to time constraints, continuous variables have not been plotted
# It is likely some of these continuous variables are also predictors


# Logistic Regression Models ----------------------------------------------

model_contract <- glm(
  formula = churn ~ contract,
  data = churn,
  family = binomial(link = 'logit')
)

model_internet_service <- glm(
  formula = churn ~ internet_service,
  data = churn,
  family = binomial(link = 'logit')
)

model_tenure <- glm(
  formula = churn ~ tenure,
  data = churn,
  family = binomial(link = 'logit')
)

# The Pr(>|z|) of each coefficient is <2e-16, so each coefficient is significant


# Data With Single Predictors Attached ------------------------------------

pred_contract <- churn %>% 
  add_predictions(model_contract, type = "response")

pred_internet_service <- churn %>% 
  add_predictions(model_internet_service, type = "response")

pred_tenure <- churn %>% 
  add_predictions(model_tenure, type = "response")


# Export Plots ------------------------------------------------------------

plots_to_export <- c(
  "plot_churn_rate_contract",
  "plot_churn_rate_dependents",
  "plot_churn_rate_gender",
  "plot_churn_rate_internet_service",
  "plot_churn_rate_partner",
  "plot_churn_rate_phone_service",
  "plot_churn_rate_senior_citizen"
)

if(export_plots){
  
  for(element in plots_to_export){
    
    file_name <- element %>% 
      str_c(".png") %>% 
      str_to_lower() %>% 
      str_replace_all("_", "-")
    
    ggsave(
      filename = file_name,
      plot = eval(parse(text = element)),
      device = "png",
      path = "plots"
    )
    
  }
  
  rm(element, file_name)
  
}
