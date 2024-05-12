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

# Subset NEI data by Baltimore's fip.
BaltimoreData <- NEI[NEI$fips=="24510",]


png("plot3.png",width=480,height=480)

library(ggplot2)

ggp <- ggplot(BaltimoreData,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") +
  labs(x="year", y="Total PM2.5 Emission (Tons)") +
  labs(title="PM 2.5 Emissions, Baltimore City 1999-2008 by Source Type")

print(ggp)

dev.off()