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


#Prepare data, get coal
coalist <- SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),] #dataframe with coal-related emmissions

#merge the dataframes
mrg <- merge(NEI, coalist, by='SCC')

#Get the sum of emissions by year.
summed <- mrg %>%
  select(Emissions, year) %>%
  group_by(year) %>%
  summarise(num.types = n(), emissions = sum(Emissions))


#set up png output
png("plot4.png",width=480,height=480)

#make ggplot
p4<- ggplot(data=summed, aes(as.factor(year), y=emissions)) + 
  geom_bar(stat="identity") + 
  ggtitle("Total Coal-Related Emissions \n by Year") + 
  ylab("Emissions") + theme_minimal() + guides(fill=FALSE) + xlab("Year") + my.axis.font
p4
dev.off()