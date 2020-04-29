library(fastDummies)
library(GGally)
library(tidyverse)

# MVP Question 1 -------------------------------------------------------------------

# Load the diamonds.csv data set and undertake an initial exploration of the data. You will find a description of the meanings of the variables on the relevant Kaggle page.

data <- read_csv("diamonds.csv") %>% 
  rename(index = X1)


# MVP Question 2 -------------------------------------------------------------------

# We expect the carat of the diamonds to be strong correlated with the physical dimensions x, y and z. Use ggpairs() to investigate correlations between these four variables.

data %>% 
  select(carat, x, y, z) %>% 
  ggpairs()


# MVP Question 3 -------------------------------------------------------------------

# So, we do find significant correlations. Let’s drop columns x, y and z from the dataset, in preparation to use only carat going forward.

data <- data %>% 
  select(-x, -y, -z)


# MVP Question 4 -------------------------------------------------------------------

# We are interested in developing a regression model for the price of a diamond in terms of the possible predictor variables in the dataset.
# Q4.1: Use ggpairs() to investigate correlations between price and the predictors (this may take a while to run, don’t worry, make coffee or something).

# Remove the index variable from the predictors, since that intuitively will not be a predictor variable

data %>% 
  select(-index) %>% 
  ggpairs()

# price and carat are very strong correlated (Corr: 0.922)
# Additionally, there is some variation in the boxplots of price vs cut, color, and clarity

# Q4.2: Perform further ggplot visualisations of any significant correlations you find.

data %>% 
  ggplot() + 
  aes(x = carat, y = price) + 
  geom_line() + 
  geom_smooth()


# MVP Question 5 -------------------------------------------------------------------

# Shortly we may try a regression fit using one or more of the categorical predictors cut, clarity and color, so let’s investigate these predictors:
# Q5.1: Investigate the factor levels of these predictors. How many dummy variables do you expect for each of them?

# We expect n-1 dummy variables for each predictor

count_dummies <- function(column_name){
  data %>% 
    select(!!column_name) %>% 
    unique() %>% 
    nrow() - 1 %>% 
    as.integer() %>% 
    return()
}

predictor_names <- c("cut", "color", "clarity")

dummy_count <- tibble(predictor = predictor_names) %>% 
  rowwise() %>% 
  mutate(dummy_count = count_dummies(predictor))

# Q5.2: Use the dummy_cols() function in the fastDummies package to generate dummies for these predictors and check the number of dummies in each case.

dummies <- data %>% 
  dummy_cols(
    select_columns = predictor_names,
    remove_first_dummy = TRUE
  )


# MVP Question 6 ----------------------------------------------------------

# Going forward we’ll let R handle dummy variable creation for categorical predictors in regression fitting (remember lm() will generate the correct numbers of dummy levels automatically, absorbing one of the levels into the intercept as a reference level)

# Q6.1: First, we’ll start with simple linear regression. Regress price on carat and check the regression diagnostics.

# Q6.2: Run a regression with one or both of the predictor and response variables log() transformed and recheck the diagnostics. Do you see any improvement?

# Q6.3: Let’s use log() transformations of both predictor and response. Next, experiment with adding a single categorical predictor into the model. Which categorical predictor is best?
# [Hint - investigate \(r^2\) values]

# Q6.4: Interpret the fitted coefficients for the levels of your chosen categorical predictor. Which level is the reference level? Which level shows the greatest difference in price from the reference level?
# [Hints - remember we are regressing the log(price) here, and think about what the presence of the log(carat) predictor implies. We’re not expecting a mathematical explanation]


# Extension Question 1 ----------------------------------------------------

# Try adding an interaction between log(carat) and your chosen categorical predictor. Do you think this interaction term is statistically justified?

# Extension Question 2 ----------------------------------------------------

# Find and plot an appropriate visualisation to show the effect of this interaction.
