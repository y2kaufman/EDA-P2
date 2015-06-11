setwd("C:/Users/David/Desktop/Data Science/Exploratory Data Analysis/EDA Project 2")


## Have total emissions from PM2.5 decreased in the US 
## from 1999 to 2008? Using the base plotting system, 
## make a plot showing the total PM2.5 emission from all 
## sources for each year 1999, 2002, 2005, and 2008.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
str(NEI)
summary(NEI)


library(dplyr)
library(data.table)
library(lubridate)
library(plyr)
 
#NEIfactor = transform(NEI, year = factor(year))



nei2 <- NEI %>% 
      select(Pollutant, Emissions, year) %>%
      filter(Pollutant =="PM25-PRI") %>%
      group_by(year) %>% 
      summarise(sumu = mean(Emissions))

#NEI %>% select(year) %>% distinct


sum(NEI[NEI$year=="1999", "Emissions"])  

sum(NEI[NEI$year=="2002", "Emissions"])  
sum(NEI[NEI$year=="2005", "Emissions"])  
sum(NEI[NEI$year=="2008", "Emissions"])  


write.table(NEI, "./output/NEI.txt",  row.name=FALSE)



neisumm <- ddply(NEI, c("Pollutant", "year"),
                 summarise, TotalPollutant = sum(Emissions))

with(neisumm, plot(year, TotalPollutant, type = "bar"))


      