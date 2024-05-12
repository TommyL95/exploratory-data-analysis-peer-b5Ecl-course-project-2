#My connection is slow, so I will need more time to download the file. Here I added two lines of code to have a longer timeout"

getOption("timeout")
options(timeout = 600)


#The first line will download the data, so as long as there is internet connection, the code will always generate the plot

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "FNEI_data.zip")

#Let's unzip the data

unzip("FNEI_data.zip")

#Let's read the data using the code from the course
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltcitymary.emissions<-NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
require(dplyr)
baltcitymary.emissions.byyear <- summarise(group_by(baltcitymary.emissions, year), Emissions=sum(Emissions))
require(ggplot2)

png("plot5.png",width=480,height=480)


ggplot(baltcitymary.emissions.byyear, aes(x=factor(year), y=Emissions,fill=year, label = round(Emissions,2))) +
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emissions in tons")) +
  ggtitle("Emissions from motor vehicle sources in Baltimore City")+
  geom_label(aes(fill = year),colour = "white", fontface = "bold")

dev.off()
