


setwd("G:/Coursera/exploratoryDataAnalysis/Assignment2")

#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "Assignment 2 data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)
str(SCC)

baltimore <- subset(NEI, NEI$fips == "24510")

baltimoreByYear <- with(baltimore, tapply(Emissions, year, sum))

png("plot2.png")
plot(names(baltimoreByYear), baltimoreByYear,  
     xlab = "Year",
     ylab = "Total PM2.5 Emissions (Tons)",
     main = "Fine particulate matter by year, Baltimore")
model <- lm(baltimoreByYear ~ as.numeric(names(baltimoreByYear)))
abline(model, col = "blue")
dev.off()
