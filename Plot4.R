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


combustion.coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
combustion.coal.sources <- SCC[combustion.coal,]

# Find emissions from coal combustion-related sources
emissions.coal.combustion <- NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]

#we are using the dplyr package for next operation

require(dplyr)
emissions.coal.related <- summarise(group_by(emissions.coal.combustion, year), Emissions=sum(Emissions))

#Make sure ggplot2 is available

require(ggplot2)

png("plot4.png",width=480,height=480)

plot <- ggplot(emissions.coal.related, aes(x=factor(year), y=Emissions/1000,fill=year, label = round(Emissions/1000,2))) +
  geom_bar(stat="identity") +
  #geom_bar(position = 'dodge')+
  # facet_grid(. ~ year) +
  xlab("year") +
  ylab("total PM2.5 emissions in 10^3 Tons") +
  ggtitle("Emissions from coal combustion-related sources in 10^3 Tons")+
  geom_label(aes(fill = year),colour = "white", fontface = "bold")

print(plot)

dev.off()
