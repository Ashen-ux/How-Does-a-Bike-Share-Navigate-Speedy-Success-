install.packages("tidyverse")
install.packages("reader")
install.packages("tidyr")
install.packages("lubridate")
library(lubridate)
library("tidyr")
library(tidyverse)
library(dplyr)
library(reader)

tripdata10 <- read.csv("202110-divvy-tripdata.csv")

head(tripdata10)
colnames(tripdata10)
View(tripdata10)

tripdata_sub10 <- subset(tripdata10, select = c("ride_id","started_at","ended_at","start_station_name","end_station_name","member_casual","rideable_type"))


clean_tripdatasub10 <- tripdata_sub10 %>% filter(ride_id !="") %>%
  filter(started_at!="") %>%
  filter(ended_at!="") %>%
  filter(start_station_name!="") %>%
  filter(end_station_name!="") %>%
  filter(member_casual!="") %>% 
  filter(rideable_type!="")

str(clean_tripdatasub10)

clean_tripdatasub10$started_at <- as.POSIXct(clean_tripdatasub10$started_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
clean_tripdatasub10$ended_at <- as.POSIXct(clean_tripdatasub10$ended_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
View(clean_tripdatasub10)
clean_tripdatasub10 <- clean_tripdatasub10 %>% mutate(ridetime=difftime(ended_at,started_at, units = "mins"))

new_tripdata10 <- clean_tripdatasub10 %>% filter(ridetime > 0)
View(new_tripdata10)


write_csv(new_tripdata10, file="tripdata-2021-10.csv")
