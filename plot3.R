setwd("C:/Users/David/Desktop/Data Science/Exploratory Data Analysis/EDA Project 2")

## Of the four types of sources indicated by the type 
## (point, nonpoint, onroad, nonroad) variable, which of 
## these four sources have seen decreases in 
## emissions from 1999???2008 for Baltimore City? 
## Which have seen increases in emissions from 1999???2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")

library(dplyr)
#library(data.table)
#library(lubridate)
library(ggplot2)
library(plyr)
 
neibalt <- NEI %>% filter(fips == "24510")

neisumm <- ddply(neibalt, c("type",  "year"),
                 summarise,
                 BaltPollutant = sum(Emissions))


with(neisumm, { 
#     windows(5,5)
     qplot(year, BaltPollutant,
           data = neisumm,
           color=type,
#           facets = year ~ .,
           geom="line")})


#dev.copy(png, file="./output/plot3.png")
dev.off()

############################################################################
#    the end
############################################################################

dateCompleted <- date()
dateCompleted

