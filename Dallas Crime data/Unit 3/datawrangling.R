library("dplyr")
library("tidyr")
library("lubridate")

`%!in%` = Negate(`%in%`)

input_file <- "C:/Users/JV/Desktop/R - Springboard/DallasCrimeData/Police_Incidents.tsv"
output_file <- "C:/Users/JV/Desktop/R - Springboard/DallasCrimeData/Police_Incidents_clean.csv"

## Read the CSV into a dataframe
crimedata <- read.delim(input_file, header = TRUE,sep = "\t", check.names = FALSE, stringsAsFactors = FALSE)

## Understand the dataset
summary(crimedata)
str(crimedata)

## Print the column names
colnames(crimedata)

## Select only the columns that are needed for the analysis
crimedata <- crimedata %>% dplyr::select(`Incident Number w/year`,`Year of Incident`, `Type of Incident`, Beat, Division, `Type of Property`, `Date1 of Occurrence`,`Month1 of Occurence`,`Time1 of Occurrence`,`Day1 of the Week`,`Day1 of the Year`,`Victim Age`,`Victim Gender`, `Offense Status`, `UCR Offense Name`, `Victim Condition`, `Weapon Used`)

## Check the columns that contains the missing values
## View(colnames(crimedata)[colSums(is.na(crimedata)) > 0])

## Incident Number should be unique
## Remove all duplicate values of th column Incident Number w/year
crimedata <- crimedata[!duplicated(crimedata$`Incident Number w/year`), ]

## YEAR OF INCIDENT, MONTH OF OCCURRENCE, DAY OF WEEK, DAY OF YEAR are all derived from `DATE OF OCCURRENCE`
crimedata$`Date1 of Occurrence` <- as.Date(crimedata$`Date1 of Occurrence`, format = "%m/%d/%Y")
crimedata <- crimedata %>% filter(between(`Date1 of Occurrence`, as.Date("2014-06-01"), Sys.Date()))
crimedata$`Year of Incident` <- with(crimedata, ifelse(`Year of Incident` == year(`Date1 of Occurrence`), `Year of Incident` , year(`Date1 of Occurrence`) ))
crimedata$`Month1 of Occurence` <- with(crimedata, ifelse(`Month1 of Occurence` == month(`Date1 of Occurrence`), `Month1 of Occurence`, month(`Date1 of Occurrence`)))
crimedata$`Day1 of the Year` <- with(crimedata, ifelse(`Day1 of the Year` == yday(`Date1 of Occurrence`), `Day1 of the Year`, yday(`Date1 of Occurrence`)))
crimedata$`Day1 of the Week` <- with(crimedata, ifelse(`Day1 of the Week` == wday(`Date1 of Occurrence`), `Day1 of the Week`, wday(`Date1 of Occurrence`)))

## Age - Reset values greater than 125 to 125
crimedata$`Victim Age`[crimedata$`Victim Age` > 125 ] = 125

## Age - Age cannot be a negative value. 
crimedata$`Victim Age` <- ifelse(crimedata$`Victim Age`< 0 , abs(crimedata$`Victim Age`) , crimedata$`Victim Age`)

## Division - Change all the values to Upper case and handle missing values
tmp <- crimedata %>% mutate(new_division = toupper(Division))
crimedata$Division <- tmp$new_division
crimedata$Division <- as.factor(crimedata$Division)

## Find the Season of the Year i.e., Summer/Winter/Fall/Spring
crimedata <- crimedata %>% mutate(Season = ifelse(`Month1 of Occurence` %in% c(3,4,5), "Spring", 
                                     ifelse(`Month1 of Occurence`%in% c(6,7,8), "Summer",
                                           ifelse(`Month1 of Occurence` %in% c(9,10,11), "Fall",
                                                  ifelse(`Month1 of Occurence` %in% c(12,1,2), "Winter", NA)))))
crimedata$Season <- as.factor(crimedata$Season)

## Columns - Victim Gender, Victim Condition,Offense Status should of type Factor
crimedata$`Victim Gender` <- as.factor(crimedata$`Victim Gender`)
crimedata$`Victim Condition` <- as.factor(crimedata$`Victim Condition`)
crimedata$`Offense Status` <- as.factor(crimedata$`Offense Status`)

## Extract the hour of the day when the crime took place.
crimedata <- crimedata %>% mutate(`Hour of the Day` = sub(":.*", "",`Time1 of Occurrence`))
crimedata$`Hour of the Day` <- as.integer(crimedata$`Hour of the Day`)

## Type of Property cannot have numeric values
crimedata$`Type of Property` <- as.factor(crimedata$`Type of Property`)
crimedata$`Type of Property` <- droplevels(crimedata$`Type of Property`, exclude = c(910,920,932,510))
crimedata$`Type of Property`[crimedata$`Type of Property` %in% c("N/A", "") ] = NA

## `UCR Offense Name` for the year 2019 crime incidents are empty. `UCR Offense Name` should be derived from `Type of Incident`
temp <- crimedata[!duplicated(crimedata$`Type of Incident`), ]
offenseNames <- temp %>% dplyr::select(`Type of Incident`, `UCR Offense Name`)

offenseNames$`UCR Offense Name`[which(startsWith(offenseNames$`Type of Incident`, "ARSON"))] <- "ARSON"
offenseNames$`UCR Offense Name`[which(grepl(paste(c("^GRAFFITI", "^CRUELTY TO", "^CRIM MISCHIEF"), collapse="|"),offenseNames$`Type of Incident` ))] <- "VANDALISM & CRIM MISCHIEF"
offenseNames$`UCR Offense Name`[which(grepl(paste(c("^ASSAULT", "^DEADLY CONDUCT"), collapse="|"),offenseNames$`Type of Incident` ))] <- "ASSAULT"
offenseNames$`UCR Offense Name`[which(startsWith(offenseNames$`Type of Incident`, "BMV"))] <- "THEFT/BMV"
offenseNames$`UCR Offense Name`[which(grepl(paste(c("^CREDIT CARD", "^COMPUTER SECURITY", "^DECEPTIVE", "^FRAUD", "^THEFT OF SERVICE", "^FALSE STATEMENT", "^TAMPER W" , "^SECURE EXE", "^FAIL TO", "FALSE ALARM"), collapse="|"),offenseNames$`Type of Incident` ))] <- "FRAUD"
offenseNames$`UCR Offense Name`[which(startsWith(offenseNames$`Type of Incident`, "CRIMINAL TRESPASS"))] <- "CRIMINAL TRESPASS"
offenseNames$`UCR Offense Name`[which(grepl(paste(c("^DELIVERY", "^MAN DEL", "^POSS CONT", "^POSS MARIJUANA"), collapse="|"),offenseNames$`Type of Incident` ))] <- "NARCOTICS & DRUG"
offenseNames$`UCR Offense Name`[which(grepl(paste(c("^DISORDERLY", "^DISRUPT", "^ILLUMINA", "^ONLINE IMPRESS", "^STALKING", "^SEX OFFENDERS", "^HARASSMENT"), collapse="|"),offenseNames$`Type of Incident` ))] <- "DISORDERLY CONDUCT"
offenseNames$`UCR Offense Name`[which(startsWith(offenseNames$`Type of Incident`, "DWI"))] <- "DWI"
offenseNames$`UCR Offense Name`[which(startsWith(offenseNames$`Type of Incident`, "ESCAPE"))] <- "ESCAPE"
offenseNames$`UCR Offense Name`[which(startsWith(offenseNames$`Type of Incident`, "EVADING"))] <- "EVADING"
offenseNames$`UCR Offense Name`[which(startsWith(offenseNames$`Type of Incident`, "FORGERY"))] <- "FORGE & COUNTERFEIT"
offenseNames$`UCR Offense Name`[which(startsWith(offenseNames$`Type of Incident`, "KIDNAPPING"))] <- "KIDNAPPING"
offenseNames$`UCR Offense Name`[which(grepl(paste(c("^ILLEGAL", "^INTERFERE", "^INTERFER", "^FLEEING", "^MISAPP", "^OTHER OFFENSES", "^WARRANT"), collapse="|"),offenseNames$`Type of Incident` ))] <- "OTHERS"
offenseNames$`UCR Offense Name`[which(startsWith(offenseNames$`Type of Incident`, "TRAFFICKING"))] <- "HUMAN TRAFFICKING"
offenseNames$`UCR Offense Name`[which(startsWith(offenseNames$`Type of Incident`, "UNAUTHORIZED USE OF"))] <- "UUMV"
offenseNames$`UCR Offense Name`[which(grepl(paste(c("^UNLAWFULLY", "^UNLAWFUL", "^PROHIBITED"), collapse="|"),offenseNames$`Type of Incident` ))] <- "WEAPONS"
offenseNames$`UCR Offense Name`[which(grepl(paste(c("^VIO BOND", "^VIO PROTECT"), collapse="|"),offenseNames$`Type of Incident` ))] <- "OFFENSE AGAINST CHILD"
offenseNames$`UCR Offense Name`[which(grepl(paste(c("^TRAFFIC VIO", "^TRAF VIO"), collapse="|"),offenseNames$`Type of Incident` ))] <- "TRAFFIC VIOLATION"
offenseNames$`UCR Offense Name`[which(startsWith(offenseNames$`Type of Incident`, "TRADEMARK"))] <- "FORGE & COUNTERFEIT"
offenseNames$`UCR Offense Name`[which(startsWith(offenseNames$`Type of Incident`, "THEFT ORG"))] <- "THEFT ORG RETAIL"
offenseNames$`UCR Offense Name`[which(startsWith(offenseNames$`Type of Incident`, "TERRORISTIC THREAT"))] <- "TERRORISTIC THREAT"
offenseNames$`UCR Offense Name`[which(startsWith(offenseNames$`Type of Incident`, "RESIST ARREST"))] <- "RESIST ARREST"
offenseNames$`UCR Offense Name`[which(grepl(paste(c("^MURDER", "^MANSLAUGHTER"), collapse="|"),offenseNames$`Type of Incident` ))] <- "MURDER"
offenseNames$`UCR Offense Name`[which(grepl(paste(c("^PUBLIC INTOX", "^PURCHASE FURN"), collapse="|"),offenseNames$`Type of Incident` ))] <- "DRUNK & DISORDERLY"
offenseNames$`UCR Offense Name`[which(grepl(paste(c("^ROBBERY *OF BUSINESS"), collapse="|"),offenseNames$`Type of Incident` ))] <- "ROBBERY-BUSINESS"
offenseNames$`UCR Offense Name`[which(grepl(paste(c("^ROBBERY *OF INDIVIDUAL"), collapse="|"),offenseNames$`Type of Incident` ))] <- "ROBBERY-INDIVIDUAL"
offenseNames$`UCR Offense Name` <- with(offenseNames, ifelse(`UCR Offense Name` == "" & grepl("^THEFT", `Type of Incident`), "OTHER THEFTs" , `UCR Offense Name` ))
offenseNames$`UCR Offense Name`[which(offenseNames$`UCR Offense Name` == "")] <- "OTHERS"

crimedata$`UCR Offense Name` <- offenseNames[match(crimedata$`Type of Incident`, offenseNames$`Type of Incident`),2]

## Group similar offense types
crimedata$`Crime Type` <- crimedata$`UCR Offense Name`
crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("ASSAULT", "AGG ASSAULT - NFV"))] = "ASSAULT"
crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("BURGLARY-BUSINESS", "BURGLARY-RESIDENCE"))] = "BURGLARY"
crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("THEFT/BMV", "THEFT/SHOPLIFT", "OTHER THEFTS", "THEFT ORG RETAIL", "EMBEZZLEMENT"))] = "THEFT"
crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("ROBBERY-BUSINESS", "ROBBERY-INDIVIDUAL"))] = "ROBBERY"
crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("ACCIDENT MV", "MOTOR VEHICLE ACCIDENT"))] = "ACCIDENT"
crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("NARCOTICS & DRUGS", "NARCOTICS & DRUG","DRUNK & DISORDERLY", "DWI", "LIQUOR OFFENSE", "INTOXICATION MANSLAUGHTER"))] = "DRUGS"
crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("TRAFFIC VIOLATION", "TRAFFIC FATALITY"))] = "TRAFFIC"
crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("MURDER", "SUDDEN DEATH&FOUND BODIES", "VANDALISM & CRIM MISCHIEF", "WEAPONS", "ARSON", "TERRORISTIC THREAT", "KIDNAPPING", "HUMAN TRAFFICKING", "OFFENSE AGAINST CHILD", "ORANIZED CRIME"))] = "VIOLENCE"
crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("DISORDERLY CONDUCT" ,"CRIMINAL TRESPASS", "EVADING", "RESIST ARREST", "FAIL TO ID", "GAMBLING", "ESCAPE", "FRAUD", "UUMV", "FORGE & COUNTERFEIT"))] = "NONVIOLENCE"
crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("NOT CODED", "LOST", "ANIMAL BITE", "OTHERS", "FOUND", "INJURED FIREARM", "INJURED HOME", "INJURED OCCUPA", "INJURED PUBLIC"))] = "OTHERS"
crimedata$`Crime Type` <- as.factor(crimedata$`Crime Type`)

## Group similar weapon types
crimedata$`Weapon Type` <- ""
crimedata$`Weapon Type`[which(grepl("gun",crimedata$`Weapon Used`, ignore.case = TRUE))] <- "Gun"
crimedata$`Weapon Type`[which(crimedata$`Weapon Used` %in% c("Rifle", "Missile/Rock"))] = "Gun"
crimedata$`Weapon Type`[which(crimedata$`Weapon Used` %in% c("Hands-Feet"))] = "Hands/Feet"
crimedata$`Weapon Type`[which(crimedata$`Weapon Used` %in% c("Vehicle", "MOTOR VEHICLE"))] = "Vehicle"
crimedata$`Weapon Type`[which(crimedata$`Weapon Used` %in% c("None"))] = "No Weapons"
crimedata$`Weapon Type`[which(crimedata$`Weapon Used` %in% c("Threats"))] = "Threat"
crimedata$`Weapon Type`[which(grepl("knife",crimedata$`Weapon Used`, ignore.case = TRUE))] = "Knife"
crimedata$`Weapon Type`[which(crimedata$`Weapon Used` %in% c("Other Cutting Stabbing Inst.", "SWITCHBLADE", "AXE", "ICE PICK"))] = "Knife"
crimedata$`Weapon Type`[which(grepl("fire",crimedata$`Weapon Used`, ignore.case = TRUE))] = "Fire"
crimedata$`Weapon Type`[which(crimedata$`Weapon Used` %in% c("Explosives", "Gas/Carbon Monoxide", "Burn/Scald"))] = "Knife"
crimedata$`Weapon Type`[which(grepl("drugs",crimedata$`Weapon Used`, ignore.case = TRUE))] = "Drugs"
crimedata$`Weapon Type`[which(crimedata$`Weapon Used` %in% c("ANY WEAPON OF FORCE DEADLY DISEASE, ETC", "Omission/Neglect"))] = "Drugs"
crimedata$`Weapon Type`[which(crimedata$`Weapon Used` %in% c("Other", "Blunt", "Stangulation", "Assault", "Crowbar", "Asphixation", "BlackJack/Club", "Omission"))] <- "Others"
crimedata$`Weapon Type`[which(crimedata$`Weapon Type` == "")] <- "Others"
crimedata$`Weapon Type` <- as.factor(crimedata$`Weapon Type`)

## Write the cleaned dataset to a file.
write.csv(crimedata, output_file, row.names = FALSE)
