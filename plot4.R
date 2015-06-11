setwd("C:/Users/David/Desktop/Data Science/Exploratory Data Analysis/EDA Project 2")
library(dplyr)
library(data.table)
library(lubridate)
library(plyr)

## Across the United States, how have emissions 
## from coal combustion-related sources changed from 1999-2008?

## This read will take a few seconds. Be patient!
NEI <- data.table(readRDS("./data/summarySCC_PM25.rds"))
SCC <- data.table(readRDS("./data/Source_Classification_Code.rds"))

nei.scc <- join(NEI,SCC, by = "SCC")

#write.table(nei.scc, "./output/nei.scc.txt",  row.name=FALSE)

##############################

#subset data of coal related sources
coaldata <- nei.scc[grep("coal", x = nei.scc$Short.Name, 
                         value = F, ignore.case=T)]

#subset data of coal & combustion related sources
coalcombdata <- coaldata[grep("comb", x = coaldata$Short.Name, 
                              value = F,ignore.case=T)]



un <- unique(coalcombdata$Short.Name)

coalcombsumm <- ddply(coalcombdata, c("Pollutant", "year"),
           summarise,
           TotalPollutant = sum(Emissions)          )

#with(neisumm, plot(year, TotalPollutant, type = "b"))

############################################################################
#    the end
############################################################################

dateCompleted <- date()
dateCompleted

      