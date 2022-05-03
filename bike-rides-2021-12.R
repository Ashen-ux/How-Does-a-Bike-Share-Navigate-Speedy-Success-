install.packages("tidyverse")
install.packages("reader")
install.packages("tidyr")
install.packages("lubridate")
library(lubridate)
library("tidyr")
library(tidyverse)
library(dplyr)
library(reader)

tripdata12 <- read.csv("202112-divvy-tripdata.csv")

head(tripdata12)
colnames(tripdata12)
View(tripdata12)

tripdata_sub12 <- subset(tripdata12, select = c("ride_id","started_at","ended_at","start_station_name","end_station_name","member_casual","rideable_type"))


clean_tripdatasub12 <- tripdata_sub12 %>% filter(ride_id !="") %>%
  filter(started_at!="") %>%
  filter(ended_at!="") %>%
  filter(start_station_name!="") %>%
  filter(end_station_name!="") %>%
  filter(member_casual!="") %>% 
  filter(rideable_type!="")

str(clean_tripdatasub12)

clean_tripdatasub12$started_at <- as.POSIXct(clean_tripdatasub12$started_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
clean_tripdatasub12$ended_at <- as.POSIXct(clean_tripdatasub12$ended_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
View(clean_tripdatasub12)
clean_tripdatasub12 <- clean_tripdatasub12 %>% mutate(ridetime=difftime(ended_at,started_at, units = "mins"))

new_tripdata12 <- clean_tripdatasub12 %>% filter(ridetime > 0)
View(new_tripdata12)


write_csv(new_tripdata12, file="tripdata-2021-12.csv")