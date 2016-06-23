# Set working directory, import libraries, and set common theme
setwd("~/Dropbox/R/Weather")
library(ggplot2)
library(lubridate)
library(RColorBrewer)
library(scales)
library(plyr)
library(gridExtra)
source("z_theme_hmap.r")
source("z_theme.r")

# Acquire data from source file
source("uscities.r")
# weather <- read.csv("sandiego.csv", header=TRUE, stringsAsFactors=FALSE)
city.title="US Cities"

# Convert items in data frame from strings to numeric values
weather$Mean.TemperatureF<-as.numeric(weather$Mean.TemperatureF)
weather$Mean.Humidity<-as.numeric(weather$Mean.Humidity)
weather$CloudCover<-as.numeric(weather$CloudCover)
weather$PrecipitationIn<-as.numeric(weather$PrecipitationIn)
weather$Mean.Sea.Level.PressureIn<-as.numeric(weather$Mean.Sea.Level.PressureIn)
weather$Mean.Wind.SpeedMPH<-as.numeric(weather$Mean.Wind.SpeedMPH)

# Plotting time!
# I strongly recommend 2000 x 2400 if doing 24 cities.

ggplot(subset(weather,!is.na(Mean.TemperatureF)),
       aes(x=as.Date(strftime(Date,format="%j"),"%j"),
           y=year(Date)))+
  geom_tile(aes(fill=Mean.TemperatureF))+
  ylab("Year")+
  xlab("Day")+
  ggtitle(paste("Average Daily Temperature for",city.title))+
  scale_x_date(labels=date_format("%b"))+
  scale_y_reverse()+
  facet_wrap(~city,ncol=4)+
  scale_fill_gradientn(colours=rev(brewer.pal(11,"Spectral")),limits=c(0,100),
                       guide_legend(title="Temp (F)"))+
  z_theme_hmap()

ggplot(subset(weather,!is.na(PrecipitationIn)),
       aes(as.Date(strftime(Date,format="%j"),"%j"),
       year(Date)))+
  geom_tile(aes(fill=PrecipitationIn))+
  ylab("Year")+
  xlab("Day")+
  ggtitle(paste("Daily Precipitation for",city.title))+
  scale_x_date(labels=date_format("%b"))+
  scale_y_reverse()+
  facet_wrap(~city,ncol=4)+
  scale_fill_gradientn(colours=brewer.pal(9,"Blues"),limits=c(0,1),
                       guide_legend(title="Precipitation (in)"))+
  z_theme_hmap()

ggplot(subset(weather,!is.na(CloudCover)&CloudCover>=0),
       aes(as.Date(strftime(Date,format="%j"),"%j"),
           year(Date)))+
  geom_tile(aes(fill=CloudCover))+
  ylab("Year")+
  xlab("Day")+
  ggtitle(paste("Daily Cloud Cover for",city.title))+
  scale_x_date(labels=date_format("%b"))+
  scale_y_reverse(limits=c(2015,1972))+
  facet_wrap(~city,ncol=4)+
  scale_fill_gradientn(colours=brewer.pal(9,"YlGn")[1:6],
                       guide_legend(title="Cloud Cover (Oktas)"))+
  z_theme_hmap()

weather$season <- factor(weather$season, c("Spring","Summer","Autumn","Winter"))
awthr<-ddply(weather,c("city","season"),summarise,Temp=mean(Mean.TemperatureF,na.rm=T),Humid=mean(Mean.Humidity,na.rm=T))
ggplot(weather)+
  geom_jitter(alpha=.1,size=2,aes(x=Mean.TemperatureF,y=Mean.Humidity,color=season))+
  geom_density2d(alpha=.2,color="black",aes(x=Mean.TemperatureF,y=Mean.Humidity))+
  geom_point(size=4,data=awthr,aes(x=Temp,y=Humid,color=season,na.rm=T))+
  geom_point(size=4,pch=1,data=awthr,color="black",aes(x=Temp,y=Humid,color=season,na.rm=T))+
  geom_point(size=8,pch=3,data=awthr,color="black",aes(x=Temp,y=Humid,color=season,na.rm=T))+
  scale_color_manual(values=c(
    "Summer"="#FFBB00",
    "Autumn"="#EE4444",
    "Spring"="#11BB44",
    "Winter"="#4488fF"
  ))+
  ylab("Daily Average Humidity (%)")+
  xlab("Daily Average Temperature (F)")+
  facet_wrap(~city,ncol=4)+
  ggtitle(paste("A Typical Day in",city.title))+
  scale_x_continuous(breaks=seq(-20,100,20))+
  scale_y_continuous(breaks=seq(0,100,20))+
  z_theme()