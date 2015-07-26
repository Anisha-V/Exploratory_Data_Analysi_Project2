if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# Merging two data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
# 24510 is the code for Baltimore

subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

aggrTotByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

g <- ggplot(aggrTotByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(g)
dev.copy(png,file="plot5.png", width=840, height=480)
dev.off()
###They have significantly reduced. 