setwd("C:/Users/David/Desktop/Data Science/Exploratory Data Analysis/EDA Project 2")
library(dplyr)
library(data.table)
library(lubridate)
library(plyr)
library(ggplot2)

## 5. How have emissions from motor vehicle sources 
## changed from 1999-2008 in Baltimore City?

## This read will take a few seconds. Be patient!
NEI <- data.table(readRDS("./data/summarySCC_PM25.rds"))
SCC <- data.table(readRDS("./data/Source_Classification_Code.rds"))

#select only Baltimore City rows
NEI <- NEI %>% filter(fips == "24510")

nei.scc <- join(NEI,SCC, by = "SCC")

## setkey(nei.scc, Short.Name)

#subset data of motor vehicle related sources
motordata <- nei.scc[grep("highway", x = nei.scc$Short.Name, 
                         value = F, ignore.case=T)]

motorsumm <- ddply(motordata, c("EI.Sector", "year"),
           summarise,
           Total_Pollutant = sum(Emissions)          )

with(motorsumm, { 
#      windows(10,5)
      qplot(year, Total_Pollutant,
            data = motorsumm,
            color=EI.Sector,
            main="Motor Vehicle Emissions Across all Sectors in Baltimore City",
            #           facets = year ~ .,
            geom=c("point",  "line"))})
#           geom=c("line","smooth"), method="lm", formula=y~x)})

dev.copy(png, file="./output/plot5.png")
dev.off()
# plot to png file
with(motorsumm, {
      png(file="./output/plot5b.png")
      qplot(year, Total_Pollutant,
#           width = 1960,
#           height = 980,
            data = motorsumm,
            color=EI.Sector,
            main="Motor Vehicle Emissions Across all Sectors in Baltimore City",
            geom=c("point",  "line"))})

      dev.off()
      
     
############################################################################
#    the end
############################################################################

dateCompleted <- date()
dateCompleted

