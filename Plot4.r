
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
#Merging the data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}
library(ggplot2)

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
# Retrieving NEIxSCC records with Short.Name (SCC) Coal
coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]

aggrTotByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)
g <- ggplot(aggrTotByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)


dev.copy(png,file="plot4.png", width=640, height=480)

dev.off()