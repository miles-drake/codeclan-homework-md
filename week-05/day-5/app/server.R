# d20srd D&D v.3.5e Monster Data
# Server Logic
# Week 05, Day 5; Homework
# Miles Drake
# 2020-03-29

server <- function(input, output){
    output$dygraph <- renderDygraph({
        monsters %>% 
        select(
          -count
        ) %>% 
        filter(
            cr < 20
        ) %>% 
        dygraph()
    })
}
