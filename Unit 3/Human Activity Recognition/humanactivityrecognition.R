# install.packages("dplyr")
# library("dplyr")
# library("tidyr")

train_dir <- "C:/Users/JV/Desktop/R - Springboard/Unit3Exercise/HumanActivityRecognition/UCI HAR Dataset/train"
train_input <- paste(train_dir ,"X_train.txt", sep = "/")
test_dir <- "C:/Users/JV/Desktop/R - Springboard/Unit3Exercise/HumanActivityRecognition/UCI HAR Dataset/test"
test_input <- paste(test_dir, "X_test.txt", sep = "/")
colname_input <- "C:/Users/JV/Desktop/R - Springboard/Unit3Exercise/HumanActivityRecognition/UCI HAR Dataset/features.txt"
output_file <- "C:/Users/JV/Desktop/R - Springboard/Unit3Exercise/HumanActivityRecognition/tidy_data.csv"
analysis_file <- "C:/Users/JV/Desktop/R - Springboard/Unit3Exercise/HumanActivityRecognition/meanSD_data.csv"

## Read the column names from features.txt into a vector. Common for both train and test data
column_names <- read.table(file = colname_input,header = FALSE, col.names = c("No", "Names"))
## View(column_names)

## Read the training data and add the subject details
train_df <- read.table(file = train_input, col.names = column_names$Names)
subject_train <- read.table(file = paste(train_dir,"subject_train.txt", sep = "/"), header = FALSE, col.names = "Subject")
train_df <- train_df %>% mutate(Subject = subject_train$Subject)

## Read the test data and add the subject details
test_df <- read.table(file = test_input, col.names = column_names$Names)
subject_test <- read.table(file = paste(test_dir,"subject_test.txt", sep = "/"), header = FALSE, col.names = "Subject")
test_df <- test_df %>% mutate(Subject = subject_test$Subject)

## 1. Merge data sets
alldata_df <- rbind(train_df, test_df)
## print(nrow(alldata_df))
## print(ncol(alldata_df))

## 3. Add new variables - ActivityLabel, ActivityName
actlabel_train <- read.table(file = paste(train_dir, "Y_train.txt",sep="/"),header= FALSE, col.names = "ActivityLabel")
actlabel_test <- read.table(file = paste(test_dir, "Y_test.txt",sep="/"),header= FALSE, col.names = "ActivityLabel")
activity_df <- rbind(actlabel_test, actlabel_train)
## print(nrow(activity_df))

activity_df <- activity_df %>% mutate(ActivityName = ifelse(ActivityLabel == 1,"WALKING", 
                                                            ifelse(ActivityLabel == 2, "WALKING_UPSTAIRS",
                                                                   ifelse(ActivityLabel == 3, "WALKING_DOWNSTAIRS",
                                                                          ifelse(ActivityLabel == 4,"SITTING",
                                                                                 ifelse(ActivityLabel == 5, "STANDING",
                                                                                        ifelse(ActivityLabel == 6, "LAYING", "None"))))))) 
alldata_df <- alldata_df %>% mutate(ActivityLabel=activity_df$ActivityLabel,ActivityName=activity_df$ActivityName)

## 2 extract the mean and standard deviation measurements and 
##   calculate the mean of each mean and standard deviation measurement for each activity.
alldata_df %>% select(contains("mean"), contains("std"), ActivityName) %>%
  group_by( ActivityName) %>%
  summarise_each(funs( mean)) %>%
  View(title = "Avgformeasurement")

alldata_df %>% select(contains("mean"), contains("std"), ActivityName) %>%
  group_by( ActivityName) %>%
  summarise_each(funs( sd)) %>%
  View(title = "Sdformeasurement")

## 4. Create tidy data set
run_analysis <- alldata_df %>% 
                  group_by(Subject, ActivityName) %>%
                  summarise_each(funs( mean))

View(alldata_df)
View(run_analysis)

## Write the cleaned data into a csv
write.csv(run_analysis,analysis_file, row.names = FALSE)
write.csv(alldata_df, output_file, row.names = FALSE)
