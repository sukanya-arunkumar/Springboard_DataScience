## library("ggplot2")

## Can you count something interesting?
##  For a particular Division say "CENTRAL", how many crime happened over the years
crime_rate <- crimedata %>% filter(Division == "CENTRAL") %>% group_by(`Year of Incident`) %>% tally(name = "No_of_crimes")
ggplot(crime_rate, aes(x=`Year of Incident`, y = `No_of_crimes`)) + geom_line(col = "Blue", size = 1)

## Can you find some trends (high, low, increase, decrease, anomalies)?
crime_trends <- crimedata  %>% group_by(Division, `Year of Incident`) %>% tally(name = "No_of_Crimes")
ggplot(crime_trends, aes(x=`Year of Incident`, y = No_of_Crimes , color = Division, size = 0)) + geom_line(size = 1.5)

## Can you make a bar plot or a histogram?
## Number of crimes happened every year
crimes_per_year <- crimedata %>% group_by(`Year of Incident`) %>% summarize(crime = n()) 
ggplot(crimes_per_year, aes(x= `Year of Incident`,y=`crime` )) + geom_bar(stat = "identity")

## Can you compare two related quantities?
crime_rate <- crimedata %>% filter(Division == "NORTHEAST" | Division == "SOUTHEAST") %>% group_by(`Year of Incident`, Division) %>% tally(name = "No_of_crimes")
ggplot(crime_rate, aes(x=`Year of Incident`, y = `No_of_crimes`, color = Division)) + geom_point() + geom_line()


## Can you make a scatterplot?
## Which age people are most affected by BURGLARY?
victim_affected <- crimedata %>% filter(grepl("^BURGLARY", `Type of Incident`)) %>% select(`Type of Incident`,`Victim Age`)%>% group_by(`Victim Age`) %>% summarize(n = n())
victim_affected <- na.omit(victim_affected)
ggplot(victim_affected, aes(x=`Victim Age`, y = n)) + geom_point() + ylim(0,1500)

## Can you make a time-series plot?
offense_trends <- crimedata %>% group_by(`Offense Status`,`Year of Incident`) %>% summarize(count = n())
ggplot(offense_trends, aes(x=`Year of Incident`, y = count, color = `Offense Status`)) + geom_point() + geom_line()
