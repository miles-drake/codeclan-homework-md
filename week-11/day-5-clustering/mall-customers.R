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

# Reduce Data Set ---------------------------------------------------------

# Reduce the data set down into annual income and spending power only

mallrats <- mallrats %>% 
  select(annual_income, spending_score)

# Preliminary Analysis ----------------------------------------------------

scatterplot <- mallrats %>% 
  ggplot() + 
  aes(x = annual_income, y = spending_score) + 
  labs(
    title = "Shoppers' annual income against derived spending score",
    subtitle = "Shopping centre customer data",
    x = "Annual income",
    y = "Spending score"
  ) + 
  geom_point()

# We can see at least five distinct clusters in the scatterplot


# Choosing a Value for k --------------------------------------------------

plot_optimal_k_value <- fviz_nbclust(mallrats, kmeans, method = "wss")

# We choose k = 4, where there is a slight change in the gradient of the graph
