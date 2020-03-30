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
      # Summary statistics
      checkboxGroupInput(
        inputId = "summary",
        label = "Summary Statistics",
        choices = c(
          "Average", "Maximum"
        ),
        selected = "Average"
      ),
      
      hr(),
      
      # Armour classes (AC)
      checkboxGroupInput(
        inputId = "select_ac",
        label = "Armour Classes (AC)",
        choices = c(
          "AC",
          "Touch",
          "Flatfooted"
        ),
        selected = c(
          "AC",
          "Touch"
        )
      ),
      
      # Saving throws
      checkboxGroupInput(
        inputId = "select_saves",
        label = "Saving Throws",
        choices = c(
          "Fortitude",
          "Reflex",
          "Will"
        )
      ),
      
      # Other statistics
      checkboxGroupInput(
        inputId = "select_other",
        label = "Other Statistics",
        choices = c(
          "HP",
          "Initiative",
          "BAB"
        )
      ),
      
      hr(),
      
      # Challenge Rating selector
      sliderInput(
        inputId = "cr",
        label = "Challenge Rating (CR)",
        min = 0,
        max = max(monsters$cr),
        value = c(0, 20)
      )
      
    ),
  
    # Main panel
    # Interactive line graph
    mainPanel(
      # textOutput("test_selected_variables"),
      h3("Monster Statistics Graph"),
      dygraphOutput("dygraph"),
      h3("Legend and Mouseover Values"),
      div(id = "labels")
     )
  
  )
  
)
