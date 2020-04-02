# Verification
# Check that "Title" values are sane
print("Unique values in the 'Title' field:")
print(unique(survey_original$Title))

print("Unique values in the 'dog_gender' field:")
print(unique(survey_original$dog_gender))

# Check that columns "x10" and "x11" are both empty
print("Unique values in the 'X10' and 'X11' fields (both should be empty):")
print(unique(survey_original$X10))
print(unique(survey_original$X11))

# Isolate the values with multiple entries
survey_original %>% 
  select(
    id,
    dog_gender
  ) %>% 
  filter(
    dog_gender %>% 
      str_detect(pattern = "and|,") %in% c(FALSE, NA)
  )
