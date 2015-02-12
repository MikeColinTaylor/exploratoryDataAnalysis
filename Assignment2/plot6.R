


setwd("G:/Coursera/exploratoryDataAnalysis/Assignment2")
library(ggplot2)
library(plyr)

#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "Assignment 2 data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)
str(SCC)

summary(SCC$SCC.Level.One)
unique(SCC$SCC.Level.Two[SCC$SCC.Level.One == "Mobile Sources"])
unique(SCC$SCC.Level.Two[grepl("Vehicle", SCC$SCC.Level.Two)])


vehicleSources <- SCC[grepl("Vehicle", SCC$SCC.Level.Two), ]

vehicleEmissions <- NEI[NEI$SCC %in% vehicleSources$SCC & NEI$fips %in% c("24510", "06037"), ]
vehicleEmissions$city[vehicleEmissions$fips == "24510"] <- "Baltimore"
vehicleEmissions$city[vehicleEmissions$fips == "06037"] <- "Los Angeles"


vehSummary <- with(vehicleEmissions, aggregate(Emissions, list(year, city), sum))
colnames(vehSummary) <- c("year", "city", "TotalEmissions")

g <- ggplot(vehSummary, aes(year, TotalEmissions, colour = city))

png("plot6.png")
g + geom_line(size = 0.5) + xlab("Year") + geom_point() + 
  ylab("Total PM2.5 Emissions (Tons)") + 
  labs(title = "Fine particulate matter from vehicle sources by year")
dev.off()

