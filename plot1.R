setwd("C:/Users/David/Desktop/Data Science/Exploratory Data Analysis/EDA Project 2")

## Have total emissions from PM2.5 decreased from 1999 to 2008?  
## Make a plot showing the total PM2.5 emission from all 
## sources for each year 1999, 2002, 2005, and 2008.

## This read will take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

library(plyr)

neisumm <- ddply(NEI, c("Pollutant", "year"),
           summarise, TotalPollutant = sum(Emissions))

with(neisumm, {
     windows(5,5)
     plot(year, TotalPollutant, 
                   main = "Total U.S. PM2.5 Emissions 1999-2008",
                   type = "b")})
     
dev.copy(png, file="./output/plot1.png")
dev.off()

############################################################################
#    the end
############################################################################

dateCompleted <- date()
dateCompleted

      