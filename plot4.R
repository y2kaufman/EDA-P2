setwd("C:/Users/David/Desktop/Data Science/Exploratory Data Analysis/EDA Project 2")
library(plyr)
library(dplyr)
library(data.table)
#library(lubridate)
library(ggplot2)
library(grid)
library(gridExtra)

## Across the United States, how have emissions 
## from coal combustion-related sources changed from 1999-2008?

## This read will take a few seconds. Be patient!
NEI <- data.table(readRDS("./data/summarySCC_PM25.rds"))
SCC <- data.table(readRDS("./data/Source_Classification_Code.rds"))

nei.scc <- join(NEI,SCC, by = "SCC")

#subset data of coal related sources
coaldata <- nei.scc[grep("coal", x = nei.scc$Short.Name, 
                         value = F, ignore.case=T)]

#subset data of coal & combustion related sources
coalcombdata <- coaldata[grep("comb", x = coaldata$Short.Name, 
                              value = F,ignore.case=T)]

coalcombmean <- ddply(coalcombdata, c("Pollutant", "year", "type"),
                      summarise,
                      Mean_Pollutant = mean(Emissions)          )

coalcombsumm <- ddply(coalcombdata, c("Pollutant", "year", "type"),
                      summarise,
                      Total_Pollutant = sum(Emissions)          )

p1 <- ggplot(coalcombmean, aes(x=year, y=Mean_Pollutant, color = type)) +
             geom_point(alpha = 0.3) +
             geom_line() +
             labs(x="Year", y = "Mean Pollutant (tons)") +
             ggtitle("Average Coal Cumbustion by Type")

p2 <- ggplot(coalcombsumm, aes(x=year, y=Total_Pollutant, color = type)) +
             geom_point(alpha = 0.3) +
             geom_line() +
             labs(x="Year", y = "Total Pollutant (tons)") +
             ggtitle("Total Coal Cumbustion by Type")

grid.arrange(p1, p2, ncol = 1, main = "US PM25 Coal Cumbustion Trends 1999-2008")

dev.copy(png, file="./output/plot4.png")
dev.off()

dateCompleted <- date()
dateCompleted

############################################################################
#    the end
############################################################################
