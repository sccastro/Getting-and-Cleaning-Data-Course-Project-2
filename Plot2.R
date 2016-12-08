#load datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Prepare data
require(dplyr)
baltem <- NEI %>%
  filter(fips=="24510") %>%
  select(Emissions, year) %>%
  group_by(year) %>%
  summarise(num.types = n(), emissions = sum(Emissions))


#set up png output
png("plot2.png",width=480,height=480)

#plot data
barplot(
  (baltem$emissions), names.arg=baltem$year, xlab="Year", ylab="PM2.5 Emissions (in Tons)",
  main="All Emissions in Baltimore City by Year")

#close png output
dev.off()