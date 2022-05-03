install.packages("tidyverse")
install.packages("reader")
install.packages("tidyr")
install.packages("lubridate")
library(lubridate)
library("tidyr")
library(tidyverse)
library(dplyr)
library(reader)

tripdata05 <- read.csv("202105-divvy-tripdata.csv")

head(tripdata05)
colnames(tripdata05)
View(tripdata05)

tripdata_sub <- subset(tripdata05, select = c("ride_id","started_at","ended_at","start_station_name","end_station_name","member_casual","rideable_type"))


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

new_tripdata05 <- clean_tripdatasub %>% filter(ridetime > 0)
View(new_tripdata05)


write_csv(new_tripdata05, file="tripdata-2021-5.csv")