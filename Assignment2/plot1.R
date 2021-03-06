


setwd("G:/Coursera/exploratoryDataAnalysis/Assignment2")

#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "Assignment 2 data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)
str(SCC)

byYear <- with(NEI, tapply(Emissions, year, sum))

png("plot1.png")
plot(names(byYear), byYear / 1000000, 
     xlab = "Year",
     ylab = "Total PM2.5 Emissions (Millions of Tons)",
     main = "Fine particulate matter by year, USA")
model <- lm((byYear / 1000000) ~ as.numeric(names(byYear)))
abline(model, col = "blue")
dev.off()



