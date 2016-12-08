require(ggplot2)
require(dplyr)
#Set my font size
my.axis.font<-theme(axis.title.x = element_text(size=18), axis.title.y = element_text(size=18),
                    axis.text.x = element_text(size=18), axis.text.y = element_text(size=18), 
                    plot.title=element_text(size=18,face="bold"),
                    legend.title=element_text(size=14),legend.text=element_text(size=14))

#load datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Prepare data, get motor vehicles for Baltimore
baltem <- NEI %>%
  filter(fips=="24510" | fips == '06037') %>%
  select(Emissions, year,"city" = fips) %>%
  group_by(year,city) %>%
  summarise(num.types = n(), emissions = sum(Emissions))

#set up png output
png("plot6.png",width=480,height=480)

#make ggplot
p6<- ggplot(data=baltem, aes(as.factor(year), y=emissions, fill=as.factor(city))) + 
  geom_bar(stat="identity", position = "dodge") + 
  ggtitle("Motor Vehicle-Related \n Emissions by Year \n and City") + 
  ylab("Emissions") + theme_minimal() + xlab("Year") + my.axis.font
p6
dev.off()
