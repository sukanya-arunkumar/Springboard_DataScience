install.packages("dplyr")
library("dplyr") 
library("tidyr")

file_path <- "C:/Users/JV/Desktop/R - Springboard/Unit3Exercise/Dealingwithmissingvalues/titanic3_original.csv"
output_file <- "C:/Users/JV/Desktop/R - Springboard/Unit3Exercise/Dealingwithmissingvalues/titanic3_cleaned.csv"

## Read the CSV file
titanic_data <- read.table(file_path, header = TRUE, sep = ",", stringsAsFactors = FALSE)

## 1. Port of embarkation
titanic_data$embarked[which(titanic_data$embarked == "")] = "S"

## 2. Age
avg_age <- mean(titanic_data$age, na.rm = TRUE)
titanic_data <- titanic_data %>% replace_na(list(age = round(avg_age)))

## 3.Lifeboat
titanic_data$boat[which(titanic_data$boat == "" | is.na(titanic_data$boat))] = "None"

## 4. Cabin
titanic_data <- titanic_data %>% 
  mutate(has_cabin_number = ifelse(grepl("^$", cabin), 0, 1))

View(titanic_data)

## Write the cleaned data to a csv
write.csv(titanic_data,output_file, row.names = FALSE)
