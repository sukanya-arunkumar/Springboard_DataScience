**Data Wrangling on Dallas Crime data**
=======================================

We use the read.delim() function to read the crime data and store it in
a dataframe. We can either read the data directly from the URL or
download and read it from the file. Here, we are using the second
approach to read the data in R.

We use the read.delim() function to read the crime data and store it in
a dataframe. We can either read the data directly from the URL or
download and read it from the file. Here, we are using the second
approach to read the data in R.

    library(dplyr)
    library(tidyr)
    library(lubridate)
    library(kableExtra)

    crimedata <- read.delim(input_file, header = TRUE,sep = "\t", check.names = FALSE, stringsAsFactors = FALSE)

Now that we have read the data, let us understand the data, its fields
and its types. str() function displays the structure of the data in a
compact way.

    str(crimedata)

    ## 'data.frame':    628964 obs. of  100 variables:
    ##  $ Incident Number w/year                   : chr  "196700-2018" "248560-2018" "080509-2018" "081335-2018" ...
    ##  $ Year of Incident                         : int  2018 2018 2018 2018 2018 2018 2018 2018 2018 2018 ...
    ##  $ Service Number ID                        : chr  "196700-2018-01" "248560-2018-01" "080509-2018-01" "081335-2018-01" ...
    ##  $ Watch                                    : int  1 3 2 2 3 2 3 1 3 2 ...
    ##  $ Call (911) Problem                       : chr  "58 - ROUTINE INVESTIGATION" "41/20 - ROBBERY - IN PROGRESS" "58 - ROUTINE INVESTIGATION" "58 - ROUTINE INVESTIGATION" ...
    ##  $ Type of Incident                         : chr  "LOST PROPERTY (NO OFFENSE)" "FOUND PROPERTY (NO OFFENSE)" "INJURED PERSON- PUBLIC PROPERTY (OTHER THAN FIREARM) (NO OFFENSE)" "LOST PROPERTY (NO OFFENSE)" ...
    ##  $ Type  Location                           : chr  "Single Family Residence - Occupied" "Highway, Street, Alley ETC" "Airport - All Others" "Hotel/Motel/ETC" ...
    ##  $ Type of Property                         : chr  "N/A" "N/A" "N/A" "N/A" ...
    ##  $ Incident Address                         : chr  "133 LAGUNA DR" "933 SIX FLAS AVE" "10701 LAMBERT INTERNATIONAL BLDV." "200 MAIN ST" ...
    ##  $ Apartment Number                         : chr  "" "" "" "" ...
    ##  $ Reporting Area                           : int  4404 4074 NA 2123 NA 2123 4290 8811 2005 NA ...
    ##  $ Beat                                     : int  623 424 122 111 621 111 454 436 146 229 ...
    ##  $ Division                                 : chr  "NORTH CENTRAL" "SOUTHWEST" "CENTRAL" "CENTRAL" ...
    ##  $ Sector                                   : int  620 420 120 110 620 110 450 430 140 220 ...
    ##  $ Council District                         : chr  "" "" "" "9" ...
    ##  $ Target Area Action Grids                 : chr  "" "" "" "" ...
    ##  $ Community                                : chr  "" "" "" "" ...
    ##  $ Date1 of Occurrence                      : chr  "09/03/2018" "11/16/2018" "04/17/2018" "04/15/2018" ...
    ##  $ Year1 of Occurrence                      : int  2018 2018 2018 2018 2018 2018 2018 2018 2018 2018 ...
    ##  $ Month1 of Occurence                      : chr  "September" "November" "April" "April" ...
    ##  $ Day1 of the Week                         : chr  "Mon" "Fri" "Tue" "Sun" ...
    ##  $ Time1 of Occurrence                      : chr  "14:00" "20:18" "09:00" "12:00" ...
    ##  $ Day1 of the Year                         : int  246 320 107 105 61 256 110 193 152 89 ...
    ##  $ Date2 of Occurrence                      : chr  "09/04/2018" "11/16/2018" "04/17/2018" "04/15/2018" ...
    ##  $ Year2 of Occurrence                      : int  2018 2018 2018 2018 2018 2018 2018 2018 2018 2018 ...
    ##  $ Month2 of Occurence                      : chr  "September" "November" "April" "April" ...
    ##  $ Day2 of the Week                         : chr  "Tue" "Fri" "Tue" "Sun" ...
    ##  $ Time2 of Occurrence                      : chr  "13:00" "20:18" "09:01" "12:00" ...
    ##  $ Day2 of the Year                         : int  247 320 107 105 66 282 110 193 181 89 ...
    ##  $ Date of Report                           : chr  "09/04/2018 06:19:00 PM" "11/16/2018 08:19:00 PM" "04/17/2018 10:15:00 AM" "04/17/2018 10:24:00 AM" ...
    ##  $ Date incident created                    : chr  "09/04/2018 06:22:55 PM" "11/16/2018 11:44:33 PM" "04/17/2018 10:25:02 AM" "04/18/2018 10:25:12 AM" ...
    ##  $ Offense Entered Year                     : int  2018 2018 2018 2018 2018 2018 2018 2018 2018 2018 ...
    ##  $ Offense Entered Month                    : chr  "September" "November" "April" "April" ...
    ##  $ Offense Entered Day of the Week          : chr  "Tue" "Fri" "Tue" "Wed" ...
    ##  $ Offense Entered Time                     : chr  "18:22" "23:44" "10:25" "10:25" ...
    ##  $ Offense Entered  Date/Time               : int  247 320 107 108 66 283 132 193 198 263 ...
    ##  $ CFS Number                               : chr  "18-1617276" "18-2086439" "18-0668631" "18-0676330" ...
    ##  $ Call Received Date Time                  : chr  "09/04/2018 06:19:05 PM" "11/16/2018 08:18:25 PM" "04/17/2018 06:00:49 AM" "04/18/2018 10:24:19 AM" ...
    ##  $ Call Date Time                           : chr  "09/04/2018 06:19:05 PM" "11/16/2018 08:18:25 PM" "04/17/2018 06:00:49 AM" "04/18/2018 10:24:19 AM" ...
    ##  $ Call Cleared Date Time                   : chr  "09/04/2018 07:37:30 PM" "11/16/2018 11:59:18 PM" "04/17/2018 01:40:53 PM" "04/18/2018 10:24:34 AM" ...
    ##  $ Call Dispatch Date Time                  : chr  "09/04/2018 06:19:05 PM" "11/16/2018 08:22:35 PM" "04/17/2018 06:00:51 AM" "04/18/2018 10:24:19 AM" ...
    ##  $ Special Report (Pre-RMS)                 : chr  "" "" "" "" ...
    ##  $ Person Involvement Type                  : chr  "Victim" "Victim" "Victim" "Victim" ...
    ##  $ Victim Type                              : chr  "Individual" "Society/Public" "Individual" "Individual" ...
    ##  $ Victim Name                              : chr  "LIN, HUAN" "CITY OF DALLAS" "ODEN, RUSSELL, DEAN" "NEIGHBOR, BENJAMIN, JOSEPH" ...
    ##  $ Victim Race                              : chr  "Asian" "" "White" "White" ...
    ##  $ Victim Ethnicity                         : chr  "Non-Hispanic or Latino" "" "Non-Hispanic or Latino" "Non-Hispanic or Latino" ...
    ##  $ Victim Gender                            : chr  "Female" "" "Male" "Male" ...
    ##  $ Victim Age                               : int  25 NA 82 31 NA 56 34 NA 58 NA ...
    ##  $ Victim Age at Offense                    : int  25 NA 82 31 NA 56 34 NA 58 NA ...
    ##  $ Victim Home Address                      : chr  "133 LAGUNA DR" "725 N JIM MILLER RD" "5SCHOOLHOUSE CT" "2660 N HASKELL AVE" ...
    ##  $ Victim Apartment                         : chr  "" "" "" "1160" ...
    ##  $ Victim Zip Code                          : chr  "75252" "75217" "63368" "75204" ...
    ##  $ Victim City                              : chr  "DALLAS" "DALLAS" "O FALLON" "DALLAS" ...
    ##  $ Victim State                             : chr  "TX" "TX" "MO" "TX" ...
    ##  $ Victim Business Name                     : chr  "" "" "" "" ...
    ##  $ Victim Business Address                  : chr  "" "" "" "" ...
    ##  $ Victim Business Phone                    : chr  "" "" "" "" ...
    ##  $ Responding Officer #1  Badge No          : chr  "9949" "10987" "5796" "7881" ...
    ##  $ Responding Officer #1  Name              : chr  "MACIAS,OSCAR,IVAN" "KIM,DANIEL,K" "HERNANDEZ JR,BENITO,F" "CONWAY,MICHAEL,SHANE" ...
    ##  $ Responding Officer #2 Badge No           : chr  "" "10983" "" "" ...
    ##  $ Responding Officer #2  Name              : chr  "" "RAMIREZ,DANIEL" "" "" ...
    ##  $ Reporting Officer Badge No               : chr  "9949" "10987" "5796" "7881" ...
    ##  $ Assisting Officer Badge No               : chr  "" "" "" "" ...
    ##  $ Reviewing Officer Badge No               : chr  "77397" "118918" "105273" "106845" ...
    ##  $ Element Number Assigned                  : chr  "C691" "C325" "S324" "U155" ...
    ##  $ Investigating Unit 1                     : chr  "" "" "" "" ...
    ##  $ Investigating Unit 2                     : chr  "" "" "" "" ...
    ##  $ Offense Status                           : chr  "Suspended" "Suspended" "Suspended" "Suspended" ...
    ##  $ UCR Disposition                          : chr  "Suspended" "Suspended" "Suspended" "Suspended" ...
    ##  $ Victim Injury Description                : chr  "" "" "" "" ...
    ##  $ Victim Condition                         : chr  "" "" "" "" ...
    ##  $ Modus Operandi (MO)                      : chr  "LOST PASSPORT" "ROS FOUND CRACK COCAINE IN A TRUCK" "WHILE ON PLANE IN MO. VICTIM HIT FRONT OF FOREHEAD THEN BACK OF H" "LOST PROPERTY" ...
    ##  $ Family Offense                           : chr  "false" "false" "false" "false" ...
    ##  $ Hate Crime                               : chr  "" "" "" "" ...
    ##  $ Hate Crime Description                   : chr  "None" "None" "None" "None" ...
    ##  $ Weapon Used                              : chr  "" "" "" "" ...
    ##  $ Gang Related Offense                     : chr  "" "" "" "" ...
    ##  $ Victim Package                           : logi  NA NA NA NA NA NA ...
    ##  $ Drug Related Istevencident               : chr  "No" "Yes" "No" "No" ...
    ##  $ RMS Code                                 : chr  "NA-99999999-X1" "NA-99999999-X3" "NA-99999999-W1" "NA-99999999-X1" ...
    ##  $ Criminal Justice Information Service Code: int  99999999 99999999 99999999 99999999 99999999 99999999 99999999 99999999 99999999 99999999 ...
    ##  $ Penal Code                               : chr  "No Offense" "No Offense" "UCR" "No Offense" ...
    ##  $ UCR Offense Name                         : chr  "" "" "INJURED PUBLIC" "LOST" ...
    ##  $ UCR Offense Description                  : chr  "" "" "ACCIDENTAL INJURY" "LOST PROPERTY" ...
    ##  $ UCR Code                                 : int  NA NA 3300 4200 4300 NA 4200 NA NA NA ...
    ##  $ Offense Type                             : chr  "" "" "NOT CODED" "NOT CODED" ...
    ##  $ NIBRS Crime                              : chr  "MISCELLANEOUS" "MISCELLANEOUS" "MISCELLANEOUS" "MISCELLANEOUS" ...
    ##  $ NIBRS Crime Category                     : chr  "MISCELLANEOUS" "MISCELLANEOUS" "MISCELLANEOUS" "MISCELLANEOUS" ...
    ##  $ NIBRS Crime Against                      : chr  "MISCELLANEOUS" "MISCELLANEOUS" "MISCELLANEOUS" "MISCELLANEOUS" ...
    ##  $ NIBRS Code                               : chr  "999" "999" "999" "999" ...
    ##  $ NIBRS Group                              : chr  "D" "D" "D" "D" ...
    ##  $ NIBRS Type                               : chr  "Not Coded" "Not Coded" "Not Coded" "Not Coded" ...
    ##  $ Update Date                              : chr  "2018-09-06 09:27:31.0000000" "2018-11-17 23:20:26.0000000" "2018-06-11 10:03:26.0000000" "2018-06-11 10:03:27.0000000" ...
    ##  $ X Coordinate                             : num  NA NA NA 2541289 NA ...
    ##  $ Y Cordinate                              : num  NA NA NA 7020042 NA ...
    ##  $ Zip Code                                 : int  75252 75208 63145 75040 75252 75216 75224 75249 75204 75043 ...
    ##  $ City                                     : chr  "DALLAS" "ARLINGTON" "STLOUIS" "GARLAND" ...
    ##  $ State                                    : chr  "TX" "TX" "MO" "TX" ...
    ##   [list output truncated]

The summary() function provides the detailed summary of data.

Looking at the summary of data, we understand that there is one
observation for each crime incident in the data frame. We have
`{r echo = FALSE} nrow(crimedata)` (rows) of 100 variables (columns)
where each row is a crime incident reported to the Dallas Police
Department. For the ease of data analysis, we select only the fields
that are neccessary.

    crimedata <- crimedata %>% select(`Incident Number w/year`,`Year of Incident`,`Type of Incident`,Beat,Division, `Type of Property`,`Date1 of Occurrence`,`Month1 of Occurence`,`Time1 of Occurrence`,`Day1 of the Week`,`Day1 of the Year`,`Victim Age`,`Victim Gender`, `Offense Status`, `UCR Offense Name`, `Victim Condition`, `Weapon Used`)

Now with the selected fields, we can start cleaning the data and make it
ready for analysis.

-   Incident Number should be unique

Each incident has a unique identifier associated with it which is stored
in the variable `Incident number w/ year`. However we have some
instances where two or more rows have the same identifier. These
duplicated instances should be removed. We use the duplicated() function
to remove the duplicates.

    crimedata <- crimedata[!duplicated(crimedata$`Incident Number w/year`), ]

-   Date of Occurrence should be between June 2014 and 2019-11-26

Date of Occurrence is a field that stores the date when the incident was
reported. Hence it should be of type *Date*. The values should be from
June 2014 to 2019-11-26.

    crimedata$`Date1 of Occurrence` <- as.Date(crimedata$`Date1 of Occurrence`, format = "%m/%d/%Y")
    crimedata <- crimedata %>% filter(between(`Date1 of Occurrence`, as.Date("2014-06-01"), Sys.Date()))

-   Year of Incident, Month of Occurrence, Day of the Week, Day of the
    Year should be derived from `Date of Occurrence`

It makes much sense to have the Year, Month, Day of week and Day of year
values to be derived from the fields `Date of Occurrence`. This can be
easily done with the *lubridate* package.

    crimedata$`Year of Incident` <- with(crimedata, ifelse(`Year of Incident` == year(`Date1 of Occurrence`), `Year of Incident` , year(`Date1 of Occurrence`) ))
    crimedata$`Month1 of Occurence` <- with(crimedata, ifelse(`Month1 of Occurence` == month(`Date1 of Occurrence`), `Month1 of Occurence`, month(`Date1 of Occurrence`)))
    crimedata$`Day1 of the Year` <- with(crimedata, ifelse(`Day1 of the Year` == yday(`Date1 of Occurrence`), `Day1 of the Year`, yday(`Date1 of Occurrence`)))
    crimedata$`Day1 of the Week` <- with(crimedata, ifelse(`Day1 of the Week` == wday(`Date1 of Occurrence`), `Day1 of the Week`, wday(`Date1 of Occurrence`)))

-   Victim Age - Reset values greater than 125 to 125

<!-- -->

    crimedata$`Victim Age`[crimedata$`Victim Age` > 125 ] = 125

-   Victim Age cannot be a negative value.

<!-- -->

    crimedata$`Victim Age` <- ifelse(crimedata$`Victim Age`< 0 , abs(crimedata$`Victim Age`) , crimedata$`Victim Age`)

The variable `Division` tells us in which part of the Dallas city the
crime incident took place. It is categorized into 7 divisions - CENTRAL,
NORTHEAST, SOUTH CENTRAL, SOUTHWEST, NORTH CENTRAL, NORTHWEST,
SOUTHEAST. Therefore, it has to be of type *Factor*

    unique(crimedata$Division)

    ##  [1] "NORTH CENTRAL" "SOUTHWEST"     "CENTRAL"       "NORTHEAST"    
    ##  [5] "NORTHWEST"     "SOUTHEAST"     "SOUTH CENTRAL" ""             
    ##  [9] "SouthEast"     "NorthEast"     "Central"       "North Central"
    ## [13] "SouthWest"     "South Central" "NorthWest"

It's clear that the values here are not unique, hence converting them
all to Upper case help make the analysis easy.

-   Division - Change all the values to Upper case

<!-- -->

    tmp <- crimedata %>% mutate(new_division = toupper(Division))
    crimedata$Division <- tmp$new_division
    crimedata$Division <- as.factor(crimedata$Division)

In order to find out how the crime rate trends throughout the year, we
create a new varaiable named `Season` based on the `Month of Occurence`.
It takes the values - *Spring*, *Summer*, *Fall*, *Winter* and is of
type *Factor*.

-   Find the Season of the Year i.e., Spring/Summer/Fall/Winter

<!-- -->

    crimedata <- crimedata %>% mutate(Season = ifelse(`Month1 of Occurence` %in% c(3,4,5), "Spring", 
                                         ifelse(`Month1 of Occurence`%in% c(6,7,8), "Summer",
                                               ifelse(`Month1 of Occurence` %in% c(9,10,11), "Fall",
                                                      ifelse(`Month1 of Occurence` %in% c(12,1,2), "Winter", NA)))))
    crimedata$Season <- as.factor(crimedata$Season)

-   Columns - Victim Gender, Victim Condition, Offense Status should of
    type *Factor*

<!-- -->

    crimedata$`Victim Gender` <- as.factor(crimedata$`Victim Gender`)
    crimedata$`Victim Condition` <- as.factor(crimedata$`Victim Condition`)
    crimedata$`Offense Status` <- as.factor(crimedata$`Offense Status`)

We can also try to find out the time of day most crimes tend to happen.
For this, we extract the hour of the day from the `Time of Occurrence`
variable.

-   Extract the hour of the day when the crime took place.

<!-- -->

    crimedata <- crimedata %>% mutate(`Hour of the Day` = sub(":.*", "",`Time1 of Occurrence`))

Variable `Type of Property` stores the target item of the incident.
Example : Motor vehicle, Apartment. It cannot take numeric values.

-   `Type of Property` cannot have numeric values

<!-- -->

    crimedata$`Type of Property` <- as.factor(crimedata$`Type of Property`)
    crimedata$`Type of Property` <- droplevels(crimedata$`Type of Property`, exclude = c(910,920,932,510))

`UCR Offense Name` stores the type of crime incident that took place.
For all the crimes that happened in the year 2019, there is no value for
`UCR Offense Name`. This can be extracted from the column
`Type of Incident`.

To do this, we create a dataframe which maps the unique
`Type of Incident` to its corresponding `UCR Offense Name` called
*offenseNames*. Based on this mapping, we find all the missing values
for the column `UCR Offense Names`.

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

    length(unique(crimedata$`UCR Offense Name`))

    ## [1] 49

There are 50 different types of crime. We can group similar categories
of crime into one and make this number smaller.

-   Group similar offense types

<!-- -->

    crimedata$`Crime Type` <- crimedata$`UCR Offense Name`

    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("ASSAULT", "AGG ASSAULT - NFV"))] = "ASSAULT"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("BURGLARY-BUSINESS", "BURGLARY-RESIDENCE"))] = "BURGLARY"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("THEFT/BMV", "THEFT/SHOPLIFT", "OTHER THEFTS", "THEFT ORG RETAIL", "EMBEZZLEMENT"))] = "THEFT"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("ROBBERY-BUSINESS", "ROBBERY-INDIVIDUAL"))] = "ROBBERY"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("ACCIDENT MV", "MOTOR VEHICLE ACCIDENT"))] = "ACCIDENT"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("NARCOTICS & DRUGS", "NARCOTICS & DRUG" ,"DRUNK & DISORDERLY", "DWI", "LIQUOR OFFENSE", "INTOXICATION MANSLAUGHTER"))] = "DRUGS"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("TRAFFIC VIOLATION", "TRAFFIC FATALITY"))] = "TRAFFIC"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("MURDER", "SUDDEN DEATH&FOUND BODIES", "VANDALISM & CRIM MISCHIEF", "WEAPONS", "ARSON", "TERRORISTIC THREAT", "KIDNAPPING", "HUMAN TRAFFICKING", "OFFENSE AGAINST CHILD", "ORANIZED CRIME"))] = "VIOLENCE"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("DISORDERLY CONDUCT" ,"CRIMINAL TRESPASS", "EVADING", "RESIST ARREST", "FAIL TO ID", "GAMBLING", "ESCAPE", "FRAUD", "UUMV", "FORGE & COUNTERFEIT"))] = "NONVIOLENCE"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("NOT CODED", "LOST", "ANIMAL BITE", "OTHERS", "FOUND", "INJURED FIREARM", "INJURED HOME", "INJURED OCCUPA", "INJURED PUBLIC"))] = "OTHERS"
    crimedata$`Crime Type` <- as.factor(crimedata$`Crime Type`)

Similarly, let us group all the similar weapon categories and store it
as *Factor*

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

### Write the cleaned dataset to a file.

write.csv(crimedata, output\_file, row.names = FALSE)
