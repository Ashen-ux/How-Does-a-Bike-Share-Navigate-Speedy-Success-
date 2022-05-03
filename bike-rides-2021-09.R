install.packages("tidyverse")
install.packages("reader")
install.packages("tidyr")
install.packages("lubridate")
library(lubridate)
library("tidyr")
library(tidyverse)
library(dplyr)
library(reader)

tripdata09 <- read.csv("202109-divvy-tripdata.csv")

head(tripdata09)
colnames(tripdata09)
View(tripdata09)

tripdata_sub9 <- subset(tripdata09, select = c("ride_id","started_at","ended_at","start_station_name","end_station_name","member_casual","rideable_type"))


clean_tripdatasub9 <- tripdata_sub9 %>% filter(ride_id !="") %>%
  filter(started_at!="") %>%
  filter(ended_at!="") %>%
  filter(start_station_name!="") %>%
  filter(end_station_name!="") %>%
  filter(member_casual!="") %>% 
  filter(rideable_type!="")

str(clean_tripdatasub9)

clean_tripdatasub9$started_at <- as.POSIXct(clean_tripdatasub9$started_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
clean_tripdatasub9$ended_at <- as.POSIXct(clean_tripdatasub9$ended_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
View(clean_tripdatasub9)
clean_tripdatasub9 <- clean_tripdatasub9 %>% mutate(ridetime=difftime(ended_at,started_at, units = "mins"))

new_tripdata09 <- clean_tripdatasub9 %>% filter(ridetime > 0)
View(new_tripdata09)


write_csv(new_tripdata09, file="tripdata-2021-9.csv")
