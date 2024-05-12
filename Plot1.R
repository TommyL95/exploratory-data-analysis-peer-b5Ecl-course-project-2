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

#Calculate the total emissions we want to plot

Total_emissins_in_1999 <- sum(subset(NEI, year == 1999)$Emissions, na.rm = TRUE)
Total_emissins_in_2002 <- sum(subset(NEI, year == 2002)$Emissions, na.rm = TRUE)
Total_emissins_in_2005 <- sum(subset(NEI, year == 2005)$Emissions, na.rm = TRUE)
Total_emissins_in_2008 <- sum(subset(NEI, year == 2008)$Emissions, na.rm = TRUE)

#Put them in a vector

Emissions_to_be_compared <- c(Total_emissins_in_1999,Total_emissins_in_2002,Total_emissins_in_2005,Total_emissins_in_2008)

#Create a vector for the x-axis labels

Years = c(1999, 2002, 2005, 2008)

#Open the graphic device

png("plot1.png",width=480,height=480)

#Create the plot

barplot(
  (Emissions_to_be_compared)/10^6,
  names.arg=Years,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources"
  )

#close the graphic device

dev.off()