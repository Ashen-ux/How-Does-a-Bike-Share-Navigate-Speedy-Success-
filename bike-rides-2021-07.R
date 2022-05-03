install.packages("tidyverse")
install.packages("reader")
install.packages("tidyr")
install.packages("lubridate")
library(lubridate)
library("tidyr")
library(tidyverse)
library(dplyr)
library(reader)

tripdata07 <- read.csv("202107-divvy-tripdata.csv")

head(tripdata07)
colnames(tripdata07)
View(tripdata07)

tripdata_sub7 <- subset(tripdata07, select = c("ride_id","started_at","ended_at","start_station_name","end_station_name","member_casual","rideable_type"))


clean_tripdatasub7 <- tripdata_sub7 %>% filter(ride_id !="") %>%
  filter(started_at!="") %>%
  filter(ended_at!="") %>%
  filter(start_station_name!="") %>%
  filter(end_station_name!="") %>%
  filter(member_casual!="") %>% 
  filter(rideable_type!="")

str(clean_tripdatasub7)

clean_tripdatasub7$started_at <- as.POSIXct(clean_tripdatasub7$started_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
clean_tripdatasub7$ended_at <- as.POSIXct(clean_tripdatasub7$ended_at, format="%Y-%m-%d %H:%M:%S", tz="UTC")
View(clean_tripdatasub7)
clean_tripdatasub7 <- clean_tripdatasub7 %>% mutate(ridetime=difftime(ended_at,started_at, units = "mins"))

new_tripdata07 <- clean_tripdatasub7 %>% filter(ridetime > 0)
View(new_tripdata07)


write_csv(new_tripdata07, file="tripdata-2021-7.csv")
