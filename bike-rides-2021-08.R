install.packages("tidyverse")
install.packages("reader")
install.packages("tidyr")
install.packages("lubridate")
library(lubridate)
library("tidyr")
library(tidyverse)
library(dplyr)
library(reader)

tripdata08 <- read.csv("202108-divvy-tripdata.csv")

head(tripdata08)
colnames(tripdata08)
View(tripdata08)

tripdata_sub8 <- subset(tripdata08, select = c("ride_id","started_at","ended_at","start_station_name","end_station_name","member_casual","rideable_type"))


clean_tripdatasub8 <- tripdata_sub8 %>% filter(ride_id !="") %>%
  filter(started_at!="") %>%
  filter(ended_at!="") %>%
  filter(start_station_name!="") %>%
  filter(end_station_name!="") %>%
  filter(member_casual!="") %>% 
  filter(rideable_type!="")

str(clean_tripdatasub8)

clean_tripdatasub8$started_at <- as.POSIXct(clean_tripdatasub8$started_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
clean_tripdatasub8$ended_at <- as.POSIXct(clean_tripdatasub8$ended_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
View(clean_tripdatasub8)
clean_tripdatasub8 <- clean_tripdatasub8 %>% mutate(ridetime=difftime(ended_at,started_at, units = "mins"))

new_tripdata08 <- clean_tripdatasub8 %>% filter(ridetime > 0)
View(new_tripdata08)


write_csv(new_tripdata08, file="tripdata-2021-8.csv")
