setwd("~/Dropbox/R/Weather")
system("echo '' > denver.csv")
for(n in 1945:2015){
  eval(parse(text=paste(
    "system(\"wget -O 'file' 'http://www.wunderground.com/history/airport/KDEN/",
    n,
    "/01/01/CustomHistory.html?dayend=31&monthend=12&yearend=",
    n,
    "&req_city=&req_state=&req_statename=&reqdb.zip=&reqdb.magic=&reqdb.wmo=&format=1'; cat file >> denver.csv\")"
    ,sep="")))
}
weather <- read.csv("denver.csv", header=TRUE, stringsAsFactors=FALSE)
names(weather)[1]<-"Date"
weather$city <- "Denver (CO)"

# Convert dates to ISO 8601 Date Format and mark the seasons
library(lubridate)
weather$Date<-as.Date(weather$Date, format="%Y-%m-%d")
weather<-subset(weather,!is.na(Date))
prog<-nrow(weather)
weather$season=NA
for(n in 1:nrow(weather)){
  if(yday(weather$Date[n])<79){
    weather$season[n]<-"Winter"}
  if(yday(weather$Date[n])>=79 & yday(weather$Date[n])<172){
    weather$season[n]<-"Spring"}
  if(yday(weather$Date[n])>=172 & yday(weather$Date[n])<266){
    weather$season[n]<-"Summer"}
  if(yday(weather$Date[n])>=266 & yday(weather$Date[n])<355){
    weather$season[n]<-"Autumn"}
  if(yday(weather$Date[n])>=355){
    weather$season[n]<-"Winter"}
print(paste(round(n*100/prog,2),"% complete",sep=""))}

write.csv(weather,"denver.csv")
