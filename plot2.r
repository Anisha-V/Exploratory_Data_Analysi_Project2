if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

subsetNEI  <- NEI[NEI$fips=="24510", ]

aggrTotByYear <- aggregate(Emissions ~ year, subsetNEI, sum)
barplot (height=aggrTotByYear$Emissions, names.arg=aggrTotByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'))
dev.copy(png,file ='plot2.png')
         
         dev.off()
##It has not consistently decreased from 1999 to 2008. However, it is lower in 2008 than 1999.