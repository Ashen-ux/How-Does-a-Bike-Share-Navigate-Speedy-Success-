install.packages("tidyverse")
install.packages("reader")
install.packages("tidyr")
install.packages("lubridate")
library(lubridate)
library("tidyr")
library(tidyverse)
library(dplyr)
library(reader)

tripdata01 <- read.csv("202104-divvy-tripdata.csv")

head(tripdata01)
colnames(tripdata01)
View(tripdata01)

tripdata_sub <- subset(tripdata01, select = c("ride_id","started_at","ended_at","start_station_name","end_station_name","member_casual","rideable_type"))


clean_tripdatasub <- tripdata_sub %>% filter(ride_id !="") %>%
  filter(started_at!="") %>%
  filter(ended_at!="") %>%
  filter(start_station_name!="") %>%
  filter(end_station_name!="") %>%
  filter(member_casual!="") %>% 
  filter(rideable_type!="")

str(clean_tripdatasub)

clean_tripdatasub$started_at <- as.POSIXct(clean_tripdatasub$started_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
clean_tripdatasub$ended_at <- as.POSIXct(clean_tripdatasub$ended_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
View(clean_tripdatasub)
clean_tripdatasub <- clean_tripdatasub %>% mutate(ridetime=difftime(ended_at,started_at, units = "mins"))

new_tripdata04 <- clean_tripdatasub

new_tripdata04 <- new_tripdata01 %>%  filter(ridetime > 0) %>% unique() %>% select(ride_id, started_at, ended_at, ridetime,rideable_type)

write_csv(new_tripdata04, file="tripdata-2021-4.csv")
View(new_tripdata04)
