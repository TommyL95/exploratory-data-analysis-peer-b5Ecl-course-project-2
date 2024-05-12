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

#Create a vector containing the data we need

PM2.5_Baltimore <- c(
  sum(subset(NEI, year == 1999 & fips == "24510")$Emissions, na.rm = TRUE),
  sum(subset(NEI, year == 2008 & fips == "24510")$Emissions, na.rm = TRUE)
  )

#Open the graphic device

png("plot2.png",width=480,height=480)

#Create the plot

barplot(PM2.5_Baltimore, 
        names.arg = c(1999, 2008), 
        xlab = "Year", 
        ylab = "PM2.5 Emissions (in Tons)", 
        main = "Total PM2.5 Emissions From all Sources, Baltimore, Maryland")

#Close the graphic device

dev.off()