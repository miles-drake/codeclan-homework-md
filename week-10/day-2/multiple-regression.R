library(tidyverse)

data <- read_csv("diamonds.csv") %>% 
  rename(index = X1)


# MVP Question 1 -------------------------------------------------------------------

# Load the diamonds.csv data set and undertake an initial exploration of the data. You will find a description of the meanings of the variables on the relevant Kaggle page.


# MVP Question 2 -------------------------------------------------------------------

# We expect the carat of the diamonds to be strong correlated with the physical dimensions x, y and z. Use ggpairs() to investigate correlations between these four variables.


# MVP Question 3 -------------------------------------------------------------------

# So, we do find significant correlations. Let’s drop columns x, y and z from the dataset, in preparation to use only carat going forward.

# MVP Question 4 -------------------------------------------------------------------

# We are interested in developing a regression model for the price of a diamond in terms of the possible predictor variables in the dataset.
# Use ggpairs() to investigate correlations between price and the predictors (this may take a while to run, don’t worry, make coffee or something).
# Perform further ggplot visualisations of any significant correlations you find.



# MVP Question 5 -------------------------------------------------------------------

# Shortly we may try a regression fit using one or more of the categorical predictors cut, clarity and color, so let’s investigate these predictors:
# Investigate the factor levels of these predictors. How many dummy variables do you expect for each of them?
# Use the dummy_cols() function in the fastDummies package to generate dummies for these predictors and check the number of dummies in each case.



# MVP Question 6 ----------------------------------------------------------

# Going forward we’ll let R handle dummy variable creation for categorical predictors in regression fitting (remember lm() will generate the correct numbers of dummy levels automatically, absorbing one of the levels into the intercept as a reference level)
# First, we’ll start with simple linear regression. Regress price on carat and check the regression diagnostics.
# Run a regression with one or both of the predictor and response variables log() transformed and recheck the diagnostics. Do you see any improvement?
# Let’s use log() transformations of both predictor and response. Next, experiment with adding a single categorical predictor into the model. Which categorical predictor is best?
# [Hint - investigate \(r^2\) values]
# Interpret the fitted coefficients for the levels of your chosen categorical predictor. Which level is the reference level? Which level shows the greatest difference in price from the reference level?
# [Hints - remember we are regressing the log(price) here, and think about what the presence of the log(carat) predictor implies. We’re not expecting a mathematical explanation]



# Extension Question 1 ----------------------------------------------------

# Try adding an interaction between log(carat) and your chosen categorical predictor. Do you think this interaction term is statistically justified?

# Extension Question 2 ----------------------------------------------------

# Find and plot an appropriate visualisation to show the effect of this interaction.
