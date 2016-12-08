
#load datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Prepare data
require(dplyr)
Totalem <- NEI %>%
  select(Emissions, year) %>%
  group_by(year) %>%
  summarise(num.types = n(), emissions = sum(Emissions))


#set up png output
png("plot1.png",width=480,height=480)

#plot data
barplot(
  (Totalem$emissions), names.arg=Totalem$year, xlab="Year", ylab="PM2.5 Emissions (in Tons)",
  main="All Emissions in the U.S. by Year")

#close png output
dev.off()