


setwd("G:/Coursera/exploratoryDataAnalysis/Assignment2")
library(ggplot2)
library(plyr)

#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "Assignment 2 data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)
str(SCC)

summary(SCC$SCC.Level.One)
unique(SCC$SCC.Level.One[grepl("Combustion", SCC$SCC.Level.One)])
unique(SCC$SCC.Level.Three[grepl("Coal", SCC$SCC.Level.Three)])


coalSources <- SCC[grepl("Combustion", SCC$SCC.Level.One) & 
                        grepl("Coal", SCC$SCC.Level.Three), ]

coalSourceEmissions <- NEI[NEI$SCC %in% coalSources$SCC, ]

coalSummary <- with(coalSourceEmissions, aggregate(Emissions, list(year), sum))
colnames(coalSummary) <- c("year", "TotalEmissions")

g <- ggplot(coalSummary, aes(year, TotalEmissions))

png("plot4.png")
g + geom_line(size = 0.5) + xlab("Year") + geom_point() + 
  ylab("Total PM2.5 Emissions (Tons)") + 
  labs(title = "Fine particulate matter from Coal combustion sources by year")
dev.off()
