
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

library(ggplot2)

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# 24510 is Baltimore, see plot2.R
subsetNEI  <- NEI[NEI$fips=="24510", ]

aggrTotByYearAndType <- aggregate(Emissions ~ year + type, subsetNEI, sum)
g <- ggplot(aggrTotByYearAndType, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
print(g)

dev.copy(png,file = "plot3.png", width=640, height=480)

dev.off()

###Non-point, non-road and on- road all have lower levels of PM2.5 in 2008 as compared to 1999. However Point is on a slightly higher level in 2008. 