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
        label = "Select variables to show:",
        choices = variables,
        selected = c(
          "ac_average", "ac_max",
          "touch_average", "touch_max")
      )
      
    ),
  
    # Main panel
    # Interactive line graph
    mainPanel(
      dygraphOutput("dygraph")
     )
  
  )
  
)
