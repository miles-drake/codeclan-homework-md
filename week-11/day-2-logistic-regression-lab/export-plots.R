source("logistic-regression-lab.R")

plots_to_export <- c(
  "plot_churn_rate_contract",
  "plot_churn_rate_dependents",
  "plot_churn_rate_gender",
  "plot_churn_rate_internet_service",
  "plot_churn_rate_partner",
  "plot_churn_rate_phone_service",
  "plot_churn_rate_senior_citizen",
  "plot_roc_curves"
)

for(element in plots_to_export){
  
  file_name <- element %>% 
    str_c(".png") %>% 
    str_to_lower() %>% 
    str_replace_all("_", "-")
  
  ggsave(
    filename = file_name,
    plot = eval(parse(text = element)),
    device = "png",
    path = "plots"
  )
  
}
