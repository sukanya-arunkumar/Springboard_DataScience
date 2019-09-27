### **Introduction**

The Dallas Crime data is obtained from
[www.dallasopendata.com](https://www.dallasopendata.com/Public-Safety/Police-Incidents/qv6i-rri7).
There are about 100 columns and over 585K records.Each row in the data
is a crime incident reported to the Dallas Police department. The idea
is to analyse the crimes that have happened over the years and aim at
reducing them by alerting the security officials at the areas where
crime rates are higher. However, the main objective of this project is
to predict crime rates for the future years.

### **Important Fields and Information**

The dataset incluldes about 100 fields however not all of them are
required for analysis. Few of them which are relevent for the purposes
of this project are selected.

-   Incident Number with year : AN RMS generated Incident (or report)
    number with year
-   Type of Incident : Type of Incident
-   Year of Incident : Year associated with the incident number
-   Beat : Geographic area comprised of beats where incident occurred
-   Division : Geographic area comprised of census blocks where incident
    occurred (smallest police geography)
-   Type of Property : The target item… Parkinglot, Motor Vehicle
-   Date1 of Occurrence : The first date of the date occurrence of the
    incident
-   Month1 of Occurence : Month (starting) of the indent based on the
    Date of Occurrence (Date1)
-   Time1 of Occurrence : The first (starting) time of the time
    occurrence of the incident
-   Day1 of the Week : Day of the indent based on the Date of Occurrence
    (Date1)
-   Day1 of the Year : The calender number of the year 1‐365 based on
    Date1
-   Victim Gender : Victim Gender
-   Victim Age : Victim Age
-   Offense status : Status of the offense
-   UCR Offense Name : UCR Offense Name
-   Victim Condition : Victim Condition
-   Weapon Used : Weapon Used

### **Data cleaning and Wrangling**

Data cleaning is an important step in transforming the data into a form
that is ready for analysis. It invloves handling of missing values or
NAs, outliers, duplicates and checking if the data matches the column
label etc. Following are the rules that are applicable to the data in
the dataset.

-   Year of Incident - The year values should be from 2014 to 2019.
-   Type of Incident - Description about the type of incident
-   Beat - Beat number where the incident occurred
-   Division - The values in this field are converted to upper case for
    easy analysis
-   Type of Property - Description  
-   Date1 of Occurrence - The values should be in the format MM/DD/YYYY
-   Month1 of Occurence - Name of the month
-   Time1 of Occurence - Time in HH:MM format
-   Day1 of the Week - Name of the day
-   Day1 of the Year - Julian date (0-366)
-   Victim Age - Values in the range 0-125
-   Victim Gender - Value can be either Male/Female
-   Offense Status - Value can be Suspended, Clear by Arrest, Open,
    Clear by Exceptional, Arrest Closed/Cleared, Unfounded, Returned for
    Correction, CL  
-   UCR Offense Name - Crime category
-   Victim Condition - Values can be either of
    Stable/Good/Deceased/Serious/Critical
-   Weapon Used - Name of the weapon used
-   Season - One of Summer/Winter/Spring/Fall
-   Incident Number - Unique identifier for each incident
-   Hour of the Day - Values in the range 00-24
-   Crime Type - High level classification of UCR Offense Status

### **Limitations**

-   Lot of Missing values or NAs in the field `UCR Offense Name`
-   Specific locality details are not available in the dataset

### **Initial Findings**

Following observations were seen when data visualization was initially
performed on the dataset

-   Crime rates were seen higher in Summer compared to Winter
-   Most crimes occurred around midnight compared to day time
-   Weekends witnessed more crimes than weekdays
-   Crime rates across past years showed similar trends however
    beginning from second half of 2018 till date, an unusual increase in
    rates were seen
-   More than 60% of the victims were found to be in Good condition and
    about 13% were recorded as Deceased
-   Theft was determined to be the most committed crime

### **Approach to Problem solving**

Based on the initial analysis, it is appropriate to build a linear
regression model to predict the crime rates for future years. The model
can be built from sample or training data and its performance can be
measured with testing data (Cross validation technique)
