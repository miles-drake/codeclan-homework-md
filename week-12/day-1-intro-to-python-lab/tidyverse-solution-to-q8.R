library(tidyverse)

scrambled_data <- read_lines("puzzle3input.txt")

output <- NULL

for(i in 1:8){
  
  add_to_output <- str_sub(scrambled_data, start = i, end = i) %>% 
    as_tibble() %>% 
    group_by(value) %>% 
    summarise(
      count = n()
    ) %>% 
    arrange(desc(count)) %>% 
    head(1) %>% 
    select(value) %>% 
    unlist()
  
  output <- str_c(output, add_to_output)
  
}
