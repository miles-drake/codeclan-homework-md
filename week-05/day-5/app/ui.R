# d20srd D&D v.3.5e Monster Data
# UI Logic
# Week 05, Day 5; Homework
# Miles Drake
# 2020-03-29

ui <- fluidPage(
  
  # Title
  titlePanel("Dungeons & Dragons v.3.5e Aggregate Monster Statistics"),
  
  # Layout
  sidebarLayout(
    
    # Sidebar
    sidebarPanel(
      
      # Checkboxes
      checkboxGroupInput(
        inputId = "variable",
        label = "Select variables:",
        choices = c(
          "AC",
          "Touch",
          "Flatfooted",
          "HP",
          "Initiative",
          "BAB",
          "Fortitude",
          "Reflex",
          "Will"
        ),
        selected = c(
          "AC",
          "Touch"
        )
      ),
      
      checkboxGroupInput(
        inputId = "summary",
        label = "Select summary statistics:",
        choices = c(
          "Average", "Maximum"
        ),
        selected = "Average"
      )
      
    ),
  
    # Main panel
    # Interactive line graph
    mainPanel(
      # textOutput("test_selected_variables"),
      dygraphOutput("dygraph")
     )
  
  )
  
)
