# d20srd D&D v.3.5e Monster Data
# Deployment Script
# Week 05, Day 5; Homework
# Miles Drake
# 2020-03-29

# Libraries
library(rsconnect)

# Deploy to shinyapps.io
# https://presumptuous-paladin.shinyapps.io/dnd35e-monsters/
rsconnect::deployApp(
  appFiles = c(
    "global.R",
    "server.R",
    "ui.R",
    "data/clean-data.csv"
  ),
  appName = "dnd35e-monsters",
  forceUpdate = TRUE,
  launch.browser = FALSE
)
