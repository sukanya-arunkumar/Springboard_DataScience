library("dplyr")
library("tidyr")

`%!in%` = Negate(`%in%`)

input_file <- "C:/Users/JV/Desktop/R - Springboard/DallasCrimeData/Police_Incidents.tsv"
output_file <- "C:/Users/JV/Desktop/R - Springboard/DallasCrimeData/Police_Incidents_clean.csv"

## Read the CSV into a dataframe
crimedata <- read.delim(input_file, header = TRUE,sep = "\t", check.names = FALSE)

## This is for the time being
crimedata_original <- crimedata

## Understand the dataset
summary(crimedata)
str(crimedata)

## Print the column names
colnames(crimedata)

## Select only the columns that are needed for the analysis
crimedata <- crimedata %>% select(`Incident Number w/year`,`Year of Incident`,`Type of Incident`,Beat,Division, `Type of Property`,`Date1 of Occurrence`,`Month1 of Occurence`,`Time1 of Occurrence`,`Day1 of the Week`,`Day1 of the Year`,`Victim Age`,`Victim Gender`, `Offense Status`, `UCR Offense Name`, `Victim Condition`, `Weapon Used`)

## Check the columns that contains the missing values
## View(colnames(crimedata)[colSums(is.na(crimedata)) > 0])

## Year cannot be more the 2019. 
current_year <- as.integer(format(Sys.Date(), "%Y"))
crimedata$`Year of Incident`[crimedata$`Year of Incident`> current_year] = current_year

## Remove rows with `Year of Incident` 2005,2009,2010,2011,2013
crimedata <- crimedata %>% filter(`Year of Incident` %!in% c(2005, 2009, 2010, 2011, 2013))

## Age - Reset values greater than 125 to 125
crimedata$`Victim Age`[crimedata$`Victim Age` > 125 ] = 125

## Age - Replace the missing values with the mean value - NO NEED TO DO THIS.AS THIS WILL AFFECT THE MODEL
##avg_age <- mean(crimedata$`Victim Age`, na.rm = TRUE)
##crimedata$`Victim Age`[which(is.na(crimedata$`Victim Age`))] = round(avg_age)

## Age - Age cannot be a negative value. 
crimedata$`Victim Age` <- ifelse(crimedata$`Victim Age`< 0 , abs(crimedata$`Victim Age`) , crimedata$`Victim Age`)

## Weapon used - Replace the missing value with "None"
## crimedata$`Weapon Used`[which(crimedata$`Weapon Used` == "")] = "None"

## Division - Change all the values to Upper case and handle missing values
tmp <- crimedata %>% mutate(new_division = toupper(Division))
crimedata$Division <- tmp$new_division

## No need to do this??? 
## crimedata$Division[which(crimedata$Division == "")] = NA

## UCR Offense Name - Crime Category - Replace the missing value with OTHERS
##crimedata$`UCR Offense Name`[which(crimedata$`UCR Offense Name` == "")] = "OTHERS"

## Offense Status cannot have Missing value
##crimedata$`Offense Status`[which(crimedata$`Offense Status` == "")] = "Unknown"

## DAY# of the Week - Replace the missing value 
## crimedata$`Day1 of the Week`[which(crimedata$`Day1 of the Week` == "")] = "None"
## crimedata$`Day2 of the Week`[which(crimedata$`Day2 of the Week` == "")] = "None"

## Day of the Year - Handle missing values. Set Outliers. Values cannot be more than 366
crimedata$`Day1 of the Year`[which(is.na(crimedata$`Day1 of the Year`))] = 0
crimedata$`Day1 of the Year`[which(crimedata$`Day1 of the Year` > 366)] = 366

## Find the Season of the Year i.e., Summer/Winter/Fall/Spring
crimedata <- crimedata %>% mutate(Season = ifelse(`Month1 of Occurence` %in% c("March", "April", "May"), "Spring", 
                                     ifelse(`Month1 of Occurence`%in% c("June", "July", "August"), "Summer",
                                           ifelse(`Month1 of Occurence` %in% c("September", "October", "November"), "Fall",
                                                  ifelse(`Month1 of Occurence` %in% c("December", "January", "February"), "Winter", NA)))))

## Column - Incident Number w/year has both incident number and year. Remove year
crimedata <- crimedata %>% mutate(`Incident Number` = sub("-.*", "", `Incident Number w/year`))

## Now drop the column "Incident Number w/year"
crimedata <- crimedata %>% select(-`Incident Number w/year`)

## Extract the hour of the day when the crime took place.
crimedata <- crimedata %>% mutate(`Hour of the Day` = sub(":.*", "",`Time1 of Occurrence`))

## Handle the missing values for the column Type of Property
crimedata$`Type of Property`[which(crimedata$`Type of Property` == "")] = NA

## Type of Property cannot have numeric values
crimedata$`Type of Property` <- droplevels(crimedata$`Type of Property`, exclude = c(910,920,932,510))

## Write the cleaned dataset to a file.
write.csv(crimedata, output_file, row.names = FALSE)
