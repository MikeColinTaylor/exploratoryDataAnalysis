


setwd("G:/Coursera/exploratoryDataAnalysis/Assignment2")
library(ggplot2)
library(plyr)

#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "Assignment 2 data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)
str(SCC)

baltimore <- subset(NEI, NEI$fips == "24510")

summary <- with(baltimore, aggregate(Emissions, list(year, type), sum))
colnames(summary) <- c("year", "type", "TotalEmissions")

g <- ggplot(summary, aes(year, TotalEmissions, colour = type))

png("plot3.png")
g + geom_line(size = 1) + xlab("Year") + 
  ylab("Total PM2.5 Emissions (Tons)") + 
  labs(title = "Fine particulate matter by year, Baltimore")
dev.off()
