setwd("C:/Users/David/Desktop/Data Science/Exploratory Data Analysis/EDA Project 2")

## Have total emissions from PM2.5 
## decreased in the Baltimore City, 
## Maryland (fips == "24510") from 1999 to 2008? Use the base 
## plotting system to make a plot answering this question.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")

library(dplyr)
#library(data.table)
#library(lubridate)
library(plyr)
 
neibalt <- NEI %>% filter(fips == "24510")

neisumm <- ddply(neibalt, c("Pollutant", "year"),
                 summarise,
                 BaltPollutant = sum(Emissions)
                )

with(neisumm, {
     windows(5,5) 
     plot(year, BaltPollutant, type = "b")})

dev.copy(png, file="./output/plot2.png")
dev.off()

############################################################################
#    the end
############################################################################

dateCompleted <- date()
dateCompleted

