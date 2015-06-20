setwd("C:/Users/David/Desktop/Data Science/Exploratory Data Analysis/EDA Project 2")

## Of the four types of sources indicated by the type 
## (point, nonpoint, onroad, nonroad) variable, which of 
## these four sources have seen decreases in 
## emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

## This will take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")

library(dplyr)
library(ggplot2)
library(plyr)
 
neibalt <- NEI %>% filter(fips == "24510")

neisumm <- ddply(neibalt, c("type",  "year"),
                 summarise,
                 Baltimore_Pollutant = sum(Emissions))

with(neisumm, { 
     qplot(year, Baltimore_Pollutant,
           data = neisumm,
           color=type,
           ylab = "Baltimore City Pollutant (tons)",
           main="Total Emissions by Type in Baltimore",
           geom=c("line","point"))})

dev.copy(png, file="./output/plot3.png")
dev.off()

############################################################################
#    the end
############################################################################

dateCompleted <- date()
dateCompleted