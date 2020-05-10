# Required Libraries ------------------------------------------------------

library(janitor)
library(rpart)
library(rpart.plot)
library(tidyverse)


# Data Preparation --------------------------------------------------------

titanic_set <- read_csv("data/titanic-decision-tree.csv")

# Set random seed for this session
# Ensures that any written analysis matches the model
random_seed <- 1L
set.seed(random_seed)

# Shuffle the data so class order isn't sorted
# Need this for training/testing split later on
shuffle_index <- sample(1:nrow(titanic_set))
titanic_set <- titanic_set[shuffle_index, ]


# Data Dictionary ---------------------------------------------------------

# sex: Biological sex; male or female
# age_status: adult or child (child defined as under 16)
# class: Ticket class, 1 = 1st (Upper class), 2 = 2nd (Middle Class), 3 = 3rd (Lower Class)
# port_embarkation: C = Cherbourg, Q = Queenstown, S = Southampton
# sibsp : number of siblings / spouses aboard the Titanic
# parch: number of parents / children aboard the Titanic
# - Some children travelled only with a nanny, therefore parch = 0 for them
# survived_flag : did they survive, 0 = No, 1 = Yes


# Data Cleaning -----------------------------------------------------------

# Some columns are renamed to conform to the data dictionary standards

titanic_set <- titanic_set %>% 
  clean_names() %>% 
  rename(
    "row_id" = x1,
    "sibsp" = sib_sp
  ) %>% 
  filter(!is.na(survived)) %>% 
  mutate(
    sex = as.factor(sex),
    age_status = as.factor(
      if_else(age > 16, "adult", "child")
    ),
    class = factor(
      x = pclass,
      levels = c(1, 2, 3),
      labels = c("upper", "middle", "lower")
    ),
    port_embarkation = factor(
      x = embarked,
      levels = c("C", "Q", "S"),
      labels = c("cherbourg", "queenstown", "southampton")
    ),
    survived_flag = factor(
      x = survived,
      levels = c(0, 1),
      labels = c("no", "yes")
    )
  ) %>% 
  na.omit() %>% 
  select(sex, age_status, class, port_embarkation, sibsp, parch, survived_flag)
