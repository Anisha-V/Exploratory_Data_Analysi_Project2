if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
#Merging the two data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

aggrTotByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggrTotByYearAndFips$fips[aggrTotByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggrTotByYearAndFips$fips[aggrTotByYearAndFips$fips=="06037"] <- "Los Angeles, CA"


g <- ggplot(aggrTotByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.copy(png,file="plot6.png", width=1040, height=480)
dev.off()

##for Los Angeles the emissions level in 2008 is higher than 1999 whereas for Baltimore the levels have reduced. However the absolute percentage change in the levels seems higher for Baltimore