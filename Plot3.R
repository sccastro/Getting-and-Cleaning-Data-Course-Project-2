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


#Prepare data
baltem <- NEI %>%
  filter(fips=="24510")



#set up png output
png("plot3.png",width=480,height=480)

#make ggplot
p3 <- ggplot(baltem,aes(factor(year),Emissions,colour=factor(type))) +
  geom_bar(stat="identity") +
  theme_minimal() + guides(colour=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  xlab("year") + ylab("Total Emissions (Tons)") + 
  ggtitle("Emissions for Baltimore \n 1999-2008 \n by Source Type")
#print
p3

#close png output
dev.off()