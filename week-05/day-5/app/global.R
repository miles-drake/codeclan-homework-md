# d20srd D&D v.3.5e Monster Data
# Global Logic
# Week 05, Day 5; Homework
# Miles Drake
# 2020-03-29

# Libraries
library(shiny)
library(dplyr)
library(dygraphs)
library(readr)

# Read in CSV data
monsters <- read_csv("../data/clean-data.csv")

# Fetch column names
variables <- colnames(monsters)[3:20]
