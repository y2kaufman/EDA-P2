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

#subset data of motor vehicle related sources by pulling short names
#containing "highway". this was based on visual inspection of the data
motordata <- nei.scc[grep("highway", x = nei.scc$Short.Name, 
                         value = F, ignore.case=T)]

#rename the EI.Sector factors to keep the legend small
motordata$EI.Sector <- factor(motordata$EI.Sector, labels = 
                  c("Diesl Equip",
                    "Gas Equip",
                    "Other Equip",
                    "Diesl Hvy Duty",
                    "Diesl Lt Duty",
                    "Gas Hvy Duty",
                    "Gas Lt Duty")                  )

motorsumm <- ddply(motordata, c("EI.Sector", "year"),
           summarise, Total_Pollutant = sum(Emissions) )

with(motorsumm, { 
      qplot(year, Total_Pollutant,
            data = motorsumm,
            color=EI.Sector,
            main="Baltimore City Motor Vehicle Emissions Across all Sectors",
            geom=c("point", "line"))})
#           geom=c("line","smooth"), method="lm", formula=y~x)})

dev.copy(png, file="./output/plot5.png")
dev.off()
      
     
############################################################################
#    the end
############################################################################

dateCompleted <- date()
dateCompleted

