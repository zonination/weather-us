# Working Directory
setwd("~/Dropbox/R/Weather")

# Name the city's filename and the code should do the rest.
file.name="pittsburgh"

weather<-read.csv(paste(file.name,".csv",sep=""), header=TRUE, stringsAsFactors=FALSE)
city.title=weather$city[1]

# Import libraries, and set common theme
library(ggplot2)
library(lubridate)
library(RColorBrewer)
library(scales)
library(plyr)
source("z_theme_hmap.r")
source("z_theme.r")

# Convert dates to ISO 8601 Date Format
weather$Date<-as.Date(weather$Date, format="%Y-%m-%d")
# Convert items in data frame from strings to numeric values
weather$Mean.TemperatureF<-as.numeric(weather$Mean.TemperatureF)
weather$Mean.Humidity<-as.numeric(weather$Mean.Humidity)
weather$CloudCover<-as.numeric(weather$CloudCover)
weather$PrecipitationIn<-as.numeric(weather$PrecipitationIn)
weather$Mean.Sea.Level.PressureIn<-as.numeric(weather$Mean.Sea.Level.PressureIn)
weather$Mean.Wind.SpeedMPH<-as.numeric(weather$Mean.Wind.SpeedMPH)
weather<-subset(weather,Mean.TemperatureF>=-99)

# Time to make some pretty pictures.
# Use this code only for US cities. Comment out if doing international.
# International code can be found further down.

# Recommend 1000 x 600 output file.
png(file=paste(file.name,"-1temp.png",sep=""), width = 1000, height = 600)
ggplot(subset(weather,!is.na(Mean.TemperatureF)),
       aes(x=as.Date(strftime(Date,format="%j"),"%j"),
           y=year(Date)))+
  geom_tile(aes(fill=Mean.TemperatureF))+
  ylab("Year")+
  xlab("Day")+
  ggtitle(paste("Average Daily Temperature for",city.title))+
  scale_x_date(labels=date_format("%b"))+
  scale_y_reverse()+
  scale_fill_gradientn(colours=rev(brewer.pal(11,"Spectral")),limits=c(0,100),
                       guide_legend(title="Temp (F)"))+
  z_theme_hmap()
dev.off()

png(file=paste(file.name,"-3precip.png",sep=""), width = 1000, height = 600)
ggplot(subset(weather,!is.na(PrecipitationIn)),
       aes(as.Date(strftime(Date,format="%j"),"%j"),
           year(Date)))+
  geom_tile(aes(fill=PrecipitationIn))+
  ylab("Year")+
  xlab("Day")+
  ggtitle(paste("Daily Precipitation for",city.title))+
  scale_x_date(labels=date_format("%b"))+
  scale_y_reverse()+
  scale_fill_gradientn(colours=brewer.pal(9,"Blues"),limits=c(0,1),
                       guide_legend(title="Precipitation (in)"))+
  z_theme_hmap()
dev.off()

png(file=paste(file.name,"-4cloud.png",sep=""), width = 1000, height = 600)
ggplot(subset(weather,!is.na(CloudCover)&CloudCover>=0),
       aes(as.Date(strftime(Date,format="%j"),"%j"),
           year(Date)))+
  geom_tile(aes(fill=CloudCover))+
  ylab("Year")+
  xlab("Day")+
  ggtitle(paste("Daily Cloud Cover for",city.title))+
  scale_x_date(labels=date_format("%b"))+
  scale_y_reverse(limits=c(2015,1972))+
  scale_fill_gradientn(colours=brewer.pal(9,"YlGn")[1:6],
                       guide_legend(title="Cloud Cover (Oktas)"))+
  z_theme_hmap()
dev.off()

png(file=paste(file.name,"-2daily.png",sep=""), width = 1000, height = 600)
weather$season <- factor(weather$season, c("Spring","Summer","Autumn","Winter"))
awthr<-ddply(weather,c("city","season"),summarise,Temp=mean(Mean.TemperatureF,na.rm=T),Humid=mean(Mean.Humidity,na.rm=T))
ggplot(weather)+
  geom_jitter(alpha=.1,size=3,aes(x=Mean.TemperatureF,y=Mean.Humidity,color=season))+
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
  ggtitle(paste("A Typical Day in",city.title))+
  z_theme()
dev.off()

#--------------------+
# International code |
#--------------------+

# International Special: Convert temp into Celsius
# weather$Mean.TemperatureF<-(weather$Mean.TemperatureF-32)*5/9
# 
# png(file=paste(file.name,"-1temp.png",sep=""), width = 1000, height = 600)
# ggplot(subset(weather,!is.na(Mean.TemperatureF)),
#        aes(x=as.Date(strftime(Date,format="%j"),"%j"),
#            y=year(Date)))+
#   geom_tile(aes(fill=Mean.TemperatureF))+
#   ylab("Year")+
#   xlab("Day")+
#   ggtitle(paste("Average Daily Temperature for",city.title))+
#   scale_x_date(labels=date_format("%b"))+
#   scale_y_reverse()+
#   scale_fill_gradientn(colours=rev(brewer.pal(11,"Spectral")),limits=c(-20,40),
#                        guide_legend(title="Temp (C)"))+
#   z_theme_hmap()
# dev.off()
# 
# png(file=paste(file.name,"-3cloud.png",sep=""), width = 1000, height = 600)
# ggplot(subset(weather,!is.na(CloudCover)&CloudCover>=0),
#        aes(as.Date(strftime(Date,format="%j"),"%j"),
#            year(Date)))+
#   geom_tile(aes(fill=CloudCover))+
#   ylab("Year")+
#   xlab("Day")+
#   ggtitle(paste("Daily Cloud Cover for",city.title))+
#   scale_x_date(labels=date_format("%b"))+
#   scale_y_reverse(limits=c(2015,1996))+
#   scale_fill_gradientn(colours=brewer.pal(9,"YlGn")[1:6],
#                        guide_legend(title="Cloud Cover (Oktas)"))+
#   z_theme_hmap()
# dev.off()
# 
# png(file=paste(file.name,"-2daily.png",sep=""), width = 1000, height = 600)
# weather$season <- factor(weather$season, c("Spring","Summer","Autumn","Winter"))
# awthr<-ddply(weather,c("city","season"),summarise,Temp=mean(Mean.TemperatureF,na.rm=T),Humid=mean(Mean.Humidity,na.rm=T))
# ggplot(weather)+
#   geom_jitter(alpha=.2,size=4,aes(x=Mean.TemperatureF,y=Mean.Humidity,color=season))+
#   geom_density2d(alpha=.2,color="black",aes(x=Mean.TemperatureF,y=Mean.Humidity))+
#   geom_point(size=4,data=awthr,aes(x=Temp,y=Humid,color=season,na.rm=T))+
#   geom_point(size=4,pch=1,data=awthr,color="black",aes(x=Temp,y=Humid,color=season,na.rm=T))+
#   geom_point(size=8,pch=3,data=awthr,color="black",aes(x=Temp,y=Humid,color=season,na.rm=T))+
#   scale_color_manual(values=c(
#     "Summer"="#FFBB00",
#     "Autumn"="#EE4444",
#     "Spring"="#11BB44",
#     "Winter"="#4488fF"
#   ))+
#   ylab("Daily Average Humidity (%)")+
#   xlab("Daily Average Temperature (C)")+
#   ggtitle(paste("A Typical Day in",city.title))+
#   z_theme()
# dev.off()