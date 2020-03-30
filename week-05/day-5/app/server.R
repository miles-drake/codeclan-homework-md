# d20srd D&D v.3.5e Monster Data
# Server Logic
# Week 05, Day 5; Homework
# Miles Drake
# 2020-03-29

server <- function(input, output){
  
  # Concatenate user input into column names
  # Concatenate selected variables
  select_concatenate <- reactive({
    c(
      input$select_ac,
      input$select_saves,
      input$select_other
    )
  })
  
  # Average values
  selected_average <- reactive({
    if (sum(input$summary == "Average")){
      c(
        paste0(
          str_to_lower(select_concatenate()),
          "_average"
        )
      )
    }
  })
  
  # Maximum values
  selected_max <- reactive({
    if (sum(input$summary == "Maximum")){
      c(
        paste0(
          str_to_lower(select_concatenate()),
          "_max"
        )
      )
    }
  })
  
  # Selected variables
  selected_variables <- reactive({
    c(
      selected_average(),
      selected_max()
    )
  })
  
  # Output the above code for verification
  output$test_selected_variables <- renderText({
    selected_variables()
  })
  
  # Interactive line graph
  output$dygraph <- renderDygraph({
    monsters %>% 
      # Only show selected variables
      select(
        cr,
        selected_variables()
      ) %>% 
      # Only show selected challenge rating range
      filter(
        between(
          cr,
          min(input$cr),
          max(input$cr)
        )
      ) %>% 
      dygraph()
    })
  
}
