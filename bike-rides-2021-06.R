install.packages("tidyverse")
install.packages("reader")
install.packages("tidyr")
install.packages("lubridate")
library(lubridate)
library("tidyr")
library(tidyverse)
library(dplyr)
library(reader)

tripdata06 <- read.csv("202106-divvy-tripdata.csv")

head(tripdata06)
colnames(tripdata06)
View(tripdata06)

tripdata_sub6 <- subset(tripdata06, select = c("ride_id","started_at","ended_at","start_station_name","end_station_name","member_casual","rideable_type"))


clean_tripdatasub6 <- tripdata_sub6 %>% filter(ride_id !="") %>%
  filter(started_at!="") %>%
  filter(ended_at!="") %>%
  filter(start_station_name!="") %>%
  filter(end_station_name!="") %>%
  filter(member_casual!="") %>% 
  filter(rideable_type!="")

str(clean_tripdatasub6)

clean_tripdatasub6$started_at <- as.POSIXct(clean_tripdatasub6$started_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
clean_tripdatasub6$ended_at <- as.POSIXct(clean_tripdatasub6$ended_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
View(clean_tripdatasub6)
clean_tripdatasub6 <- clean_tripdatasub6 %>% mutate(ridetime=difftime(ended_at,started_at, units = "mins"))

new_tripdata06 <- clean_tripdatasub6 %>% filter(ridetime > 0)
View(new_tripdata06)


write_csv(new_tripdata06, file="tripdata-2021-6.csv")
