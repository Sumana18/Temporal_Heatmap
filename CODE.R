require(ggplot2)
require(ggmap)
require(RColorBrewer)

setwd("D:/Sumana_module3/heatmap")

crime.data <- read.csv("crime.csv")
crime.data
subset.crime.data <- subset(crime.data,YEAR >= 2003)
subset.crime.data$YEAR <- as.factor (subset.crime.data$YEAR)
mean.longitude <- mean(subset.crime.data$Longitude)
mean.latitude <- mean(subset.crime.data$Latitude)
crime.map <- get_map(location = c(mean.longitude,mean.latitude), zoom = 9, scale = 2)
crime.map <- ggmap(crime.map, extent = "device", legend = "none")

crime.map <- crime.map+ stat_density2d(data = subset.crime.data,aes(x=Longitude, y=Latitude, fill=..level.., alpha=..level..), geom="polygon")
crime.map <- crime.map + scale_fill_gradientn(colours=rev(brewer.pal(7, "Spectral")))
crime.map

crime.map <- crime.map + geom_point(data=subset.crime.data,aes(x=Longitude, y=Latitude), fill="red", shape=21, alpha=0.8)
crime.map <- crime.map + guides(size=FALSE, alpha = FALSE)
crime.map <- crime.map + ggtitle("crime in vancouver city")
crime.map <- crime.map + facet_wrap(~YEAR) + theme_bw() 
print(crime.map)