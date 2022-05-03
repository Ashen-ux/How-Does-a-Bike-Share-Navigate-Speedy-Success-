install.packages("tidyverse")
install.packages("reader")
install.packages("tidyr")
install.packages("lubridate")
library(lubridate)
library("tidyr")
library(tidyverse)
library(dplyr)
library(reader)

tripdata1 <- read.csv("202101-divvy-tripdata.csv")

head(tripdata1)
colnames(tripdata1)
View(tripdata1)

tripdata_sub1 <- subset(tripdata1, select = c("ride_id","started_at","ended_at","start_station_name","end_station_name","member_casual","rideable_type"))


clean_tripdatasub1 <- tripdata_sub1 %>% filter(ride_id !="") %>%
  filter(started_at!="") %>%
  filter(ended_at!="") %>%
  filter(start_station_name!="") %>%
  filter(end_station_name!="") %>%
  filter(member_casual!="") %>% 
  filter(rideable_type!="")

str(clean_tripdatasub1)

clean_tripdatasub1$started_at <- as.POSIXct(clean_tripdatasub1$started_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
clean_tripdatasub1$ended_at <- as.POSIXct(clean_tripdatasub1$ended_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
View(clean_tripdatasub1)
clean_tripdatasub1 <- clean_tripdatasub1 %>% mutate(ridetime=difftime(ended_at,started_at, units = "mins"))

new_tripdata1 <- clean_tripdatasub1 %>% filter(ridetime > 0)
View(new_tripdata1)


write_csv(new_tripdata1, file="tripdata-2021-1.csv")


