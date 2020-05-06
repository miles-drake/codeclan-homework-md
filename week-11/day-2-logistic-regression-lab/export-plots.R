source("logistic-regression-lab.R")

for(element in plots_to_export){
  
  file_name <- element %>% 
    str_to_lower() %>% 
    str_replace("plot_", "") %>% 
    str_replace_all("_", "-") %>% 
    str_c(".png")
  
  ggsave(
    filename = file_name,
    plot = eval(parse(text = element)),
    device = "png",
    path = "plots"
  )
  
}
