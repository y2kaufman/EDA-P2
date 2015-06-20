setwd("C:/Users/David/Desktop/Data Science/Exploratory Data Analysis/EDA Project 2")
library(dplyr)
library(data.table)
library(lubridate)
library(plyr)
library(ggplot2)

## 6. Compare emissions from motor vehicle sources in 
# Baltimore City with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

## This read will take a few seconds. Be patient!
NEI <- data.table(readRDS("./data/summarySCC_PM25.rds"))
SCC <- data.table(readRDS("./data/Source_Classification_Code.rds"))

#select only Baltimore City & Los Angeles County, CA rows
NEI <- NEI %>% filter(fips == "24510" | fips == "06037")

nei.scc <- join(NEI,SCC, by = "SCC")

#Normalize the emissions to make a better visual comparison

#Baltimore normalized
balt <-  nei.scc %>% filter(fips == "24510")
balt$Emissions <- (balt$Emissions-min(balt$Emissions))/
      (max(balt$Emissions)-min(balt$Emissions))

#Los Angeles normalized
laca <-  nei.scc %>% filter(fips == "06037")
laca$Emissions <- (laca$Emissions-min(laca$Emissions))/
      (max(laca$Emissions)-min(laca$Emissions))

#recombine Baltimore and LA
nor <- rbind(balt, laca)

#subset the normalized data of motor vehicle related sources by pulling short names
#containing "highway". this was based on visual inspection of the data

motordata <- nor[grep("highway", x = nor$Short.Name, 
                         value = F, ignore.case=T)]

#convert the fips factors to geographic names
motordata$fips <- factor(motordata$fips, labels = 
                  c("Los Angeles Cnty, CA",
                    "Baltimore City, MD")                  )

motordata$year <- factor(motordata$year)

motorsumm <- ddply(motordata, c("fips", "year"),
           summarise, Total_Pollutant = sum(Emissions) )

with(motorsumm, { 
      qplot(year, Total_Pollutant,
            data = motorsumm,
            facets = fips ~ .,
            main="Baltimore City vs. LA County, CA Motor Vehicle Emissions",
            xlab = "Year", 
            ylab = "PM2.5 Total Pollutant (Normalized)",
            geom="bar", color = year, fill = year,
            stat="identity")})

dev.copy(png, file="./output/plot6.png")
dev.off()
      
###########################################################################
#    the end
############################################################################

dateCompleted <- date()
dateCompleted