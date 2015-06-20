setwd("C:/Users/David/Desktop/Data Science/Exploratory Data Analysis/EDA Project 2")
library(dplyr)
library(data.table)
library(lubridate)
library(plyr)
library(ggplot2)

## 6. Compare emissions from motor vehicle sources in 
# Baltimore City with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in 
# motor vehicle emissions?

## This read will take a few seconds. Be patient!
NEI <- data.table(readRDS("./data/summarySCC_PM25.rds"))
SCC <- data.table(readRDS("./data/Source_Classification_Code.rds"))

#select only Baltimore City & Los Angeles County, CA rows
NEI <- NEI %>% filter(fips == "24510" | fips == "06037")

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

#convert the fips factors to geographic names
motordata$fips <- factor(motordata$fips, labels = 
                  c("Los Angeles Cnty, CA",
                    "Baltimore City, MD")                  )

motorsumm <- ddply(motordata, c("fips", "year", "EI.Sector"),
           summarise, Total_Pollutant = sum(Emissions) )

with(motorsumm, { 
      qplot(year, Total_Pollutant,
            data = motorsumm,
            color=EI.Sector,
#            color = fips,
            facets = fips ~ .,
            main="Baltimore City vs. LA County, CA Motor Vehicle Emissions",
            geom=c("point", "line"))})
#           geom=c("line","smooth"), method="lm", formula=y~x)})

dev.copy(png, file="./output/plot6.png")
dev.off()
      
     
############################################################################
#    the end
############################################################################

dateCompleted <- date()
dateCompleted

