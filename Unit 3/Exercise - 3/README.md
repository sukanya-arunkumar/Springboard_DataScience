**Data Wrangling Exercise 2: Dealing with missing values**
==========================================================

This is a data set that records various attributes of passengers on the
Titanic, including who survived and who didn’t.

The structure of the dataset is as follows:

    ##      pclass         survived         name               sex           
    ##  Min.   :1.000   Min.   :0.000   Length:1309        Length:1309       
    ##  1st Qu.:2.000   1st Qu.:0.000   Class :character   Class :character  
    ##  Median :3.000   Median :0.000   Mode  :character   Mode  :character  
    ##  Mean   :2.295   Mean   :0.382                                        
    ##  3rd Qu.:3.000   3rd Qu.:1.000                                        
    ##  Max.   :3.000   Max.   :1.000                                        
    ##                                                                       
    ##       age              sibsp            parch          ticket         
    ##  Min.   : 0.1667   Min.   :0.0000   Min.   :0.000   Length:1309       
    ##  1st Qu.:21.0000   1st Qu.:0.0000   1st Qu.:0.000   Class :character  
    ##  Median :28.0000   Median :0.0000   Median :0.000   Mode  :character  
    ##  Mean   :29.8811   Mean   :0.4989   Mean   :0.385                     
    ##  3rd Qu.:39.0000   3rd Qu.:1.0000   3rd Qu.:0.000                     
    ##  Max.   :80.0000   Max.   :8.0000   Max.   :9.000                     
    ##  NA's   :263                                                          
    ##       fare            cabin             embarked        
    ##  Min.   :  0.000   Length:1309        Length:1309       
    ##  1st Qu.:  7.896   Class :character   Class :character  
    ##  Median : 14.454   Mode  :character   Mode  :character  
    ##  Mean   : 33.295                                        
    ##  3rd Qu.: 31.275                                        
    ##  Max.   :512.329                                        
    ##  NA's   :1                                              
    ##      boat                body        home.dest        
    ##  Length:1309        Min.   :  1.0   Length:1309       
    ##  Class :character   1st Qu.: 72.0   Class :character  
    ##  Mode  :character   Median :155.0   Mode  :character  
    ##                     Mean   :160.8                     
    ##                     3rd Qu.:256.0                     
    ##                     Max.   :328.0                     
    ##                     NA's   :1188

1: Port of embarkation The embarked column has some missing values,
which are known to correspond to passengers who actually embarked at
Southampton. Find the missing values and replace them with S. (Caution:
Sometimes a missing value might be read into R as a blank or empty
string.)

    titanic_data$embarked[which(titanic_data$embarked == "")] = "S"

2 : Age You’ll notice that a lot of the values in the Age column are
missing. While there are many ways to fill these missing values, using
the mean or median of the rest of the values is quite common in such
cases.

Calculate the mean of the Age column and use that value to populate the
missing values

    avg_age <- mean(titanic_data$age, na.rm = TRUE)
    titanic_data <- titanic_data %>% replace_na(list(age = round(avg_age)))

Think about other ways you could have populated the missing values in
the age column. Why would you pick any of those over the mean (or not)?

Calculating the mean is the best way to fill the missing values.

3: Lifeboat You’re interested in looking at the distribution of
passengers in different lifeboats, but as we know, many passengers did
not make it to a boat :-( This means that there are a lot of missing
values in the boat column. Fill these empty slots with a dummy value
e.g. the string 'None' or 'NA'

    titanic_data$boat[which(titanic_data$boat == "" | is.na(titanic_data$boat))] = "None"

4: Cabin You notice that many passengers don’t have a cabin number
associated with them.

Does it make sense to fill missing cabin numbers with a value? - Yes

What does a missing value here mean? - No cabin was given to the
passengers

You have a hunch that the fact that the cabin number is missing might be
a useful indicator of survival. Create a new column has\_cabin\_number
which has 1 if there is a cabin number, and 0 otherwise.

    titanic_data <- titanic_data %>% 
      mutate(has_cabin_number = ifelse(grepl("^$", cabin), 0, 1))
